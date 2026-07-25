[🇬🇧 English](terrastruct-d2-playwright-migration.md) | [🇮🇩 Bahasa Indonesia](terrastruct-d2-playwright-migration.id.md)

# terrastruct/d2 — Migrasi playwright-go ke module path mxschmitt setelah deprecation

## Konteks

D2 adalah bahasa scripting diagram modern (24.8k+ stars). D2 menggunakan Playwright untuk merender diagram ke PNG, GIF, dan PDF. Binding Go Playwright (`playwright-community/playwright-go`) telah deprecated dan dipindahkan ke `mxschmitt/playwright-go`. Selain itu, Microsoft CDN menghapus semua binary driver Playwright versi 1.47 hingga 1.60, menyebabkan `d2 init-playwright` gagal dengan error 404.

## Masalah (Akar Penyebab)

Module deprecated `playwright-community/playwright-go` di `v0.5200.0` membundel driver versi 1.52.0, yang binary-nya telah dihapus dari Microsoft CDN. Setiap instalasi baru `d2 init-playwright` gagal:

```
err: failed to install Playwright: could not install driver: error:
got non 200 status code: 404 (404 Not Found) from
https://playwright.azureedge.net/builds/driver/playwright-1.52.0-mac-arm64.zip
```

## Pendekatan

- **Import path:** Migrasi `github.com/playwright-community/playwright-go` → `github.com/mxschmitt/playwright-go` di seluruh 3 file source Go
- **Version bump:** `v0.5200.0` → `v0.6100.0` — driver versi 1.61.0 masih tersedia di Microsoft CDN
- **go.mod / go.sum:** Update dependensi module

## Dampak

- 12 penambahan, 14 penghapusan di 5 file
- Memperbaiki `d2 init-playwright` yang rusak untuk semua pengguna baru
- Render PNG, GIF, PDF telah diuji dan berfungsi

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `d2cli/main.go` | +1 | -1 |
| `lib/png/png.go` | +1 | -1 |
| `lib/xgif/xgif.go` | +1 | -1 |
| `go.mod` | +3 | -3 |
| `go.sum` | +6 | -8 |

## Tautan

- PR: [terrastruct/d2#2782](https://github.com/terrastruct/d2/pull/2782)
