import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/supabase_modules.dart';

final supabaseHelper = SupabaseHelpers();

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final diabetesTypeProvider = StateProvider<String>((ref) {
  return 'Type 1';
});
