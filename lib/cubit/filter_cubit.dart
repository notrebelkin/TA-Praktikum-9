import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/pengaturan_helper.dart';

/// State = status filter yang sedang aktif ('Semua', 'Baru', ...).
class FilterCubit extends Cubit<String> {
  FilterCubit() : super(PengaturanHelper.muatFilter());

  Future<void> setFilter(String filter) async {
    await PengaturanHelper.simpanFilter(filter);
    if (!isClosed) emit(filter);
  }

  Future<void> reset() async {
    await PengaturanHelper.resetFilter();
    if (!isClosed) emit('Semua');
  }
}
