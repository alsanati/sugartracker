import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/models/meals.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';

class FeedPageState {
  final AsyncValue<List<Meal>> meals;
  final AsyncValue<List<SugarData>> sugarData;

  FeedPageState({required this.meals, required this.sugarData});
}
