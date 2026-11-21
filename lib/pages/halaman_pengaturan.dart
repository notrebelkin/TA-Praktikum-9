import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/filter_cubit.dart';
import '../models/laporan_fasilitas.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<FilterCubit>().state;
    final cubit = context.read<FilterCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Filter')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Filter status laporan disimpan dengan SharedPreferences '
            '(key: filter_status_laporan).',
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            key: ValueKey(filter),
            initialValue: filter,
            decoration: const InputDecoration(
              labelText: 'Filter status',
              border: OutlineInputBorder(),
            ),
            items: [
              for (final f in daftarFilter)
                DropdownMenuItem(value: f, child: Text(f)),
            ],
            onChanged: (nilai) {
              if (nilai != null) cubit.setFilter(nilai);
            },
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: cubit.reset,
            child: const Text('Reset filter ke Semua'),
          ),
          const SizedBox(height: 8),
          const Text('Reset filter tidak menghapus laporan di Hive.'),
        ],
      ),
    );
  }
}
