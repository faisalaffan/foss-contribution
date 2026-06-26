[🇬🇧 English](nuxt-usedebounce.md) | [🇮🇩 Bahasa Indonesia](nuxt-usedebounce.id.md)

# nuxt/nuxt — Tambah `useDebounce` composable

## Konteks

Nuxt adalah full-stack Vue framework (60.5k+ stars). Setiap developer Nuxt butuh debouncing untuk search input, resize handler, dan form validation, tapi ekosistem tidak punya solusi bawaan. Saat ini developer harus install `@vueuse/core` (60KB ekstra) hanya untuk `refDebounced`, pakai `lodash.debounce` (tidak reactive), atau tulis boilerplate `setTimeout`/`clearTimeout` manual di setiap komponen.

## Masalah (Akar Penyebab)

**Tidak ada utility debounce bawaan di Nuxt core.** Framework ini auto-import banyak composable (`useState`, `useFetch`, `useCookie`, `useAsyncData`), tapi debouncing — pola reactive fundamental yang digunakan di hampir setiap aplikasi — membutuhkan dependensi pihak ketiga atau boilerplate ad-hoc.

## Pendekatan

Menambahkan `useDebounce` ke composable Nuxt core:

- **Zero dependencies** — dibangun dengan `setTimeout`/`clearTimeout` dan `ref`/`watch` dari Vue
- **Auto-imported** — terdaftar di import presets Nuxt, tersedia di setiap komponen tanpa import eksplisit
- **SSR-safe** — mengembalikan nilai initial langsung di server (tidak perlu debounce)
- **Input reactive** — menerima `Ref<T>` atau getter function `() => T`
- **Delay dapat dikonfigurasi** — argumen kedua dalam milidetik (default 300ms)
- **Self-cleaning** — timer otomatis dibersihkan saat scope dihancurkan via `onScopeDispose`

Source ref berubah → `setTimeout` dijadwalkan → perubahan lain sebelum timeout → timer direset → delay ms tanpa aktivitas → debounced ref diupdate ke nilai terbaru.

## Dampak

- Menghilangkan dependensi 60KB `@vueuse/core` untuk use case debounce yang umum
- API konsisten di semua aplikasi Nuxt — tidak ada lagi solusi ad-hoc per proyek
- 9 test mencakup: initial value, delayed update, premature-no-update, rapid-fire last-value-only, ms=0 immediate, timer cleanup on scope dispose

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `packages/nuxt/src/app/composables/debounce.ts` | +29 | -0 |
| `packages/nuxt/src/app/composables/index.ts` | +1 | -0 |
| `packages/nuxt/src/imports/presets.ts` | +4 | -0 |
| `packages/nuxt/test/debounce.test.ts` | +154 | -0 |

## Tautan

- PR: [nuxt/nuxt#35453](https://github.com/nuxt/nuxt/pull/35453)
- Nuxt composables: [dokumentasi](https://nuxt.com/docs/guide/directory-structure/composables)
