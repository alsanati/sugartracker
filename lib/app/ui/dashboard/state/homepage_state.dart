import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/modules/supabase_modules.dart';

final supabase = SupabaseHelpers();

final userProvider = FutureProvider((ref) async {
  var currentUser = supabase.getCurrentUser();
  return currentUser;
});
