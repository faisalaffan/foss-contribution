[🇬🇧 English](tinyclaw-tinyclaw.md) | [🇮🇩 Bahasa Indonesia](tinyclaw-tinyclaw.id.md)

# tinyclaw/tinyclaw — PathGuard cegah path traversal di write_file/delete_file

## Konteks

tinyclaw adalah CLI AI coding agent. Tool `write_file` dan `delete_file` menerima path file langsung dari output LLM tanpa validasi — agent bisa menulis atau menghapus file di mana saja di filesystem.

## Masalah (Akar Penyebab)

**Agent tools mempercayai output LLM sebagai input aman.** Tool `write_file` dan `delete_file` meneruskan path file dari LLM langsung ke `fs.writeFileSync` / `fs.rmSync` tanpa pengecekan batasan. Penyerang bisa:

- Menginstruksikan AI via prompt injection untuk menulis `~/.ssh/authorized_keys` — **backdoor SSH**
- Menghapus file sistem kritis (`/etc/...`) — **kerusakan OS**
- Menimpa file konfigurasi tinyclaw sendiri — **membajak provider/API key**
- Menulis ke `/etc/cron.d/` — **remote code execution persisten**
- Keluar dari direktori kerja menggunakan `../` — **path traversal**

Kerentanan kelas yang sama menimpa OpenClaw (proyek yang menginspirasi tinyclaw) berkali-kali — menghasilkan 3 CVE/GHSA (GHSA-qrq5-wjgg-rvqw, GHSA-xwjm-j929-xq7c, GHSA-cv7m-c9jx-vg7q) dan issue kritis (#39672). Ini akhirnya mendorong mereka membuat library khusus (`@openclaw/fs-safe`) untuk keamanan path.

## Pendekatan

Menambahkan fungsi `guardFilePath()` yang memvalidasi setiap path file sebelum operasi fs:

- **Resolve symlink** — mencegah symlink-based escape ke luar direktori yang diizinkan
- **Tolak null byte** — mencegah injeksi null byte untuk menyamarkan ekstensi file
- **Blokir special file** — menolak path di bawah `/dev/`, `/proc/`, `/sys/`
- **Kanonikalisasi path** — resolve `../` dan `./` sebelum validasi
- **Validasi terhadap direktori yang diizinkan** — path harus tetap dalam batas yang diizinkan

`cwd` yang diberikan LLM juga divalidasi terhadap direktori yang diizinkan, fallback ke default aman jika ditolak.

Ukuran file maksimum diberlakukan (10 MB default) untuk mencegah DoS kehabisan disk.

## Dampak

- Semua pemanggilan `write_file` dan `delete_file` sekarang melalui validasi path
- 10 test keamanan khusus: path traversal, null byte, symlink, special file, dan validasi cwd
- Tingkat perlindungan setara dengan `@openclaw/fs-safe` — library yang dibangun OpenClaw setelah insiden mereka

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `packages/core/src/tools/paths.ts` | +47 | -0 |
| `packages/core/src/tools/builtin.ts` | +24 | -4 |
| `packages/core/src/tools/builtin.test.ts` | +134 | -0 |

## Tautan

- PR: [ahmadrosid/tinyclaw#4](https://github.com/ahmadrosid/tinyclaw/pull/4)
- Prior art: [GHSA-qrq5-wjgg-rvqw](https://github.com/openclaw/openclaw/security/advisories/GHSA-qrq5-wjgg-rvqw)
- Prior art: [openclaw/openclaw#39672](https://github.com/openclaw/openclaw/issues/39672)
