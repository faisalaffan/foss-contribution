[🇬🇧 English](README.md) | [🇮🇩 Bahasa Indonesia](README.id.md)

# Open Source Contributions

Substantial contributions to projects I use in production.

---

## Highlights

### [gin-gonic/gin](https://github.com/gin-gonic/gin)

**Added NoMethod handler for 405 errors**

- Problem: 405 Method Not Allowed errors bypassed gin middleware and fell through to Go `http.Router`
- Fix: Added `NoMethod` method mirroring `NoRoute` to allow middleware handling of 405 responses
- Status: Merged ✅
- PR: [gin-gonic/gin#235](https://github.com/gin-gonic/gin/pull/235)

[Detail →](contributions/gin-gonic-gin.md)

---

## All Contributions

| Project | Type | Description | Status | Link |
|---------|------|-------------|--------|------|
| gin-gonic/gin | Feature | Added NoMethod handler for 405 errors | ✅ Merged | [PR #235](https://github.com/gin-gonic/gin/pull/235) |

---

## Contribution Types

- 🐛 Bug Fix
- ✨ Feature
- 📝 Docs
- ⚡ Performance
- 🔒 Security

---

## Legend

| Badge | Meaning |
|-------|---------|
| ✅ Merged | PR merged into codebase |
| ⏳ Pending | PR under review |
| ❌ Closed | PR closed without merge |
