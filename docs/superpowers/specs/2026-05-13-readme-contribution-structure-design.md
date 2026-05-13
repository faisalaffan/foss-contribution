# README & Contribution Structure — Design Spec

Tanggal: 2026-05-13

## Tujuan

Merestruktur README.md agar optimal sebagai portfolio FOSS untuk job search — menekankan severity, complexity, merged status, dan project popularity dari setiap kontribusi.

## Scope

- Restruktur README.md: Highlights → All Contributions → Contribution Types → Legend
- Buat `/contributions/gin-gonic-gin.md` template detail per kontribusi
- Hapus entry `claude-code/mcp` yang belum ada kontribusi real
- Ganti Shields.io badges dengan karakter unicode untuk mengurangi noise visual

## Out of Scope

- Website statis atau automated generator
- Otomasi update dari GitHub API
- Kontribusi baru (hanya restruktur yang sudah ada)

## README Structure

### Highlights (Featured)

Satu kontribusi paling signifikan ditampilkan dengan format:

- Project name + link
- Bold description
- Problem (1 kalimat)
- Fix (1 kalimat)
- Status dengan emoji merged
- Link PR

### All Contributions

Tabel Markdown native dengan kolom: Project, Type, Description, Status, Link.
Status pakai emoji unicode (✅ Merged, ⏳ Pending, ❌ Closed).

### Contribution Types

List tipe kontribusi dengan emoji:
- 🐛 Bug Fix
- ✨ Feature
- 📝 Docs
- ⚡ Performance
- 🔒 Security

### Legend

Tabel 2 kolom: Badge → Meaning. Hanya status badge.

## `/contributions/gin-gonic-gin.md`

File per-kontribusi dengan struktur:

- **Context**: Kenapa project ini digunakan di production
- **Problem**: Symptom, reproduce, impact
- **Approach**: Debugging, root cause, fix (singkat, teknis)
- **Impact**: Estimasi user/project terpengaruh
- **Links**: PR, Issue, Discussion

Template awal diisi placeholder, detail teknis diisi belakangan saat data tersedia.

## File yang Berubah

1. `README.md` — rewrite full
2. `contributions/gin-gonic-gin.md` — file baru

## Acceptance Criteria

- [ ] README mengikuti struktur di atas
- [ ] Tidak ada Shields.io badge
- [ ] Entry claude-code/mcp dihapus
- [ ] `/contributions/gin-gonic-gin.md` ada dengan template lengkap
- [ ] Link antar file (README → contributions detail) berfungsi
