[🇬🇧 English](playwright-hoist-regex.md) | [🇮🇩 Bahasa Indonesia](playwright-hoist-regex.id.md)

# microsoft/playwright — Angkat konstanta regex ke module scope

## Konteks

Playwright adalah framework otomatisasi browser Microsoft (91.7k+ stars). Path `setUserAgent()` dan parser cookie HAR mengkompilasi ulang literal regex yang sama di setiap pemanggilan, menciptakan garbage dan kerja CPU yang tidak perlu.

## Masalah (Akar Penyebab)

Dua hot path mengkompilasi ulang regex di setiap panggilan:

- **`calculateUserAgentMetadata`** — 5 pola regex dikompilasi ulang per panggilan `page.setUserAgent()` untuk parsing versi Android, iOS, iPad OS, macOS, dan Windows
- **`parseCookie`** — `;/ */` dikompilasi ulang per header `Set-Cookie` selama perekaman HAR trace

## Pendekatan

Mengangkat semua 6 literal regex ke `const` module-level dengan nama deskriptif (`ANDROID_VERSION_RE`, `IPHONE_OS_VERSION_RE`, `IPAD_OS_VERSION_RE`, `MAC_OS_VERSION_RE`, `WINDOWS_VERSION_RE`, `SEMICOLON_SPLIT_RE`). Alokasi tunggal saat import, digunakan kembali di semua panggilan.

## Dampak

- 14 penambahan, 6 penghapusan di 2 file
- Objek regex dialokasikan sekali saat module load, bukan per pemanggilan
- Zero behavior change — murni optimisasi performa

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `packages/playwright-core/src/server/chromium/crPage.ts` | +12 | -4 |
| `packages/playwright-core/src/server/har/harTracer.ts` | +2 | -2 |

## Tautan

- PR: [microsoft/playwright#41501](https://github.com/microsoft/playwright/pull/41501)
