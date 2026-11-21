import 'package:flutter_test/flutter_test.dart';
import 'package:pelaporan_fasilitas_kota/helpers/laporan_logic.dart';
import 'package:pelaporan_fasilitas_kota/models/laporan_fasilitas.dart';

void main() {
  const sc01 = LaporanFasilitas(
    kode: 'SC01',
    jenis: 'Lampu jalan mati',
    lokasi: 'Jl. Melati',
  );
  const sc02 = LaporanFasilitas(
    kode: 'SC02',
    jenis: 'Trotoar rusak',
    lokasi: 'Jl. Kenanga',
  );

  group('Validasi', () {
    test('kode kosong ditolak', () {
      expect(validasiKode('  ', (_) => false), isNotNull);
      expect(validasiKode(null, (_) => false), isNotNull);
    });

    test('kode duplikat ditolak (tidak peka huruf besar/kecil)', () {
      expect(validasiKode('sc01', (k) => k == 'SC01'), isNotNull);
    });

    test('kode baru diterima', () {
      expect(validasiKode('SC03', (k) => k == 'SC01'), isNull);
    });

    test('jenis dan lokasi kosong ditolak', () {
      expect(validasiWajib('', 'Jenis'), isNotNull);
      expect(validasiWajib('   ', 'Lokasi'), isNotNull);
      expect(validasiWajib('Jl. Melati', 'Lokasi'), isNull);
    });
  });

  group('Model', () {
    test('status awal Baru dan copyWith hanya mengubah status', () {
      expect(sc01.status, 'Baru');
      final selesai = sc01.copyWith(status: 'Selesai');
      expect(selesai.status, 'Selesai');
      expect(selesai.kode, 'SC01');
      expect(selesai.lokasi, 'Jl. Melati');
    });
  });

  group('Filter', () {
    final data = [sc01.copyWith(status: 'Selesai'), sc02];

    test('Semua menampilkan seluruh laporan', () {
      expect(filterLaporan(data, 'Semua').length, 2);
    });

    test('filter Baru hanya menampilkan SC02 (skenario minimal)', () {
      final hasil = filterLaporan(data, 'Baru');
      expect(hasil.length, 1);
      expect(hasil.first.kode, 'SC02');
    });
  });
}
