import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'food_item.dart'; // Import the FoodItem class

part 'meals.freezed.dart';
part 'meals.g.dart';

enum MealType { breakfast, lunch, dinner, snack }

@freezed
class Meal with _$Meal {
  factory Meal({
    required int mealId,
    required int userId,
    required MealType mealType,
    required DateTime mealDate,
    required DateTime mealTime,
    required List<FoodItem> foodItems,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}
