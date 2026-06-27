[🇬🇧 English](pyroscope-deprecated-metric.md) | [🇮🇩 Bahasa Indonesia](pyroscope-deprecated-metric.id.md)

# grafana/pyroscope — Remove deprecated receivedDecompressedBytes metric

## Context

Grafana Pyroscope is a continuous profiling database (11.5k+ stars). The distributor had a `pyroscope_distributor_received_decompressed_bytes` histogram metric marked `TODO remove` and self-documented as deprecated in its own help text since it was superseded by a richer replacement.

## Problem (Root Cause)

The deprecated `receivedDecompressedBytes` tracked only a single processing stage with `type` labels. Its replacement `pyroscope_distributor_received_decompressed_bytes_total` provides finer-grained observability with `stage` labels (`received`, `sampled`, `normalized`). The old metric was a duplicate observation — `observeProfileSize()` was already called at all three stages.

## Approach

- **Distributor:** Remove `receivedDecompressedBytes` field, histogram creation, registration, and the observe call at the sampled stage
- **Validation:** Update stale comment in `usage_groups.go` referencing the removed metric name
- **Distributor:** Preserve existing TODO about using `req.TotalBytesUncompressed` as a proper doc comment

## Impact

- 4 additions, 20 deletions across 3 files
- Removes duplicate metric observation that added no value
- All 160 distributor tests pass; all validation tests pass

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `pkg/distributor/distributor.go` | +2 | -6 |
| `pkg/distributor/metrics.go` | +0 | -12 |
| `pkg/validation/usage_groups.go` | +2 | -2 |

## Links

- PR: [grafana/pyroscope#5292](https://github.com/grafana/pyroscope/pull/5292)
