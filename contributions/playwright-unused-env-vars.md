[🇬🇧 English](playwright-unused-env-vars.md) | [🇮🇩 Bahasa Indonesia](playwright-unused-env-vars.id.md)

# microsoft/playwright — Remove unused env var flags

## Context

Playwright is Microsoft's browser automation framework (91.7k+ stars). The codebase has accumulated dead env-var feature flags that were gating code paths no longer reachable. These flags create maintenance burden — every reader must check whether the flag is set somewhere before touching the guarded code.

## Problem (Root Cause)

Three environment variable flags with no remaining setters:

- **`PLAYWRIGHT_LEGACY_SCREENSHOT`** — ternary defaulting to a CDP flag; the `''` branch never executes
- **`PW_CODEGEN_NO_INSPECTOR`** — two early-return guards in recorder; dead since a Jul 2025 refactor
- **`PW_DETECT_NESTED_PROGRESS`** — debug-only nested race detection block, plus cascading dead vars (`outerProgress`, `allowConcurrent`, `setAllowConcurrentOrNestedRaces`)

## Approach

Removed all three env var checks, the dead branches they guarded, and the cascading dead variables that only existed to support those branches. Pure deletion — no behavior change.

## Impact

- 26 lines deleted across 3 files
- Removes cognitive overhead of dead feature flags
- Zero risk — flags confirmed absent from all docs, configs, CI, and source

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `packages/playwright-core/src/server/chromium/chromiumSwitches.ts` | +2 | -4 |
| `packages/playwright-core/src/server/progress.ts` | +0 | -18 |
| `packages/playwright-core/src/server/recorder/recorderApp.ts` | +0 | -4 |

## Links

- PR: [microsoft/playwright#41500](https://github.com/microsoft/playwright/pull/41500)
