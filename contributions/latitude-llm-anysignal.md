[🇬🇧 English](latitude-llm-anysignal.md) | [🇮🇩 Bahasa Indonesia](latitude-llm-anysignal.id.md)

# latitude-dev/latitude-llm — Eliminate AbortSignal race condition in anySignal()

## Context

Latitude is an open-source LLM evaluation platform (4.3k+ stars). Their TypeScript SDK had an `anySignal()` utility that combined multiple AbortSignals into one. This utility had the same race condition found in `fern-api/fern` — a Node.js platform-level gap in AbortSignal semantics.

## Problem (Root Cause)

`anySignal()` had a race condition: if a source signal aborts between the `signal.aborted` check and the `addEventListener("abort", …)` call, the abort event is already dispatched and the listener never fires. In Node.js, adding an "abort" listener to an already-aborted AbortSignal does NOT fire the callback synchronously. The combined signal stays unaborted indefinitely — timeouts and cancellation stop working.

## Approach

Re-check `signal.aborted` immediately after `addEventListener`. If the signal aborted during the registration window, manually propagate the abort to the combined controller. Also replaces `break` with `return controller.signal` to avoid useless iteration after the combined signal is already aborted.

## Impact

- 103 additions, 1 deletion across 2 files
- Fix confirmed in 4 test scenarios: happy path, already-aborted on entry, mid-registration-window abort (was BROKEN), and `getTimeoutSignal` compatibility
- Accepts both spread and array arguments

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `packages/sdk/typescript/src/core/fetcher/signals.ts` | +35 | -1 |
| `packages/sdk/typescript/src/core/fetcher/signals.test.ts` | +68 | -0 |

## Links

- PR: [latitude-dev/latitude-llm#3336](https://github.com/latitude-dev/latitude-llm/pull/3336)
