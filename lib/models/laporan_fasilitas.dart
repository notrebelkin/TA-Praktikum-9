import 'package:hive/hive.dart';

part 'laporan_fasilitas.g.dart';

/// Daftar status yang valid untuk sebuah laporan.
const List<String> daftarStatus = ['Baru', 'Diproses', 'Selesai'];

/// Nilai filter: semua status ditambah opsi 'Semua'.
const List<String> daftarFilter = ['Semua', ...daftarStatus];

@HiveType(typeId: 0)
class LaporanFasilitas {
  @HiveField(0)
  final String kode;

  @HiveField(1)
  final String jenis;

  @HiveField(2)
  final String lokasi;

  @HiveField(3)
  final String status;

  const LaporanFasilitas({
    required this.kode,
    required this.jenis,
    required this.lokasi,
    this.status = 'Baru',
  });

  LaporanFasilitas copyWith({String? status}) {
    return LaporanFasilitas(
      kode: kode,
      jenis: jenis,
      lokasi: lokasi,
      status: status ?? this.status,
    );
  }
}
