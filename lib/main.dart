import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/filter_cubit.dart';
import 'helpers/hive_helper.dart';
import 'helpers/pengaturan_helper.dart';
import 'pages/halaman_laporan.dart';
import 'pages/halaman_pengaturan.dart';
import 'pages/halaman_tambah.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bukaBoxLaporan();
  await PengaturanHelper.init();

  runApp(
    BlocProvider(
      create: (_) => FilterCubit(),
      child: const PelaporanApp(),
    ),
  );
}

class PelaporanApp extends StatelessWidget {
  const PelaporanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pelaporan Fasilitas Kota',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int index = 0;

  final halaman = const [
    HalamanLaporan(),
    HalamanTambah(),
    HalamanPengaturan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: halaman),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (nilai) => setState(() => index = nilai),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'Laporan'),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Tambah',
          ),
          NavigationDestination(icon: Icon(Icons.tune), label: 'Filter'),
        ],
      ),
    );
  }
}
