[🇬🇧 English](fern-api-fern.md) | [🇮🇩 Bahasa Indonesia](fern-api-fern.id.md)

# fern-api/fern — Report `anySignal()` Race Condition in TypeScript SDK Generator

## Context

[fern-api/fern](https://github.com/fern-api/fern) is an SDK generator that produces idiomatic client libraries from API definitions. The TypeScript SDK generator produces a `signals.ts` helper used by every generated SDK for request cancellation and timeout handling.

The generated `anySignal()` function combines multiple `AbortSignal` instances into one. It had a race condition where an abort event could be silently dropped — breaking timeouts and user-initiated cancellation across all generated TypeScript SDKs.

## Contribution

Identified, reproduced, and reported a race condition in `anySignal()` where a source signal aborting between the `signal.aborted` check and `addEventListener("abort", …)` call is permanently lost. The combined signal stays unaborted indefinitely.

Root cause: Node.js does NOT fire "abort" listener callbacks synchronously when added to an already-aborted signal. The gap between the `aborted` check and listener registration creates a window where aborts are silently dropped.

Provided:
- Minimal reproduction using `Proxy` to trigger the exact race window
- Root cause analysis with Node.js event loop behavior documentation
- Downstream fix in `latitude-dev/latitude-llm` with full test suite (PR #3336)
- Fix strategy: re-check `signal.aborted` immediately after `addEventListener`, propagate manually if aborted during registration window

## Impact

- Affects ALL generated TypeScript SDKs using `anySignal()` (timeouts, cancellation)
- Fix must live in the Fern generator — consumer patches are overwritten on every SDK regeneration
- Downstream fix validated with 5 test cases covering happy path, already-aborted, race window, timeout signal, and variadic arguments

## Links

- Issue: [fern-api/fern#16151](https://github.com/fern-api/fern/issues/16151)
- Downstream fix: [latitude-dev/latitude-llm#3336](https://github.com/latitude-dev/latitude-llm/pull/3336)
