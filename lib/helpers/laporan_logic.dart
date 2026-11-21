import '../models/laporan_fasilitas.dart';

/// Validasi kolom wajib (kode, jenis, lokasi). Mengembalikan pesan galat
/// atau null jika valid.
String? validasiWajib(String? nilai, String label) {
  if (nilai == null || nilai.trim().isEmpty) {
    return '$label tidak boleh kosong';
  }
  return null;
}

/// Normalisasi kode: hilangkan spasi tepi dan ubah ke huruf besar,
/// sehingga "sc01" dan "SC01" dianggap kode yang sama.
String normalisasiKode(String kode) => kode.trim().toUpperCase();

/// Validasi kode: wajib diisi dan tidak boleh duplikat.
String? validasiKode(String? nilai, bool Function(String kode) sudahAda) {
  final kosong = validasiWajib(nilai, 'Kode');
  if (kosong != null) return kosong;
  if (sudahAda(normalisasiKode(nilai!))) {
    return 'Kode ${normalisasiKode(nilai)} sudah digunakan';
  }
  return null;
}

/// Menyaring daftar laporan berdasarkan status. 'Semua' = tanpa filter.
List<LaporanFasilitas> filterLaporan(
  Iterable<LaporanFasilitas> semua,
  String filter,
) {
  if (filter == 'Semua') return semua.toList();
  return semua.where((l) => l.status == filter).toList();
}
