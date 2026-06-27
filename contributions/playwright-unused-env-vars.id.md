[🇬🇧 English](playwright-unused-env-vars.md) | [🇮🇩 Bahasa Indonesia](playwright-unused-env-vars.id.md)

# microsoft/playwright — Hapus env var flags yang tidak terpakai

## Konteks

Playwright adalah framework otomatisasi browser Microsoft (91.7k+ stars). Codebase memiliki akumulasi env-var feature flags mati yang menjaga jalur kode yang sudah tidak terjangkau. Flags ini menciptakan beban pemeliharaan — setiap pembaca harus memeriksa apakah flag tersebut diatur di suatu tempat sebelum menyentuh kode yang dijaga.

## Masalah (Akar Penyebab)

Tiga flag environment variable yang tidak memiliki setter tersisa:

- **`PLAYWRIGHT_LEGACY_SCREENSHOT`** — ternary dengan default ke flag CDP; branch `''` tidak pernah dieksekusi
- **`PW_CODEGEN_NO_INSPECTOR`** — dua early-return guard di recorder; mati sejak refactor Jul 2025
- **`PW_DETECT_NESTED_PROGRESS`** — blok deteksi nested race hanya untuk debug, ditambah variabel mati berantai (`outerProgress`, `allowConcurrent`, `setAllowConcurrentOrNestedRaces`)

## Pendekatan

Menghapus ketiga pengecekan env var, branch mati yang dijaga, dan variabel mati berantai yang hanya ada untuk mendukung branch tersebut. Murni penghapusan — tidak ada perubahan perilaku.

## Dampak

- 26 baris dihapus di 3 file
- Menghilangkan beban kognitif dari feature flags mati
- Zero risk — flags dikonfirmasi tidak ada di semua docs, configs, CI, dan source

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `packages/playwright-core/src/server/chromium/chromiumSwitches.ts` | +2 | -4 |
| `packages/playwright-core/src/server/progress.ts` | +0 | -18 |
| `packages/playwright-core/src/server/recorder/recorderApp.ts` | +0 | -4 |

## Tautan

- PR: [microsoft/playwright#41500](https://github.com/microsoft/playwright/pull/41500)
