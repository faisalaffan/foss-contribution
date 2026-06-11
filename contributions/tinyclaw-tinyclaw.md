[🇬🇧 English](tinyclaw-tinyclaw.md) | [🇮🇩 Bahasa Indonesia](tinyclaw-tinyclaw.id.md)

# tinyclaw/tinyclaw — Add PathGuard to prevent path traversal in write_file/delete_file

## Context

tinyclaw is an AI coding agent CLI. Tools like `write_file` and `delete_file` accept file paths directly from LLM output with no validation — the agent can write or delete files anywhere on the filesystem.

## Problem (Root Cause)

**Agent tools trust LLM output as safe input.** The `write_file` and `delete_file` tools pass LLM-provided file paths directly to `fs.writeFileSync` / `fs.rmSync` without any boundary check. An attacker can:

- Instruct the AI via prompt injection to write `~/.ssh/authorized_keys` — **SSH backdoor**
- Delete critical system files (`/etc/...`) — **OS corruption**
- Overwrite tinyclaw's own config files — **hijack provider/API keys**
- Write to `/etc/cron.d/` — **persistent remote code execution**
- Traverse out of the working directory using `../` — **path traversal**

The same class of vulnerability hit OpenClaw (the project tinyclaw draws inspiration from) multiple times — resulting in 3 CVEs/GHSAs (GHSA-qrq5-wjgg-rvqw, GHSA-xwjm-j929-xq7c, GHSA-cv7m-c9jx-vg7q) and a critical issue (#39672). This eventually led them to create a dedicated library (`@openclaw/fs-safe`) for path safety.

## Approach

Added a `guardFilePath()` function that validates every file path before any fs operation:

- **Resolves symlinks** — prevents symlink-based escapes pointing outside allowed directories
- **Rejects null bytes** — prevents null-byte injection to mask file extensions
- **Blocks special files** — rejects paths under `/dev/`, `/proc/`, `/sys/`
- **Canonicalizes paths** — resolves `../` and `./` before validation
- **Validates against allowed directories** — path must stay within permitted boundaries

LLM-provided `cwd` is also validated against allowed directories, falling back to a safe default if rejected.

Maximum file size enforced (10 MB default) to prevent disk-exhaustion DoS.

## Impact

- All `write_file` and `delete_file` calls now pass through path validation
- 10 dedicated security tests covering: path traversal, null bytes, symlinks, special files, and cwd validation
- Same protection level as `@openclaw/fs-safe` — the library OpenClaw built after their incidents

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `packages/core/src/tools/paths.ts` | +47 | -0 |
| `packages/core/src/tools/builtin.ts` | +24 | -4 |
| `packages/core/src/tools/builtin.test.ts` | +134 | -0 |

## Links

- PR: [ahmadrosid/tinyclaw#4](https://github.com/ahmadrosid/tinyclaw/pull/4)
- Prior art: [GHSA-qrq5-wjgg-rvqw](https://github.com/openclaw/openclaw/security/advisories/GHSA-qrq5-wjgg-rvqw)
- Prior art: [openclaw/openclaw#39672](https://github.com/openclaw/openclaw/issues/39672)
