import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/models/sign_up.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final diabetesTypeProvider = StateProvider<String>((ref) {
  return 'Type 1';
});

final formControllersProvider = Provider<FormControllers>((ref) {
  return FormControllers();
});
