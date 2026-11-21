import 'package:hive_flutter/hive_flutter.dart';
import '../models/laporan_fasilitas.dart';

late final Box<LaporanFasilitas> boxLaporan;

/// Urutan: inisialisasi Hive -> daftarkan adapter -> buka Box.
Future<void> bukaBoxLaporan() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LaporanFasilitasAdapter());
  boxLaporan = await Hive.openBox<LaporanFasilitas>('laporanFasilitasBox');
}
