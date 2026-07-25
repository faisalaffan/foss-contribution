[🇬🇧 English](terrastruct-d2-playwright-migration.md) | [🇮🇩 Bahasa Indonesia](terrastruct-d2-playwright-migration.id.md)

# terrastruct/d2 — Migrate playwright-go to mxschmitt module path after deprecation

## Context

D2 is a modern diagram scripting language (24.8k+ stars). It uses Playwright for rendering diagrams to PNG, GIF, and PDF. The Go Playwright bindings (`playwright-community/playwright-go`) were deprecated and moved to `mxschmitt/playwright-go`. Additionally, Microsoft CDN removed all Playwright driver binaries for versions 1.47 through 1.60, causing `d2 init-playwright` to fail with 404 errors.

## Problem (Root Cause)

The deprecated `playwright-community/playwright-go` module at `v0.5200.0` bundled driver version 1.52.0, whose binaries were removed from Microsoft CDN. Any fresh `d2 init-playwright` install failed:

```
err: failed to install Playwright: could not install driver: error:
got non 200 status code: 404 (404 Not Found) from
https://playwright.azureedge.net/builds/driver/playwright-1.52.0-mac-arm64.zip
```

## Approach

- **Import path:** Migrate `github.com/playwright-community/playwright-go` → `github.com/mxschmitt/playwright-go` across all 3 Go source files
- **Version bump:** `v0.5200.0` → `v0.6100.0` — driver version 1.61.0 still available on Microsoft CDN
- **go.mod / go.sum:** Update module dependency

## Impact

- 12 additions, 14 deletions across 5 files
- Fixes broken `d2 init-playwright` for all new users
- PNG, GIF, PDF rendering tested and working

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `d2cli/main.go` | +1 | -1 |
| `lib/png/png.go` | +1 | -1 |
| `lib/xgif/xgif.go` | +1 | -1 |
| `go.mod` | +3 | -3 |
| `go.sum` | +6 | -8 |

## Links

- PR: [terrastruct/d2#2782](https://github.com/terrastruct/d2/pull/2782)
