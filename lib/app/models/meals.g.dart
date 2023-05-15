// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Meal _$$_MealFromJson(Map<String, dynamic> json) => _$_Meal(
      mealType: $enumDecode(_$MealTypeEnumMap, json['mealType']),
      mealTime: DateTime.parse(json['mealTime'] as String),
      carbs: json['carbs'] as num,
      protein: json['protein'] as num,
      fat: json['fat'] as num,
      calories: json['calories'] as num,
      mealName: json['mealName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_MealToJson(_$_Meal instance) => <String, dynamic>{
      'mealType': _$MealTypeEnumMap[instance.mealType]!,
      'mealTime': instance.mealTime.toIso8601String(),
      'carbs': instance.carbs,
      'protein': instance.protein,
      'fat': instance.fat,
      'calories': instance.calories,
      'mealName': instance.mealName,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$MealTypeEnumMap = {
  MealType.breakfast: 'breakfast',
  MealType.lunch: 'lunch',
  MealType.dinner: 'dinner',
  MealType.snack: 'snack',
};
