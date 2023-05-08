import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/utils/constants.dart';
import '../../../models/sugar_data.dart';

class AsyncGlucoseNotifier extends StateNotifier<AsyncValue<List<SugarData>>> {
  final int days;

  AsyncGlucoseNotifier({required this.days})
      : super(const AsyncValue.loading()) {
    fetchData();
  }

  Future<void> fetchData() async {
    state = const AsyncValue.loading();
    try {
      List<SugarData> data = await _getSugarLevel();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<SugarData>> _getSugarLevel() async {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: days));

    final response = await supabase
        .from('diabetes_sugar')
        .select()
        .eq('personId', supabase.auth.currentUser!.id)
        .filter('created_at', 'gte', startDate.toIso8601String())
        .filter('created_at', 'lte', now.toIso8601String())
        .order('created_at', ascending: true);

    List<SugarData> sugarLevels = SugarData.getListMap(response);
    return sugarLevels;
  }

  Future<List<SugarData>> build() async {
    return _getSugarLevel();
  }
}

final asyncGlucoseNotifier = StateNotifierProvider.autoDispose
    .family<AsyncGlucoseNotifier, AsyncValue<List<SugarData>>, int>(
        (ref, days) {
  return AsyncGlucoseNotifier(days: days);
});

final sevenDaysProvider = StateProvider((ref) => false);
final fourTeenDaysProvider = StateProvider((ref) => false);
final thirtyDaysProvider = StateProvider((ref) => false);
