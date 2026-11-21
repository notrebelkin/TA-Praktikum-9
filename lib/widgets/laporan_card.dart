import 'package:flutter/material.dart';
import '../models/laporan_fasilitas.dart';

class LaporanCard extends StatelessWidget {
  final LaporanFasilitas laporan;
  final ValueChanged<String> onUbahStatus;
  final VoidCallback onHapus;

  const LaporanCard({
    super.key,
    required this.laporan,
    required this.onUbahStatus,
    required this.onHapus,
  });

  Color _warna(String status) {
    switch (status) {
      case 'Diproses':
        return Colors.orange;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _warna(laporan.status),
          foregroundColor: Colors.white,
          child: const Icon(Icons.report_problem_outlined),
        ),
        title: Text('${laporan.kode} - ${laporan.jenis}'),
        subtitle: Text('${laporan.lokasi}\nStatus: ${laporan.status}'),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              tooltip: 'Ubah status',
              icon: const Icon(Icons.edit_note),
              onSelected: onUbahStatus,
              itemBuilder: (_) => [
                for (final s in daftarStatus)
                  PopupMenuItem(
                    value: s,
                    enabled: s != laporan.status,
                    child: Text(s),
                  ),
              ],
            ),
            IconButton(
              tooltip: 'Hapus laporan',
              icon: const Icon(Icons.delete_outline),
              onPressed: onHapus,
            ),
          ],
        ),
      ),
    );
  }
}
