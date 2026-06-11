[🇬🇧 English](stdlib-js-stdlib.md) | [🇮🇩 Bahasa Indonesia](stdlib-js-stdlib.id.md)

# stdlib-js/stdlib — Add `stats/incr/nanminabs`

## Context

[stdlib-js/stdlib](https://github.com/stdlib-js/stdlib) is a standard library for JavaScript and Node.js, providing high-performance mathematical, statistical, and data processing utilities. The `@stdlib/stats/incr` namespace provides incremental accumulators — stateful functions that efficiently compute statistics over streaming data.

The library already had `nanminabs` (minimum absolute value ignoring NaN) but was missing its incremental counterpart. Three related issues (#5552, #5637) had been open requesting this feature.

## Contribution

Implemented `@stdlib/stats/incr/nanminabs` — an incremental accumulator that tracks the minimum absolute value across a stream of numeric inputs while silently skipping `NaN` values instead of propagating them.

Key design decisions:
- Thin wrapper pattern, consistent with existing accumulators like `@stdlib/stats/incr/nansum`
- Returns `null` when all inputs so far have been NaN (consistent with empty-state behavior)
- Signed-zero convention: `-0` and `+0` treated as equal
- Full test suite (125 lines), benchmarks (6/6), examples, TypeScript declarations, and REPL docs

This is a revised version of PR #5637, which had review feedback unaddressed on package name, description wording, and format string.

## Impact

- New package: `@stdlib/stats/incr/nanminabs`
- Resolves #5552 and supersedes #5637
- 10 files, 738 additions

## Files Changed

| File | Additions |
|------|-----------|
| `lib/main.js` | +77 |
| `test/test.js` | +125 |
| `README.md` | +143 |
| `benchmark/benchmark.js` | +69 |
| `docs/repl.txt` | +32 |
| `docs/types/index.d.ts` | +62 |
| `docs/types/test.ts` | +61 |
| `examples/index.js` | +43 |
| `lib/index.js` | +57 |
| `package.json` | +69 |

## Links

- PR: [stdlib-js/stdlib#12246](https://github.com/stdlib-js/stdlib/pull/12246)
- Issues: [#5552](https://github.com/stdlib-js/stdlib/issues/5552), [#5637](https://github.com/stdlib-js/stdlib/pull/5637)
