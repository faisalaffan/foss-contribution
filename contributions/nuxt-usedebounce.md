[🇬🇧 English](nuxt-usedebounce.md) | [🇮🇩 Bahasa Indonesia](nuxt-usedebounce.id.md)

# nuxt/nuxt — Add `useDebounce` composable

## Context

Nuxt is the full-stack Vue framework (60.5k+ stars). Every Nuxt developer needs debouncing for search inputs, resize handlers, and form validation, but the ecosystem lacks a built-in solution. Currently developers either install `@vueuse/core` (60KB extra) just for `refDebounced`, use `lodash.debounce` (not reactive), or write manual `setTimeout`/`clearTimeout` boilerplate in every component.

## Problem (Root Cause)

**No built-in debounce utility in Nuxt core.** The framework auto-imports many composables (`useState`, `useFetch`, `useCookie`, `useAsyncData`), but debouncing — a fundamental reactive pattern used in nearly every application — requires third-party dependencies or ad-hoc boilerplate.

## Approach

Added `useDebounce` to Nuxt core composables:

- **Zero dependencies** — built on `setTimeout`/`clearTimeout` and Vue's `ref`/`watch`
- **Auto-imported** — registered in Nuxt's import presets, available in every component without explicit import
- **SSR-safe** — returns initial value immediately on server (no debounce needed)
- **Reactive input** — accepts `Ref<T>` or getter function `() => T`
- **Configurable delay** — second argument in milliseconds (default 300ms)
- **Self-cleaning** — timer automatically disposed on scope destruction via `onScopeDispose`

Source ref changes → `setTimeout` scheduled → another change before timeout → timer reset → delay ms of inactivity → debounced ref updated to latest value.

## Impact

- Removes 60KB `@vueuse/core` dependency for the common debounce use case
- Consistent API across all Nuxt apps — no more ad-hoc solutions per project
- 9 tests covering: initial value, delayed update, premature-no-update, rapid-fire last-value-only, ms=0 immediate, timer cleanup on scope dispose

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `packages/nuxt/src/app/composables/debounce.ts` | +29 | -0 |
| `packages/nuxt/src/app/composables/index.ts` | +1 | -0 |
| `packages/nuxt/src/imports/presets.ts` | +4 | -0 |
| `packages/nuxt/test/debounce.test.ts` | +154 | -0 |

## Links

- PR: [nuxt/nuxt#35453](https://github.com/nuxt/nuxt/pull/35453)
- Nuxt composables: [docs](https://nuxt.com/docs/guide/directory-structure/composables)
