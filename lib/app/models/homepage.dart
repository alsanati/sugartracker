import 'package:sugar_tracker/app/models/meals.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';

class HomepageState {
  final String user;
  final List<SugarData> sugarData;
  final List<Meal> meals;

  HomepageState(
      {required this.user, required this.sugarData, required this.meals});
}
