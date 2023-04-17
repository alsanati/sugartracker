import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/utils/constants.dart';
import '../../../models/sugar_data.dart';

class AsyncGlucoseNotifier extends AsyncNotifier<List<SugarData>> {
  Future<List<SugarData>> _getSugarLevel() async {
    final response = await supabase
        .from('diabetes_sugar')
        .select()
        .eq('personId', supabase.auth.currentUser!.id)
        .order('created_at', ascending: true);

    List<SugarData> sugarLevels = SugarData.getListMap(response);
    List<SugarData> lastSevenEntries =
        SugarData.getLast7DaysEntries(sugarLevels);
    List<SugarData> groupedByDay = SugarData.groupByDay(lastSevenEntries);
    return groupedByDay;
  }

  @override
  Future<List<SugarData>> build() async {
    return _getSugarLevel();
  }
}

final asyncGlucoseNotifier =
    AsyncNotifierProvider<AsyncGlucoseNotifier, List<SugarData>>(() {
  return AsyncGlucoseNotifier();
});

final sevenDaysProvider = StateProvider((ref) => false);
final fourTeenDaysProvider = StateProvider((ref) => false);
final thirtyDaysProvider = StateProvider((ref) => false);
