[🇬🇧 English](README.md) | [🇮🇩 Bahasa Indonesia](README.id.md)

# Kontribusi Open Source

Kontribusi substansial ke proyek yang saya gunakan di production.

---

## Sorotan

### [gin-gonic/gin](https://github.com/gin-gonic/gin)

**Menambahkan handler NoMethod untuk error 405**

- Masalah: Error 405 Method Not Allowed mem-bypass middleware gin dan jatuh ke Go `http.Router`
- Solusi: Menambahkan method `NoMethod` yang mirroring `NoRoute` agar middleware bisa menangani response 405
- Status: Merged ✅
- PR: [gin-gonic/gin#235](https://github.com/gin-gonic/gin/pull/235)

[Detail →](contributions/gin-gonic-gin.id.md)

---

## Semua Kontribusi

| Proyek | Tipe | Deskripsi | Status | Link |
|--------|------|-----------|--------|------|
| gin-gonic/gin | Feature | Menambahkan handler NoMethod untuk error 405 | ✅ Merged | [PR #235](https://github.com/gin-gonic/gin/pull/235) |

---

## Tipe Kontribusi

- 🐛 Bug Fix
- ✨ Feature
- 📝 Docs
- ⚡ Performance
- 🔒 Security

---

## Legenda

| Badge | Arti |
|-------|------|
| ✅ Merged | PR diterima dan digabungkan |
| ⏳ Pending | PR dalam proses review |
| ❌ Closed | PR ditutup tanpa digabungkan |
