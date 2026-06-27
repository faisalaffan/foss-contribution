[🇬🇧 English](latitude-llm-anysignal.md) | [🇮🇩 Bahasa Indonesia](latitude-llm-anysignal.id.md)

# latitude-dev/latitude-llm — Eliminasi race condition AbortSignal di anySignal()

## Konteks

Latitude adalah platform evaluasi LLM open-source (4.3k+ stars). SDK TypeScript mereka memiliki utilitas `anySignal()` yang menggabungkan beberapa AbortSignal menjadi satu. Utilitas ini memiliki race condition yang sama dengan yang ditemukan di `fern-api/fern` — celah di level platform Node.js dalam semantik AbortSignal.

## Masalah (Akar Penyebab)

`anySignal()` memiliki race condition: jika sinyal sumber abort di antara pengecekan `signal.aborted` dan panggilan `addEventListener("abort", …)`, event abort sudah didispatch dan listener tidak pernah dipanggil. Di Node.js, menambahkan listener "abort" ke AbortSignal yang sudah diabort TIDAK memanggil callback secara sinkron. Sinyal gabungan tetap tidak diabort tanpa batas — timeout dan cancellation berhenti bekerja.

## Pendekatan

Memeriksa ulang `signal.aborted` segera setelah `addEventListener`. Jika sinyal abort selama jendela registrasi, secara manual menyebarkan abort ke controller gabungan. Juga mengganti `break` dengan `return controller.signal` untuk menghindari iterasi sia-sia setelah sinyal gabungan sudah diabort.

## Dampak

- 103 penambahan, 1 penghapusan di 2 file
- Fix dikonfirmasi dalam 4 skenario test: happy path, already-aborted on entry, abort di tengah jendela registrasi (sebelumnya RUSAK), dan kompatibilitas `getTimeoutSignal`
- Menerima argumen spread dan array

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `packages/sdk/typescript/src/core/fetcher/signals.ts` | +35 | -1 |
| `packages/sdk/typescript/src/core/fetcher/signals.test.ts` | +68 | -0 |

## Tautan

- PR: [latitude-dev/latitude-llm#3336](https://github.com/latitude-dev/latitude-llm/pull/3336)
