import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/constants.dart';
import '../../../models/sugarData.dart';

class AsyncGlucoseNotifier extends AsyncNotifier<List<SugarData>> {
  Future<List<SugarData>> _getSugarLevel() async {
    final response = await supabase
        .from('diabetes_sugar')
        .select()
        .eq('personId', supabase.auth.currentUser!.id)
        .order('created_at', ascending: false);

    var sugarLevels = SugarData.getListMap(response);
    return sugarLevels;
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
