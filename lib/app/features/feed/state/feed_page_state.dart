import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/models/meals.dart';
import 'package:sugar_tracker/app/modules/meal_module.dart';

import '../../../models/feed_data.dart';
import '../../../models/sugar_data.dart';
import '../../../utils/constants.dart';

/*
final feedPageProvider = FutureProvider<FeedPageData>((ref) async {
  // Fetch sugar level data, meal data, and activity data
  final sugarLevelData = await ref.watch(sugarLevelDataProvider.future);

  // Create a FeedPageData instance containing the fetched data
  return FeedPageData(
    sugarLevelData: sugarLevelData,
  );
});

final sugarLevelDataProvider = FutureProvider<List<SugarData>>((ref) async {
  // Fetch the sugar level data list
  final sugarLevelData =  await getSugarStats();
  return sugarLevelData;
});
*/

final sugarDataProvider =
    StateNotifierProvider<SugarDataNotifier, List<SugarData>?>((ref) {
  final notifier = SugarDataNotifier();
  notifier.subscribeToSugarDataChanges();
  return notifier;
});

class SugarDataNotifier extends StateNotifier<List<SugarData>?> {
  StreamSubscription<List<Map<String, dynamic>>>? _subscription;

  SugarDataNotifier() : super(null);

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void subscribeToSugarDataChanges() {
    _subscription?.cancel();
    _subscription = supabase.from('diabetes_sugar').stream(
        primaryKey: ['person_id']).listen((List<Map<String, dynamic>> data) {
      // Process the incoming data
      final sugarDataList = SugarData.getListMap(data);

      // Update the state
      state = sugarDataList;
    });
  }
}

class FeedPageDataNotifier extends StateNotifier<FeedPageData> {
  FeedPageDataNotifier() : super(FeedPageData(feedData: []));

  void updateFeedData(
    List<SugarData> sugarDataList,
  ) {
    List<FeedData> newFeedData = [];

    // Convert SugarData and Meal objects to FeedData objects
    newFeedData.addAll(
        sugarDataList.map((sugarData) => FeedData.fromSugarData(sugarData)));

    // Sort the feed data by date (you can customize the sorting logic if needed)
    newFeedData.sort((a, b) => b.date.compareTo(a.date));

    // Update the state with the new feed data
    state = FeedPageData(feedData: newFeedData);
  }
}

final feedPageDataNotifierProvider =
    StateNotifierProvider<FeedPageDataNotifier, FeedPageData>((ref) {
  return FeedPageDataNotifier();
});

final sugarStreamProvider = StreamProvider.autoDispose<List<SugarData>>((ref) {
  return supabase
      .from('diabetes_sugar')
      .stream(primaryKey: ['id']).map((List<Map<String, dynamic>> data) {
    List<SugarData> sugarDataList = SugarData.getListMap(data);
    // Fetch mealList from another provider or method
    return sugarDataList;
  });
});

final mealStreamProvider = StreamProvider.autoDispose<List<Meal>>((ref) async* {
  MealRepository meals = MealRepository(supabase);
  final mealRepository = await meals.getMeals();
  yield mealRepository;
});
