import 'package:freezed_annotation/freezed_annotation.dart';

part 'meals.freezed.dart';
part 'meals.g.dart';

enum MealType { breakfast, lunch, dinner, snack }

@freezed
class Meal with _$Meal {
  factory Meal({
    required MealType mealType,
    required DateTime mealTime,
    required num carbs,
    required num protein,
    required num fat,
    required num calories,
    required String mealName,
    required DateTime createdAt,
  }) = _Meal;

  @override
  Map<String, dynamic> toJson() => {
        'mealType': mealType.toString().split('.').last,
        'mealTime': mealTime.toIso8601String(),
        'carbs': carbs,
        'protein': protein,
        'fat': fat,
        'calories': calories,
        'mealName': mealName,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}
