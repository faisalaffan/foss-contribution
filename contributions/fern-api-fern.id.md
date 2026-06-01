[🇬🇧 English](fern-api-fern.md) | [🇮🇩 Bahasa Indonesia](fern-api-fern.id.md)

# fern-api/fern — Perbaiki Race Condition `anySignal()` di TypeScript SDK Generator

## Konteks

[fern-api/fern](https://github.com/fern-api/fern) adalah SDK generator yang memproduksi client library idiomatik dari definisi API. TypeScript SDK generator-nya memproduksi helper `signals.ts` yang digunakan oleh setiap SDK yang di-generate untuk request cancellation dan timeout handling.

Fungsi `anySignal()` menggabungkan beberapa instance `AbortSignal` menjadi satu. Fungsi ini memiliki race condition di mana event abort bisa hilang secara diam — merusak timeout dan cancellation di seluruh TypeScript SDK yang di-generate.

## Kontribusi

Mengidentifikasi, mereproduksi, dan melaporkan race condition di `anySignal()` di mana sinyal source yang abort di antara pengecekan `signal.aborted` dan pemanggilan `addEventListener("abort", …)` hilang secara permanen. Combined signal tetap tidak ter-abort selamanya.

Akar masalah: Node.js TIDAK menjalankan callback listener "abort" secara sinkron ketika ditambahkan ke sinyal yang sudah ter-abort. Jarak antara pengecekan `aborted` dan registrasi listener menciptakan jendela di mana abort hilang secara diam.

Menyediakan:
- Reproduksi minimal menggunakan `Proxy` untuk memicu jendela race yang tepat
- Analisis akar masalah dengan dokumentasi perilaku event loop Node.js
- Perbaikan downstream di `latitude-dev/latitude-llm` dengan test suite lengkap (PR #3336)
- Strategi perbaikan: cek ulang `signal.aborted` segera setelah `addEventListener`, propagasi secara manual jika ter-abort selama jendela registrasi

## Dampak

- Mempengaruhi SEMUA TypeScript SDK yang di-generate yang menggunakan `anySignal()` (timeout, cancellation)
- Perbaikan harus berada di Fern generator — patch konsumen akan tertimpa setiap regenerasi SDK
- Perbaikan downstream divalidasi dengan 5 test case mencakup happy path, already-aborted, race window, timeout signal, dan variadic arguments

## Tautan

- PR: [fern-api/fern#16153](https://github.com/fern-api/fern/pull/16153)
- Issue: [fern-api/fern#16151](https://github.com/fern-api/fern/issues/16151)
- Perbaikan downstream: [latitude-dev/latitude-llm#3336](https://github.com/latitude-dev/latitude-llm/pull/3336)
