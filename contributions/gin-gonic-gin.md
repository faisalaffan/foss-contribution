# gin-gonic/gin — Added NoMethod Handler for 405 Errors

## Context

Gin adalah HTTP web framework Go yang digunakan di production untuk menangani routing dan middleware. Saat itu gin sudah menyediakan `NoRoute` untuk handling 404 errors via middleware, tapi tidak ada mekanisme serupa untuk 405 Method Not Allowed.

## Problem

Ketika sebuah request masuk dengan HTTP method yang tidak diizinkan oleh route (misal: POST ke endpoint yang hanya menerima GET), gin melempar 405 error. Tapi error ini **bypass middleware** dan langsung jatuh ke Go `http.Router` — tidak bisa ditangani oleh middleware gin seperti logging, gzip, compression, dll.

```go
r := gin.Default()
r.Use(gzip.Gzip(gzip.DefaultCompression))
r.NoRoute(gzip.Gzip(gzip.DefaultCompression))  // 404: OK, middleware jalan
// 405: tidak ada NoMethod → middleware tidak jalan, fallback ke http.Router
```

## Approach

Menambahkan method `NoMethod` ke gin dengan API yang identik dengan `NoRoute` yang sudah ada. Implementasi mirroring `NoRoute` sehingga 405 errors bisa ditangani oleh middleware yang sama.

```go
r.NoMethod(gzip.Gzip(gzip.DefaultCompression)) // 405: sekarang middleware jalan
```

## Impact

- Semua user gin yang menggunakan middleware (gzip, logging, auth, dll) kini bisa menangani 405 errors secara konsisten dengan 404 handling
- API surface konsisten: `NoRoute` + `NoMethod` = dual handler untuk error HTTP method/route

## Links

- PR: [gin-gonic/gin#235](https://github.com/gin-gonic/gin/pull/235)
