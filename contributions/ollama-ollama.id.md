[🇬🇧 English](ollama-ollama.md) | [🇮🇩 Bahasa Indonesia](ollama-ollama.id.md)

# ollama/ollama — Guard nil spinner di push handler setelah push berhasil

## Konteks

Ollama adalah runner LLM lokal. `PushHandler` di `cmd/cmd.go` menggunakan terminal spinner untuk menampilkan progress saat push model. Path error sudah memiliki nil guard pada `spinner.Stop()`, tapi path sukses belum — berpotensi menyebabkan nil pointer dereference.

## Masalah

Ketika `PushHandler` menyelesaikan push yang hanya melibatkan blob-digest response (tanpa status-only update dari server), referensi spinner tetap nil. Memanggil `spinner.Stop()` pada nil spinner menyebabkan panic.

```go
// Sebelum: path sukses — spinner bisa nil
if spinner != nil {
    spinner.Stop()
}
// Path error sudah punya guard, tapi path sukses belum
```

## Pendekatan

Menambahkan nil guard pada `spinner.Stop()` di path sukses agar konsisten dengan guard yang sudah ada di path error. Juga menambahkan test case untuk skenario blob-digest-only response guna mencegah regresi.

```go
// Sesudah: path sukses diguard
if spinner != nil {
    spinner.Stop()
}
```

## Dampak

- Mencegah panic nil pointer dereference pada push sukses dengan blob-digest-only response
- Konsistensi nil-safety antara path sukses dan error
- Test coverage untuk edge case yang sebelumnya tidak diuji

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `cmd/cmd.go` | +3 | -1 |
| `cmd/cmd_test.go` | +44 | -0 |

## Tautan

- PR: [ollama/ollama#16201](https://github.com/ollama/ollama/pull/16201)
