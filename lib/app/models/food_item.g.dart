// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FoodItem _$$_FoodItemFromJson(Map<String, dynamic> json) => _$_FoodItem(
      foodId: json['foodId'] as int,
      name: json['name'] as String,
      calories: json['calories'] as int,
      servingSize: json['servingSize'] as String?,
      servingUnit: json['servingUnit'] as String?,
    );

Map<String, dynamic> _$$_FoodItemToJson(_$_FoodItem instance) =>
    <String, dynamic>{
      'foodId': instance.foodId,
      'name': instance.name,
      'calories': instance.calories,
      'servingSize': instance.servingSize,
      'servingUnit': instance.servingUnit,
    };
