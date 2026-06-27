[🇬🇧 English](pyroscope-ingest-validation.md) | [🇮🇩 Bahasa Indonesia](pyroscope-ingest-validation.id.md)

# grafana/pyroscope — Validasi units dan aggregationType di ingest handler

## Konteks

Grafana Pyroscope adalah database continuous profiling (11.5k+ stars). HTTP handler ingest menerima query parameter `units` dan `aggregationType` sebagai string arbitrer tanpa validasi — seorang maintainer telah meninggalkan komentar `TODO` eksplisit yang meminta validasi.

## Masalah (Akar Penyebab)

`parseInputMetadataFromRequest` memiliki dua komentar `TODO(petethepig)` yang meminta validasi untuk `units` dan `aggregationType`. Tanpa validasi, klien yang mengirim `units=bogus` atau `aggregationType=banana` akan membuat metadata dengan nilai tidak valid yang menyebar melalui pipeline ingestion tanpa terdeteksi.

## Pendekatan

**`pkg/og/storage/metadata/metadata.go`**
- Menambahkan `IsValidUnit(unit string) bool` — memvalidasi terhadap 6 tipe unit yang dikenal
- Menambahkan `IsValidAggregationType(aggType string) bool` — memvalidasi `sum` / `average`

**`pkg/ingester/pyroscope/ingest_handler.go`**
- `parseInputMetadataFromRequest` sekarang memvalidasi kedua parameter
- Nilai tidak valid mencatat peringatan dan fallback ke default: units → `samples`, aggregationType → `sum`
- Mengikuti pola yang sama dengan validasi `sampleRate` yang sudah ada

## Dampak

- 236 penambahan, 4 penghapusan di 4 file
- 37 unit tests untuk fungsi validasi (100% coverage)
- 35 integration tests untuk ingest handler (88.6% coverage)
- Mencakup: case sensitivity, whitespace, newline injection, unicode, pola SQL injection

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `pkg/ingester/pyroscope/ingest_handler.go` | +42 | -4 |
| `pkg/ingester/pyroscope/ingest_handler_test.go` | +135 | -0 |
| `pkg/og/storage/metadata/metadata.go` | +25 | -0 |
| `pkg/og/storage/metadata/metadata_test.go` | +34 | -0 |

## Tautan

- PR: [grafana/pyroscope#5293](https://github.com/grafana/pyroscope/pull/5293)
