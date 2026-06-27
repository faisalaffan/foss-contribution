[🇬🇧 English](playwright-async-dispose.md) | [🇮🇩 Bahasa Indonesia](playwright-async-dispose.id.md)

# microsoft/playwright — Remove unused async from eventsHelper dispose callback

## Context

Playwright is Microsoft's browser automation framework (91.7k+ stars). The `eventsHelper` module wraps Node.js `EventEmitter` with a `RegisteredListener` that has a `dispose()` method. This method was typed as `async` but the underlying `emitter.removeListener()` is synchronous — creating an unnecessary Promise and microtask on every cleanup.

## Problem (Root Cause)

`emitter.removeListener()` is synchronous. Wrapping the dispose callback in `async` creates an unnecessary Promise and microtask on every listener cleanup. Zero callers `await` the dispose result — the `async` keyword provides no value, only overhead.

## Approach

- `RegisteredListener.dispose`: `() => Promise<void>` → `() => void`
- `Disposable.dispose` in isomorphic/disposable.ts: same type change for assignability
- Remove `async` keyword from the dispose arrow function

## Impact

- 3 additions, 3 deletions across 2 files
- Eliminates Promise allocation and microtask per listener cleanup
- Zero behavior change — no caller awaited the result

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `packages/isomorphic/disposable.ts` | +1 | -1 |
| `packages/utils/eventsHelper.ts` | +2 | -2 |

## Links

- PR: [microsoft/playwright#41503](https://github.com/microsoft/playwright/pull/41503)
