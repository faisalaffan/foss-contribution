[🇬🇧 English](nuxt-url-trycatch.md) | [🇮🇩 Bahasa Indonesia](nuxt-url-trycatch.id.md)

# nuxt/nuxt — Wrap `new URL()` in try-catch at 6 call sites

## Context

Nuxt handles many user-supplied URLs and paths across its routing layer: `navigateTo()` accepts arbitrary strings, `<NuxtLink>` renders user-provided `to` values, and internal utilities parse redirect targets. At six locations in the codebase, `new URL()` is called directly on these untrusted inputs — a malformed string causes an unhandled `TypeError` that crashes navigation, breaks component rendering, or silently fails background operations.

## Problem (Root Cause)

**`new URL()` throws synchronously on invalid input with no fallback.** The WHATWG URL constructor has strict parsing semantics: values like `"http://a b.com"` (space in hostname) or `"not a url at all"` throw `TypeError: Invalid URL`. None of the six call sites wrap the constructor in error handling, so malformed user input propagates as an unhandled exception with no recovery path and no clear error message.

## Approach

Each call site gets a fit-for-purpose fallback strategy:

| Call Site | File | Strategy |
|-----------|------|----------|
| `navigateTo()` open handler | `router.ts:159` | Catch → throw descriptive `Error` showing the bad input |
| `navigateTo()` external URL | `router.ts:183` | Catch → throw descriptive `Error` showing the bad input |
| `encodeURL()` redirect encoder | `router.ts:344` | Catch → return raw input as-is (transparent no-op) |
| `<NuxtLink>` prefetch | `nuxt-link.ts:422` | Catch → return raw path (best-effort, no crash) |
| `<NuxtLink>` slot route getter | `nuxt-link.ts:530` | Catch → return `undefined` (graceful degrade) |
| `_getPayloadURL()` | `payload.ts:79` | Catch → throw descriptive `Error` (debug-friendly) |

User-facing paths throw descriptive errors so the developer knows exactly what went wrong. Internal utilities degrade gracefully — returning raw input or `undefined` so the rest of the pipeline handles the absence.

## Impact

- Prevents blank-page crashes from user typos or malformed URLs
- 15 test assertions covering happy path and edge cases across all six call sites
- Bundle size test updated to account for the new `try/catch` wrapper in `encodeRoutePath`

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `packages/nuxt/src/app/components/nuxt-link.ts` | +6 | -2 |
| `packages/nuxt/src/app/composables/payload.ts` | +2 | -1 |
| `packages/nuxt/src/app/composables/router.ts` | +7 | -4 |
| `packages/nuxt/src/app/utils.ts` | +18 | -0 |
| `packages/nuxt/test/url-try-catch.test.ts` | +109 | -0 |
| `test/bundle.test.ts` | +2 | -2 |

## Links

- PR: [nuxt/nuxt#35449](https://github.com/nuxt/nuxt/pull/35449)
