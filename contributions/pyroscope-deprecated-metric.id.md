[🇬🇧 English](pyroscope-deprecated-metric.md) | [🇮🇩 Bahasa Indonesia](pyroscope-deprecated-metric.id.md)

# grafana/pyroscope — Hapus metrik deprecated receivedDecompressedBytes

## Konteks

Grafana Pyroscope adalah database continuous profiling (11.5k+ stars). Distributor memiliki metrik histogram `pyroscope_distributor_received_decompressed_bytes` yang ditandai `TODO remove` dan didokumentasikan sendiri sebagai deprecated di teks bantuannya sejak digantikan oleh pengganti yang lebih kaya.

## Masalah (Akar Penyebab)

`receivedDecompressedBytes` yang deprecated hanya melacak satu tahap pemrosesan dengan label `type`. Penggantinya `pyroscope_distributor_received_decompressed_bytes_total` menyediakan observabilitas yang lebih rinci dengan label `stage` (`received`, `sampled`, `normalized`). Metrik lama adalah observasi duplikat — `observeProfileSize()` sudah dipanggil di ketiga tahap.

## Pendekatan

- **Distributor:** Menghapus field `receivedDecompressedBytes`, pembuatan histogram, registrasi, dan panggilan observe di tahap sampled
- **Validation:** Memperbarui komentar using di `usage_groups.go` yang mereferensikan nama metrik yang dihapus
- **Distributor:** Mempertahankan TODO tentang penggunaan `req.TotalBytesUncompressed` sebagai doc comment yang tepat

## Dampak

- 4 penambahan, 20 penghapusan di 3 file
- Menghapus observasi metrik duplikat yang tidak memberikan nilai tambah
- Semua 160 distributor tests lulus; semua validation tests lulus

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `pkg/distributor/distributor.go` | +2 | -6 |
| `pkg/distributor/metrics.go` | +0 | -12 |
| `pkg/validation/usage_groups.go` | +2 | -2 |

## Tautan

- PR: [grafana/pyroscope#5292](https://github.com/grafana/pyroscope/pull/5292)
