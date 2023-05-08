// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Meal _$$_MealFromJson(Map<String, dynamic> json) => _$_Meal(
      mealId: json['mealId'] as int,
      userId: json['userId'] as int,
      mealType: $enumDecode(_$MealTypeEnumMap, json['mealType']),
      mealDate: DateTime.parse(json['mealDate'] as String),
      mealTime: DateTime.parse(json['mealTime'] as String),
      foodItems: (json['foodItems'] as List<dynamic>)
          .map((e) => FoodItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_MealToJson(_$_Meal instance) => <String, dynamic>{
      'mealId': instance.mealId,
      'userId': instance.userId,
      'mealType': _$MealTypeEnumMap[instance.mealType]!,
      'mealDate': instance.mealDate.toIso8601String(),
      'mealTime': instance.mealTime.toIso8601String(),
      'foodItems': instance.foodItems,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$MealTypeEnumMap = {
  MealType.breakfast: 'breakfast',
  MealType.lunch: 'lunch',
  MealType.dinner: 'dinner',
  MealType.snack: 'snack',
};
