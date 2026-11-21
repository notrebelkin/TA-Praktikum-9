import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../cubit/filter_cubit.dart';
import '../helpers/hive_helper.dart';
import '../helpers/laporan_logic.dart';
import '../models/laporan_fasilitas.dart';
import '../widgets/laporan_card.dart';

class HalamanLaporan extends StatelessWidget {
  const HalamanLaporan({super.key});

  /// Ubah status: tulis ulang lewat kode (key) yang sama.
  Future<void> _ubahStatus(
    BuildContext context,
    LaporanFasilitas laporan,
    String statusBaru,
  ) async {
    await boxLaporan.put(laporan.kode, laporan.copyWith(status: statusBaru));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${laporan.kode} diubah menjadi $statusBaru')),
      );
    }
  }

  Future<void> _hapus(BuildContext context, LaporanFasilitas laporan) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus laporan?'),
        content: Text('Hapus laporan ${laporan.kode} (${laporan.jenis})?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (konfirmasi == true) {
      await boxLaporan.delete(laporan.kode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<FilterCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Fasilitas Kota')),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                for (final f in daftarFilter)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(f),
                      selected: filter == f,
                      onSelected: (_) =>
                          context.read<FilterCubit>().setFilter(f),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<LaporanFasilitas>>(
              valueListenable: boxLaporan.listenable(),
              builder: (context, box, _) {
                final daftar = filterLaporan(box.values, filter);
                if (daftar.isEmpty) {
                  return Center(
                    child: Text(
                      box.isEmpty
                          ? 'Belum ada laporan'
                          : 'Tidak ada laporan berstatus $filter',
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    final laporan = daftar[index];
                    return LaporanCard(
                      laporan: laporan,
                      onUbahStatus: (s) => _ubahStatus(context, laporan, s),
                      onHapus: () => _hapus(context, laporan),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
