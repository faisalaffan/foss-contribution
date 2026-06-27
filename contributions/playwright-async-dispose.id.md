[🇬🇧 English](playwright-async-dispose.md) | [🇮🇩 Bahasa Indonesia](playwright-async-dispose.id.md)

# microsoft/playwright — Hapus async yang tidak terpakai dari callback dispose eventsHelper

## Konteks

Playwright adalah framework otomatisasi browser Microsoft (91.7k+ stars). Modul `eventsHelper` membungkus Node.js `EventEmitter` dengan `RegisteredListener` yang memiliki metode `dispose()`. Metode ini diketik sebagai `async` tetapi `emitter.removeListener()` yang mendasarinya bersifat sinkron — menciptakan Promise dan microtask yang tidak perlu di setiap pembersihan.

## Masalah (Akar Penyebab)

`emitter.removeListener()` bersifat sinkron. Membungkus callback dispose dalam `async` menciptakan Promise dan microtask yang tidak perlu di setiap pembersihan listener. Nol pemanggil melakukan `await` pada hasil dispose — kata kunci `async` tidak memberikan nilai, hanya overhead.

## Pendekatan

- `RegisteredListener.dispose`: `() => Promise<void>` → `() => void`
- `Disposable.dispose` di isomorphic/disposable.ts: perubahan tipe yang sama untuk kompatibilitas
- Menghapus kata kunci `async` dari arrow function dispose

## Dampak

- 3 penambahan, 3 penghapusan di 2 file
- Menghilangkan alokasi Promise dan microtask per pembersihan listener
- Zero behavior change — tidak ada pemanggil yang menunggu hasilnya

## File yang Diubah

| File | Penambahan | Penghapusan |
|------|------------|-------------|
| `packages/isomorphic/disposable.ts` | +1 | -1 |
| `packages/utils/eventsHelper.ts` | +2 | -2 |

## Tautan

- PR: [microsoft/playwright#41503](https://github.com/microsoft/playwright/pull/41503)
