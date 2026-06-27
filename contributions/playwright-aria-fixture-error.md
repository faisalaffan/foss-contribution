[🇬🇧 English](playwright-aria-fixture-error.md) | [🇮🇩 Bahasa Indonesia](playwright-aria-fixture-error.id.md)

# microsoft/playwright — Improve error handling for ariaSnapshot and fixture integrity

## Context

Playwright is Microsoft's browser automation framework (91.7k+ stars). Silent error swallowing in the test runner makes debugging failures harder — two specific cases were swallowing critical signals.

## Problem (Root Cause)

- **ariaSnapshot:** Empty `catch {}` block silently discards all AI snapshot failures, making test-error debugging impossible when the snapshot mechanism itself breaks
- **fixtureRunner:** `console.error` + silent `_usages.clear()` on fixture integrity violations corrupts internal state instead of failing fast — test workers continue with broken fixture state

## Approach

- Replace empty `catch {}` in ariaSnapshot with `debugLogger.log(...)` so AI snapshot failures are traceable
- Replace `console.error` + silent state mutation in fixtureRunner with `throw new Error(...)` — fixture integrity violations now fail fast

## Impact

- 6 additions, 6 deletions across 2 files
- AI snapshot failures become debuggable via debug logger
- Fixture integrity violations fail fast instead of silently corrupting worker state

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `packages/playwright/src/index.ts` | +4 | -4 |
| `packages/playwright/src/worker/fixtureRunner.ts` | +2 | -2 |

## Links

- PR: [microsoft/playwright#41502](https://github.com/microsoft/playwright/pull/41502)
