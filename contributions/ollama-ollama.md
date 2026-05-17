[🇬🇧 English](ollama-ollama.md) | [🇮🇩 Bahasa Indonesia](ollama-ollama.id.md)

# ollama/ollama — Guard nil spinner in push handler after successful push

## Context

Ollama is a local LLM runner. The `PushHandler` in `cmd/cmd.go` uses a terminal spinner to show progress during model push. The error path already had a nil guard on `spinner.Stop()`, but the success path did not — leading to a potential nil pointer dereference.

## Problem

When `PushHandler` completes a successful push involving only blob-digest responses (no status-only updates from the server), the spinner reference remains nil. Calling `spinner.Stop()` on a nil spinner results in a panic.

```go
// Before: success path — spinner could be nil
if spinner != nil {
    spinner.Stop()
}
// Error path already had the guard, but success path didn't
```

## Approach

Added a nil guard on `spinner.Stop()` in the success path to match the existing guard in the error path. Also added a test case covering the blob-digest-only response scenario to prevent regression.

```go
// After: success path guarded
if spinner != nil {
    spinner.Stop()
}
```

## Impact

- Prevents nil pointer dereference panic on successful push with blob-digest-only responses
- Consistent nil-safety between success and error paths
- Test coverage for edge case previously untested

## Files Changed

| File | Additions | Deletions |
|------|-----------|-----------|
| `cmd/cmd.go` | +3 | -1 |
| `cmd/cmd_test.go` | +44 | -0 |

## Links

- PR: [ollama/ollama#16201](https://github.com/ollama/ollama/pull/16201)
