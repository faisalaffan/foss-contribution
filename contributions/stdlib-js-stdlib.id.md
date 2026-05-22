[🇬🇧 English](stdlib-js-stdlib.md) | [🇮🇩 Bahasa Indonesia](stdlib-js-stdlib.id.md)

# stdlib-js/stdlib — Tambah `stats/incr/nanminabs`

## Konteks

[stdlib-js/stdlib](https://github.com/stdlib-js/stdlib) adalah standard library untuk JavaScript dan Node.js, menyediakan utilitas matematika, statistik, dan pemrosesan data berperforma tinggi. Namespace `@stdlib/stats/incr` menyediakan incremental accumulator — fungsi stateful yang menghitung statistik secara efisien pada data streaming.

Library sudah memiliki `nanminabs` (minimum absolute value yang mengabaikan NaN) tetapi belum memiliki versi incremental-nya. Tiga issue terkait (#5552, #5637) sudah terbuka meminta fitur ini.

## Kontribusi

Mengimplementasikan `@stdlib/stats/incr/nanminabs` — incremental accumulator yang melacak nilai absolut minimum pada stream input numerik sambil mengabaikan nilai `NaN` alih-alih menyebarkannya.

Keputusan desain utama:
- Pola thin wrapper, konsisten dengan accumulator yang ada seperti `@stdlib/stats/incr/nansum`
- Mengembalikan `null` saat semua input sejauh ini NaN (konsisten dengan perilaku empty-state)
- Konvensi signed-zero: `-0` dan `+0` diperlakukan setara
- Test suite lengkap (125 baris), benchmark (6/6), examples, deklarasi TypeScript, dan REPL docs

Ini adalah versi revisi dari PR #5637, yang memiliki feedback review belum ditangani pada nama package, wording deskripsi, dan format string.

## Dampak

- Package baru: `@stdlib/stats/incr/nanminabs`
- Menyelesaikan #5552 dan menggantikan #5637
- 10 file, 738 penambahan

## File yang Diubah

| File | Penambahan |
|------|------------|
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

## Tautan

- PR: [stdlib-js/stdlib#12246](https://github.com/stdlib-js/stdlib/pull/12246)
- Issue: [#5552](https://github.com/stdlib-js/stdlib/issues/5552), [#5637](https://github.com/stdlib-js/stdlib/pull/5637)
