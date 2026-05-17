[🇬🇧 English](README.md) | [🇮🇩 Bahasa Indonesia](README.id.md)

# Kontribusi Open Source

Kontribusi substansial ke proyek yang saya gunakan di production.

---

## Sorotan

### [ollama/ollama](https://github.com/ollama/ollama)

**Guard nil spinner di push handler setelah push berhasil**

- Masalah: Path sukses `PushHandler` tidak memiliki nil guard pada `spinner.Stop()`, menyebabkan potensi panic pada push blob-digest-only
- Solusi: Menambahkan nil guard yang konsisten dengan path error, plus test coverage untuk edge case
- Status: Pending ⏳
- PR: [ollama/ollama#16201](https://github.com/ollama/ollama/pull/16201)

[Detail →](contributions/ollama-ollama.id.md)

---

## Semua Kontribusi

| Proyek | Tipe | Deskripsi | Status | Link |
|--------|------|-----------|--------|------|
| gin-gonic/gin | Bug Fix | Menambahkan handler NoMethod untuk error 405 | ✅ Merged | [PR #235](https://github.com/gin-gonic/gin/pull/235) |
| ollama/ollama | Bug Fix | Guard nil spinner di push handler setelah push berhasil | ⏳ Pending | [PR #16201](https://github.com/ollama/ollama/pull/16201) |

---

## Proyek Open Source Saya

| Proyek | Deskripsi | Bahasa | Bintang |
|--------|-----------|--------|---------|
| [banksatu](https://github.com/faisalaffan/banksatu) | One banking platform. Built for everyone — officers and customers alike | — | 0 |
| [banksatu-ops](https://github.com/faisalaffan/banksatu-ops) | Internal operations platform for bank field officers | — | 0 |
| [belajardart](https://github.com/faisalaffan/belajardart) | Dasar-dasar pemrograman Dart & Best Practice Flutter | MDX | 0 |
| [brokenore](https://github.com/faisalaffan/brokenore) | Platform manajemen operasional tambang — lapangan, logistik, laporan | — | 0 |
| [chainnusa](https://github.com/faisalaffan/chainnusa) | Southeast Asia's on-chain intelligence platform | TypeScript | 0 |
| [claudio](https://github.com/faisalaffan/claudio) | Anthropic SDK untuk ekosistem Dart | Dart | 1 |
| [coblosin](https://github.com/faisalaffan/coblosin) | SATU COBLOS "Satu Orang, Satu Coblos, Satu Masa Depan" | HTML | 0 |
| [creapud](https://github.com/faisalaffan/creapud) | Creative food website with unique food kind inside | Vue | 0 |
| [cukupgak](https://github.com/faisalaffan/cukupgak) | "Gaji segini udah gede?" — buktikan dengan angka | Vue | 0 |
| [delook-ecommerce](https://github.com/faisalaffan/delook-ecommerce) | Fashion E-commerce — frontend, mobile, backend, deployment, unit test | — | 0 |
| [eateel](https://github.com/faisalaffan/eateel) | Sistem FnB untuk platform Pecel Lele | — | 0 |
| [gedoong](https://github.com/faisalaffan/gedoong) | Platform jual-beli dan sewa properti | Vue | 0 |
| [geostack](https://github.com/faisalaffan/geostack) | Boilerplate REST API geospasial — Node.js, PostgreSQL/PostGIS | TypeScript | 0 |
| [gotrick](https://github.com/faisalaffan/gotrick) | Tips dan trik Golang untuk pengembangan masa depan | — | 0 |
| [jaheet](https://github.com/faisalaffan/jaheet) | Aplikasi clothing & convection dengan modul akuntansi | TypeScript | 0 |
| [nurture360](https://github.com/faisalaffan/nurture360) | Landing page platform omnichannel — hubungkan setiap touchpoint pelanggan | Vue | 0 |
| [otoman](https://github.com/faisalaffan/otoman) | OTOmotive for MANy people | — | 0 |
| [pytik](https://github.com/faisalaffan/pytik) | Don't be the pitik — tools & library produktivitas Python | — | 0 |
| [solidaritas](https://github.com/faisalaffan/solidaritas) | Smart contract untuk masa depan Indonesia — dibuat dengan Solidity | — | 0 |
| [testcast](https://github.com/faisalaffan/testcast) | Opinionated Playwright TypeScript scaffolder — arsitektur E2E sekali cast | TypeScript | 1 |

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
