[🇬🇧 English](README.md) | [🇮🇩 Bahasa Indonesia](README.id.md)

# Open Source Contributions

Contributions to projects I use in production.

---

## Non-Trivial Contributions

Significant features, architectural changes, or non-obvious bug fixes.

| No | Project       | Language | Type    | Description                                             | Status     | Link                                                     | Study Case                                                | PR Date      |
| -- | ------------- | -------- | ------- | ------------------------------------------------------- | ---------- | -------------------------------------------------------- | ----------------------------------------------------- | ------------ |
| 10 | [microsoft/playwright](https://github.com/microsoft/playwright) | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🐛 Bug Fix  | Replace empty catch{} in ariaSnapshot with debugLogger; throw on fixture integrity violations | ⏳ Pending | [PR #41502](https://github.com/microsoft/playwright/pull/41502) | [Detail](contributions/playwright-aria-fixture-error.md) | 27 Jun 2026 |
| 9  | [grafana/pyroscope](https://github.com/grafana/pyroscope)   | [Go](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Go.md) | ✨ Feature  | Add input validation for units and aggregationType in ingest handler — 72 tests | ⏳ Pending | [PR #5293](https://github.com/grafana/pyroscope/pull/5293) | [Detail](contributions/pyroscope-ingest-validation.md) | 26 Jun 2026 |
| 8  | [grafana/pyroscope](https://github.com/grafana/pyroscope)   | [Go](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Go.md) | 🔧 Refactor | Remove deprecated receivedDecompressedBytes metric superseded by _total variant | ⏳ Pending | [PR #5292](https://github.com/grafana/pyroscope/pull/5292) | [Detail](contributions/pyroscope-deprecated-metric.md) | 26 Jun 2026 |
| 7  | [latitude-dev/latitude-llm](https://github.com/latitude-dev/latitude-llm) | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🐛 Bug Fix  | Fix anySignal() race condition — re-check signal.aborted after addEventListener | ❌ Closed | [PR #3336](https://github.com/latitude-dev/latitude-llm/pull/3336) | [Detail](contributions/latitude-llm-anysignal.md) | 30 May 2026 |
| 6  | [nuxt/nuxt](https://github.com/nuxt/nuxt)                 | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | ✨ Feature  | Add `useDebounce` composable — reactive debouncing, auto-imported, SSR-safe | ⏳ Pending | [PR #35453](https://github.com/nuxt/nuxt/pull/35453) | [Detail](contributions/nuxt-usedebounce.md) | 26 Jun 2026 |
| 5  | [nuxt/nuxt](https://github.com/nuxt/nuxt)                 | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🐛 Bug Fix  | Wrap `new URL()` in try-catch at 6 call sites to prevent crashes on invalid input | ⏳ Pending | [PR #35449](https://github.com/nuxt/nuxt/pull/35449) | [Detail](contributions/nuxt-url-trycatch.md) | 26 Jun 2026 |
| 4  | [ahmadrosid/tinyclaw](https://github.com/ahmadrosid/tinyclaw) | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🔒 Security | Add PathGuard to prevent path traversal in write_file/delete_file | ✅ Merged | [PR #4](https://github.com/ahmadrosid/tinyclaw/pull/4) | [Detail](contributions/tinyclaw-tinyclaw.md) | 4 Jun 2026 |
| 3  | [fern-api/fern](https://github.com/fern-api/fern)           | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🐛 Bug Fix  | Fix `anySignal()` race condition between aborted check and addEventListener | ❌ Closed | [PR #16153](https://github.com/fern-api/fern/pull/16153) | [Detail](contributions/fern-api-fern.md) | 1 Jun 2026 |
| 2  | [stdlib-js/stdlib](https://github.com/stdlib-js/stdlib)     | [JavaScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/JavaScript.md) | ✨ Feature  | Add `stats/incr/nanminabs` — incremental minimum absolute value ignoring NaN | ⏳ Pending | [PR #12246](https://github.com/stdlib-js/stdlib/pull/12246) | [Detail](contributions/stdlib-js-stdlib.md) | 22 May 2026 |
| 1  | [ollama/ollama](https://github.com/ollama/ollama)           | [Go](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Go.md)       | 🐛 Bug Fix  | Guard nil spinner in push handler after successful push | ⏳ Pending | [PR #16201](https://github.com/ollama/ollama/pull/16201) | [Detail](contributions/ollama-ollama.md) | 17 May 2026 |

---

## Trivial Contributions

Small fixes, typos, nil guards, and minor improvements.

| No | Project                              | Language  | Type | Description                         | Status    | Link                                                          | Study Case                                                         | PR Date      |
| -- | ------------------------------------ | --------- | ---- | ----------------------------------- | --------- | ------------------------------------------------------------- | -------------------------------------------------------------- | ------------ |
| 3  | [microsoft/playwright](https://github.com/microsoft/playwright) | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🧹 Chore | Remove 3 dead env var flags with cascading dead variables | ❌ Closed | [PR #41500](https://github.com/microsoft/playwright/pull/41500) | [Detail](contributions/playwright-unused-env-vars.md) | 27 Jun 2026 |
| 2  | [rstacruz/cheatsheets](https://github.com/rstacruz/cheatsheets)     | [Dart](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Dart.md)     | ✨ Feature  | Add Dart cheatsheet with Flutter quick reference        | ⏳ Pending | [PR #2219](https://github.com/rstacruz/cheatsheets/pull/2219) | [Detail](contributions/rstacruz-cheatsheets.md) | 22 May 2026 |
| 1  | [firstcontributions/first-contributions](https://github.com/firstcontributions/first-contributions) | [Markdown](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Markdown.md) | 📝 Docs | Add Muhammad Faisal Affan to Contributors list | ✅ Merged | [PR #117480](https://github.com/firstcontributions/first-contributions/pull/117480) | [Detail](contributions/firstcontributions-first-contributions.md) | 22 May 2026 |

---

## Contribution Types

- 🐛 Bug Fix
- ✨ Feature
- 📝 Docs
- ⚡ Performance
- 🔒 Security
- 🔧 Refactor
- 🧹 Chore

---

## Legend

| Badge       | Meaning                                          |
| ----------- | ------------------------------------------------ |
| ✅ Merged   | PR merged into codebase                          |
| ⏳ Pending  | PR under review                                  |
| 📋 Reported | Issue reported, no pull request created          |
| 🔀 Resolved | Merged via another pull request                  |
| 📅 Scheduled | Scheduled to be merged later                    |
| ❌ Closed   | PR closed without merge                          |
