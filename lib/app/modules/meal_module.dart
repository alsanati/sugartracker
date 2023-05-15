import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/meals.dart';

class MealRepository {
  final SupabaseClient supabase;

  MealRepository(this.supabase);

  // Add a meal to the database
  Future<void> addMeal(Meal meal, BuildContext context) async {
    try {
      final response = await supabase.from('meals').insert([
        {
          'patient_id': await supabase.patient.getCurrentPatientId(),
          'calories': meal.calories.round(),
          'total_carbohydrates': meal.carbs.round(),
          'protein': meal.protein.round(),
          'fat': meal.fat.round(),
          'mealTime': meal.mealTime.toIso8601String(),
          'created_at': meal.createdAt.toIso8601String(),
          'meal_type': meal.mealType.toString().split('.').last,
          'meal_name': meal.mealName,
        },
      ]);
      if (response == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Meal added")));
        }
      }
    } catch (error) {
      debugPrint(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unexpected error occured :("),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Get meals for a user
  Future<List<Meal>> getMeals() async {
    final response = await supabase.from('meals').select().eq('patientId', 29);

    if (response == null) {
      throw Exception('Failed to fetch meals: $response');
    } else {
      return (response as List)
          .map((mealJson) => Meal.fromJson(mealJson))
          .toList();
    }
  }
}
