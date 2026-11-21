import 'package:flutter/material.dart';
import '../helpers/hive_helper.dart';
import '../helpers/laporan_logic.dart';
import '../models/laporan_fasilitas.dart';

class HalamanTambah extends StatefulWidget {
  const HalamanTambah({super.key});

  @override
  State<HalamanTambah> createState() => _HalamanTambahState();
}

class _HalamanTambahState extends State<HalamanTambah> {
  final _formKey = GlobalKey<FormState>();
  final _kode = TextEditingController();
  final _jenis = TextEditingController();
  final _lokasi = TextEditingController();

  @override
  void dispose() {
    _kode.dispose();
    _jenis.dispose();
    _lokasi.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;

    final kode = normalisasiKode(_kode.text);
    await boxLaporan.put(
      kode,
      LaporanFasilitas(
        kode: kode,
        jenis: _jenis.text.trim(),
        lokasi: _lokasi.text.trim(),
      ),
    );

    _kode.clear();
    _jenis.clear();
    _lokasi.clear();
    _formKey.currentState!.reset();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Laporan $kode berhasil disimpan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Laporan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _kode,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Kode laporan',
                hintText: 'Contoh: SC01',
                border: OutlineInputBorder(),
              ),
              validator: (v) => validasiKode(v, boxLaporan.containsKey),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _jenis,
              decoration: const InputDecoration(
                labelText: 'Jenis kerusakan',
                hintText: 'Contoh: Lampu jalan mati',
                border: OutlineInputBorder(),
              ),
              validator: (v) => validasiWajib(v, 'Jenis'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _lokasi,
              decoration: const InputDecoration(
                labelText: 'Lokasi',
                hintText: 'Contoh: Jl. Melati',
                border: OutlineInputBorder(),
              ),
              validator: (v) => validasiWajib(v, 'Lokasi'),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _simpan,
              icon: const Icon(Icons.save),
              label: const Text('Simpan laporan'),
            ),
            const SizedBox(height: 8),
            const Text('Status awal laporan selalu "Baru".'),
          ],
        ),
      ),
    );
  }
}
