[🇬🇧 English](gin-gonic-gin.md) | [🇮🇩 Bahasa Indonesia](gin-gonic-gin.id.md)

# gin-gonic/gin — Added NoMethod Handler for 405 Errors

## Context

Gin is a Go HTTP web framework used in production for routing and middleware. At the time, gin already had `NoRoute` for handling 404 errors via middleware, but there was no equivalent mechanism for 405 Method Not Allowed.

## Problem

When a request comes in with an HTTP method not allowed by a route (e.g., POST to a GET-only endpoint), gin throws a 405 error. However, this error **bypasses middleware** and falls through to Go's `http.Router` — it cannot be handled by gin middleware such as logging, gzip, compression, etc.

```go
r := gin.Default()
r.Use(gzip.Gzip(gzip.DefaultCompression))
r.NoRoute(gzip.Gzip(gzip.DefaultCompression))  // 404: OK, middleware handles it
// 405: no NoMethod → middleware skipped, falls through to http.Router
```

## Approach

Added a `NoMethod` method to gin with an API identical to the existing `NoRoute`. The implementation mirrors `NoRoute` so that 405 errors can be handled by the same middleware.

```go
r.NoMethod(gzip.Gzip(gzip.DefaultCompression)) // 405: now handled by middleware
```

## Impact

- All gin users with middleware (gzip, logging, auth, etc.) can now handle 405 errors consistently with 404 handling
- Consistent API surface: `NoRoute` + `NoMethod` = dual handler for HTTP method/route errors

## Links

- PR: [gin-gonic/gin#235](https://github.com/gin-gonic/gin/pull/235)
