import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/meals.dart';

class MealRepository {
  final SupabaseClient supabase;

  MealRepository(this.supabase);

  // Add a meal to the database
  Future<void> addMeal(Meal meal) async {
    final response = await supabase.from('meals').insert([
      {
        'mealId': meal.mealId,
        'userId': meal.userId,
        'mealType': meal.mealType.toString(),
        'mealDate': meal.mealDate.toIso8601String(),
        'mealTime': meal.mealTime.toIso8601String(),
        'foodItems': meal.foodItems.map((item) => item.toJson()).toList(),
        'createdAt': meal.createdAt.toIso8601String(),
        'updatedAt': meal.updatedAt.toIso8601String(),
      },
    ]);

    if (response.status != 200) {
      throw Exception('Failed to add meal: ${response.status}');
    }
  }

  // Get meals for a user
  Future<List<Meal>> getMeals(int userId) async {
    final response =
        await supabase.from('meals').select().eq('userId', userId).execute();

    if (response.status != 200) {
      throw Exception('Failed to fetch meals: ${response.status}');
    } else {
      return (response.data as List)
          .map((mealJson) => Meal.fromJson(mealJson))
          .toList();
    }
  }
}
