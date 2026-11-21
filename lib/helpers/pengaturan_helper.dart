import 'package:shared_preferences/shared_preferences.dart';
import '../models/laporan_fasilitas.dart';

class PengaturanHelper {
  PengaturanHelper._();

  static const String _filter = 'filter_status_laporan';
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Membaca filter tersimpan. Nilai tidak dikenal/null menjadi 'Semua'.
  static String muatFilter() {
    final nilai = _prefs.getString(_filter);
    return daftarFilter.contains(nilai) ? nilai! : 'Semua';
  }

  static Future<void> simpanFilter(String filter) async {
    await _prefs.setString(_filter, filter);
  }

  static Future<void> resetFilter() async {
    await _prefs.remove(_filter);
  }
}
