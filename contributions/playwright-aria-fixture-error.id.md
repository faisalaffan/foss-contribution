[🇬🇧 English](playwright-aria-fixture-error.md) | [🇮🇩 Bahasa Indonesia](playwright-aria-fixture-error.id.md)

# microsoft/playwright — Perbaiki error handling untuk ariaSnapshot dan integritas fixture

## Konteks

Playwright adalah framework otomatisasi browser Microsoft (91.7k+ stars). Penelanan error secara diam di test runner membuat debugging kegagalan lebih sulit — dua kasus spesifik menelan sinyal kritis.

## Masalah (Akar Penyebab)

- **ariaSnapshot:** Block `catch {}` kosong membuang semua kegagalan AI snapshot secara diam, membuat debugging test-error tidak mungkin saat mekanisme snapshot itu sendiri rusak
- **fixtureRunner:** `console.error` + `_usages.clear()` diam-diam pada pelanggaran integritas fixture merusak state internal alih-alih gagal cepat — test worker berlanjut dengan state fixture yang rusak

## Pendekatan

- Mengganti `catch {}` kosong di ariaSnapshot dengan `debugLogger.log(...)` agar kegagalan AI snapshot dapat dilacak
- Mengganti `console.error` + mutasi state diam di fixtureRunner dengan `throw new Error(...)` — pelanggaran integritas fixture sekarang gagal cepat

## Dampak

- 6 penambahan, 6 penghapusan di 2 file
- Kegagalan AI snapshot menjadi dapat didebug via debug logger
- Pelanggaran integritas fixture gagal cepat alih-alih merusak state worker secara diam

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `packages/playwright/src/index.ts` | +4 | -4 |
| `packages/playwright/src/worker/fixtureRunner.ts` | +2 | -2 |

## Tautan

- PR: [microsoft/playwright#41502](https://github.com/microsoft/playwright/pull/41502)
