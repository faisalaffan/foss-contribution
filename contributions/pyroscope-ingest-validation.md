[🇬🇧 English](pyroscope-ingest-validation.md) | [🇮🇩 Bahasa Indonesia](pyroscope-ingest-validation.id.md)

# grafana/pyroscope — Validate units and aggregationType in ingest handler

## Context

Grafana Pyroscope is a continuous profiling database (11.5k+ stars). The ingest HTTP handler accepted `units` and `aggregationType` query parameters as arbitrary strings with no validation — a maintainer had left explicit `TODO` comments requesting validation.

## Problem (Root Cause)

`parseInputMetadataFromRequest` had two `TODO(petethepig)` comments requesting validation for `units` and `aggregationType`. Without validation, a client sending `units=bogus` or `aggregationType=banana` would create metadata with invalid values propagating through the ingestion pipeline undetected.

## Approach

**`pkg/og/storage/metadata/metadata.go`**
- Added `IsValidUnit(unit string) bool` — validates against 6 known unit types
- Added `IsValidAggregationType(aggType string) bool` — validates against `sum` / `average`

**`pkg/ingester/pyroscope/ingest_handler.go`**
- `parseInputMetadataFromRequest` now validates both params
- Invalid values log a warning and fall back to defaults: units → `samples`, aggregationType → `sum`
- Follows same pattern as existing `sampleRate` validation

## Impact

- 236 additions, 4 deletions across 4 files
- 37 unit tests for validation functions (100% coverage)
- 35 integration tests for ingest handler (88.6% coverage)
- Covers: case sensitivity, whitespace, newline injection, unicode, SQL injection patterns

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `pkg/ingester/pyroscope/ingest_handler.go` | +42 | -4 |
| `pkg/ingester/pyroscope/ingest_handler_test.go` | +135 | -0 |
| `pkg/og/storage/metadata/metadata.go` | +25 | -0 |
| `pkg/og/storage/metadata/metadata_test.go` | +34 | -0 |

## Links

- PR: [grafana/pyroscope#5293](https://github.com/grafana/pyroscope/pull/5293)
