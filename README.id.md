[🇬🇧 English](README.md) | [🇮🇩 Bahasa Indonesia](README.id.md)

# Kontribusi Open Source

Kontribusi ke proyek yang saya gunakan di production.

---

## Kontribusi Non-Trivial

Fitur signifikan, perubahan arsitektur, atau bug fix yang tidak obvious.

| No | Proyek        | Bahasa | Tipe    | Deskripsi                                                    | Status     | Link                                                     | Study Case                                                | PR Date      |
| -- | ------------- | ------ | ------- | ------------------------------------------------------------ | ---------- | -------------------------------------------------------- | ----------------------------------------------------- | ------------ |
| 10 | [microsoft/playwright](https://github.com/microsoft/playwright) | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🐛 Bug Fix  | Ganti catch{} kosong di ariaSnapshot dengan debugLogger; throw pada pelanggaran integritas fixture | ⏳ Pending | [PR #41502](https://github.com/microsoft/playwright/pull/41502) | [Detail](contributions/playwright-aria-fixture-error.id.md) | 27 Jun 2026 |
| 9  | [grafana/pyroscope](https://github.com/grafana/pyroscope)   | [Go](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Go.md) | ✨ Feature  | Tambah validasi input untuk units dan aggregationType di ingest handler — 72 test | ⏳ Pending | [PR #5293](https://github.com/grafana/pyroscope/pull/5293) | [Detail](contributions/pyroscope-ingest-validation.id.md) | 26 Jun 2026 |
| 8  | [grafana/pyroscope](https://github.com/grafana/pyroscope)   | [Go](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Go.md) | 🔧 Refactor | Hapus metrik deprecated receivedDecompressedBytes yang digantikan varian _total | ⏳ Pending | [PR #5292](https://github.com/grafana/pyroscope/pull/5292) | [Detail](contributions/pyroscope-deprecated-metric.id.md) | 26 Jun 2026 |
| 7  | [latitude-dev/latitude-llm](https://github.com/latitude-dev/latitude-llm) | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🐛 Bug Fix  | Perbaiki race condition anySignal() — cek ulang signal.aborted setelah addEventListener | ❌ Closed | [PR #3336](https://github.com/latitude-dev/latitude-llm/pull/3336) | [Detail](contributions/latitude-llm-anysignal.id.md) | 30 May 2026 |
| 6  | [nuxt/nuxt](https://github.com/nuxt/nuxt)                 | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | ✨ Feature  | Tambah `useDebounce` composable — reactive debouncing, auto-imported, SSR-safe | ⏳ Pending | [PR #35453](https://github.com/nuxt/nuxt/pull/35453) | [Detail](contributions/nuxt-usedebounce.id.md) | 26 Jun 2026 |
| 5  | [nuxt/nuxt](https://github.com/nuxt/nuxt)                 | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🐛 Bug Fix  | Bungkus `new URL()` dengan try-catch di 6 lokasi untuk mencegah crash pada input tidak valid | ⏳ Pending | [PR #35449](https://github.com/nuxt/nuxt/pull/35449) | [Detail](contributions/nuxt-url-trycatch.id.md) | 26 Jun 2026 |
| 4  | [ahmadrosid/tinyclaw](https://github.com/ahmadrosid/tinyclaw) | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🔒 Security | PathGuard cegah path traversal di write_file/delete_file | ✅ Merged | [PR #4](https://github.com/ahmadrosid/tinyclaw/pull/4) | [Detail](contributions/tinyclaw-tinyclaw.id.md) | 4 Jun 2026 |
| 3  | [fern-api/fern](https://github.com/fern-api/fern)           | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🐛 Bug Fix  | Perbaiki race condition `anySignal()` antara aborted check dan addEventListener | ❌ Closed | [PR #16153](https://github.com/fern-api/fern/pull/16153) | [Detail](contributions/fern-api-fern.id.md) | 1 Jun 2026 |
| 2  | [stdlib-js/stdlib](https://github.com/stdlib-js/stdlib)     | [JavaScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/JavaScript.md) | ✨ Feature  | Tambah `stats/incr/nanminabs` — incremental minimum absolute value yang mengabaikan NaN | ⏳ Pending | [PR #12246](https://github.com/stdlib-js/stdlib/pull/12246) | [Detail](contributions/stdlib-js-stdlib.id.md) | 22 May 2026 |
| 1  | [ollama/ollama](https://github.com/ollama/ollama)           | [Go](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Go.md)     | 🐛 Bug Fix  | Guard nil spinner di push handler setelah push berhasil | ⏳ Pending | [PR #16201](https://github.com/ollama/ollama/pull/16201) | [Detail](contributions/ollama-ollama.id.md) | 17 May 2026 |

---

## Kontribusi Trivial

Perbaikan kecil, typo, nil guard, dan improvement minor.

| No | Proyek                               | Bahasa    | Tipe | Deskripsi                                    | Status    | Link                                                          | Study Case                                                         | PR Date      |
| -- | ------------------------------------ | --------- | ---- | -------------------------------------------- | --------- | ------------------------------------------------------------- | -------------------------------------------------------------- | ------------ |
| 3  | [microsoft/playwright](https://github.com/microsoft/playwright) | [TypeScript](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/TypeScript.md) | 🧹 Chore | Hapus 3 env var flags mati dengan variabel mati berantai | ⏳ Pending | [PR #41500](https://github.com/microsoft/playwright/pull/41500) | [Detail](contributions/playwright-unused-env-vars.id.md) | 27 Jun 2026 |
| 2  | [rstacruz/cheatsheets](https://github.com/rstacruz/cheatsheets)     | [Dart](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Dart.md)   | ✨ Feature  | Tambah Dart cheatsheet dengan Flutter quick reference    | ⏳ Pending | [PR #2219](https://github.com/rstacruz/cheatsheets/pull/2219) | [Detail](contributions/rstacruz-cheatsheets.id.md) | 22 May 2026 |
| 1  | [firstcontributions/first-contributions](https://github.com/firstcontributions/first-contributions) | [Markdown](https://github.com/EvanLi/Github-Ranking/blob/master/Top100/Markdown.md) | 📝 Docs | Tambah Muhammad Faisal Affan ke daftar Contributors | ✅ Merged | [PR #117480](https://github.com/firstcontributions/first-contributions/pull/117480) | [Detail](contributions/firstcontributions-first-contributions.id.md) | 22 May 2026 |

---

## Tipe Kontribusi

- 🐛 Bug Fix
- ✨ Feature
- 📝 Docs
- ⚡ Performance
- 🔒 Security
- 🔧 Refactor
- 🧹 Chore

---

## Legenda

| Badge        | Arti                                              |
| ------------ | ------------------------------------------------- |
| ✅ Merged    | PR diterima dan digabungkan                       |
| ⏳ Pending   | PR dalam proses review                            |
| 📋 Reported  | Issue dilaporkan, belum dibuat pull request       |
| 🔀 Resolved  | Digabungkan melalui pull request lain             |
| 📅 Scheduled | Dijadwalkan untuk digabungkan nanti               |
| ❌ Closed    | PR ditutup tanpa digabungkan                      |
