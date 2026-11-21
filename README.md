# Pelaporan Fasilitas Kota

Tugas Akhir Praktikum Modul 9 - Penyimpanan Lokal Flutter
Mata Kuliah Pemrograman Perangkat Bergerak Lanjut (D4 Sistem Informasi Kota Cerdas, Telkom University)

Aplikasi untuk membuat laporan fasilitas publik (lampu jalan mati, trotoar rusak, tempat sampah penuh).

| Kebutuhan | Implementasi |
|---|---|
| Penyimpanan laporan | Hive, Box `laporanFasilitasBox`, key = kode laporan (mis. `SC01`) |
| Model | `LaporanFasilitas` (`@HiveType(typeId: 0)`; field 0-3: kode, jenis, lokasi, status) + adapter |
| Preferensi | SharedPreferences, key `filter_status_laporan` |
| State filter | `FilterCubit` (Cubit<String>) |
| Navigasi | `NavigationBar` + `IndexedStack` (3 tab: Laporan, Tambah, Filter) |

## Struktur folder

```
lib/
  main.dart
  models/        laporan_fasilitas.dart, laporan_fasilitas.g.dart (adapter)
  helpers/       hive_helper.dart, pengaturan_helper.dart, laporan_logic.dart
  cubit/         filter_cubit.dart
  widgets/       laporan_card.dart
  pages/         halaman_laporan.dart, halaman_tambah.dart, halaman_pengaturan.dart
test/
  laporan_test.dart
```

## Cara menjalankan

ZIP ini hanya berisi kode sumber (tanpa folder android/ios/web). Buat folder platform dahulu:

```
cd pelaporan_fasilitas_kota
flutter create --platforms=android,ios,web .
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # opsional, adapter sudah disertakan
flutter analyze
flutter test
flutter run
```

Jika `flutter create` menghasilkan `test/widget_test.dart` bawaan, hapus file tersebut karena merujuk ke `MyApp`.

Jika `flutter pub get` gagal karena bentrok versi, hapus `hive_generator` dan `build_runner`
dari `pubspec.yaml` (adapter `.g.dart` sudah ada, jadi generator tidak wajib), lalu ulangi.

## Skenario uji minimal

1. Tambah `SC01` (Lampu jalan mati, Jl. Melati) dan `SC02` (Trotoar rusak, Jl. Kenanga).
2. Coba kode duplikat `SC01` dan lokasi kosong: ditolak.
3. Ubah `SC01` menjadi Selesai, pilih filter Baru.
4. Tutup aplikasi sepenuhnya, buka lagi: hanya `SC02` tampak.
5. Reset filter ke Semua, hapus `SC02` dengan konfirmasi.
