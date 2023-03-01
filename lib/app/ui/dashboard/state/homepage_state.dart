import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/constants.dart';

import '../../../models/sugarData.dart';
import '../../../modules/supabase_modules.dart';

final supabaseHelper = SupabaseHelpers();

final userProvider = FutureProvider((ref) async {
  var currentUser = supabaseHelper.getCurrentUser();
  return currentUser;
});

final sugarDataProvider = FutureProvider<List<SugarData>>((ref) async {
  // Here you would fetch the sugar data from your data source
  // and return a List<SugarData>.
  final response = await supabase
      .from('diabetes_sugar')
      .select()
      .eq('personId', supabase.auth.currentUser!.id)
      .order('created_at', ascending: false);

  List<SugarData> sugarLevels = SugarData.getListMap(response);
  return sugarLevels;
});
