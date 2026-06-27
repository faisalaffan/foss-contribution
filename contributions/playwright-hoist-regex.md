[🇬🇧 English](playwright-hoist-regex.md) | [🇮🇩 Bahasa Indonesia](playwright-hoist-regex.id.md)

# microsoft/playwright — Hoist regex constants to module scope

## Context

Playwright is Microsoft's browser automation framework (91.7k+ stars). The `setUserAgent()` path and HAR cookie parser recompile the same regex literals on every invocation, creating unnecessary garbage and CPU work.

## Problem (Root Cause)

Two hot paths recompile regex on every call:

- **`calculateUserAgentMetadata`** — 5 regex patterns recompiled per `page.setUserAgent()` call for Android version, iOS version, iPad OS version, macOS version, and Windows version parsing
- **`parseCookie`** — `;/ */` recompiled per `Set-Cookie` header during HAR trace recording

## Approach

Hoisted all 6 regex literals to module-level `const` with descriptive names (`ANDROID_VERSION_RE`, `IPHONE_OS_VERSION_RE`, `IPAD_OS_VERSION_RE`, `MAC_OS_VERSION_RE`, `WINDOWS_VERSION_RE`, `SEMICOLON_SPLIT_RE`). Single allocation at import time, reused across all calls.

## Impact

- 14 additions, 6 deletions across 2 files
- Regex objects allocated once at module load instead of per-invocation
- Zero behavior change — pure performance optimization

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `packages/playwright-core/src/server/chromium/crPage.ts` | +12 | -4 |
| `packages/playwright-core/src/server/har/harTracer.ts` | +2 | -2 |

## Links

- PR: [microsoft/playwright#41501](https://github.com/microsoft/playwright/pull/41501)
