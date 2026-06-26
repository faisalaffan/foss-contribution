[🇬🇧 English](nuxt-url-trycatch.md) | [🇮🇩 Bahasa Indonesia](nuxt-url-trycatch.id.md)

# nuxt/nuxt — Bungkus `new URL()` dengan try-catch di 6 lokasi

## Konteks

Nuxt menangani banyak URL dan path dari pengguna di layer routing-nya: `navigateTo()` menerima string arbitrer, `<NuxtLink>` merender nilai `to` dari pengguna, dan utility internal memproses target redirect. Di enam lokasi di codebase, `new URL()` dipanggil langsung pada input yang tidak terpercaya ini — string malformed menyebabkan `TypeError` yang tidak tertangani, merusak navigasi, mematahkan render komponen, atau menggagalkan operasi background secara diam.

## Masalah (Akar Penyebab)

**`new URL()` melempar exception sinkron pada input tidak valid tanpa fallback.** WHATWG URL constructor memiliki semantik parsing ketat: nilai seperti `"http://a b.com"` (spasi di hostname) atau `"not a url at all"` melempar `TypeError: Invalid URL`. Tidak satu pun dari enam lokasi tersebut membungkus constructor dengan error handling, sehingga input pengguna yang malformed menyebar sebagai exception tidak tertangani tanpa jalur pemulihan dan tanpa pesan error yang jelas.

## Pendekatan

Setiap lokasi mendapat strategi fallback yang sesuai konteks:

| Lokasi | File | Strategi |
|--------|------|----------|
| `navigateTo()` open handler | `router.ts:159` | Catch → lempar `Error` deskriptif dengan input buruk ditampilkan |
| `navigateTo()` external URL | `router.ts:183` | Catch → lempar `Error` deskriptif dengan input buruk ditampilkan |
| `encodeURL()` redirect encoder | `router.ts:344` | Catch → kembalikan input mentah (transparan, no-op) |
| `<NuxtLink>` prefetch | `nuxt-link.ts:422` | Catch → kembalikan path mentah (best-effort, tidak crash) |
| `<NuxtLink>` slot route getter | `nuxt-link.ts:530` | Catch → kembalikan `undefined` (degradasi halus) |
| `_getPayloadURL()` | `payload.ts:79` | Catch → lempar `Error` deskriptif (debug-friendly) |

Path yang dihadapi pengguna melempar error deskriptif sehingga developer tahu persis apa yang salah. Utility internal menurun secara halus — mengembalikan input mentah atau `undefined` sehingga sisa pipeline menangani ketidakhadirannya.

## Dampak

- Mencegah crash blank-page dari typo atau URL malformed
- 15 asersi test mencakup happy path dan edge cases di keenam lokasi
- Bundle size test diperbarui untuk menghitung wrapper `try/catch` baru di `encodeRoutePath`

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `packages/nuxt/src/app/components/nuxt-link.ts` | +6 | -2 |
| `packages/nuxt/src/app/composables/payload.ts` | +2 | -1 |
| `packages/nuxt/src/app/composables/router.ts` | +7 | -4 |
| `packages/nuxt/src/app/utils.ts` | +18 | -0 |
| `packages/nuxt/test/url-try-catch.test.ts` | +109 | -0 |
| `test/bundle.test.ts` | +2 | -2 |

## Tautan

- PR: [nuxt/nuxt#35449](https://github.com/nuxt/nuxt/pull/35449)
