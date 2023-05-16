import 'package:flutter/material.dart';
import 'sugar_data.dart'; // Import the SugarData class
import 'meals.dart'; // Import the Meal class

class FeedData {
  final FeedDataType feedDataType;
  final IconData icon;
  final String title;
  final String description;
  final DateTime date;

  FeedData({
    required this.feedDataType,
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
  });

  factory FeedData.fromSugarData(SugarData sugarData) {
    return FeedData(
      feedDataType: FeedDataType.sugarLevel,
      icon: Icons.track_changes,
      title: "Sugar Level",
      description: "Sugar level: ${sugarData.sugarLevel}",
      date: sugarData.createdAt!,
    );
  }

  factory FeedData.fromMeal(Meal meal) {
    return FeedData(
      feedDataType: FeedDataType.meal,
      icon: Icons.fastfood,
      title: "Meal",
      description: "Meal type: ${meal.mealType}",
      date: meal.mealTime,
    );
  }
}

enum FeedDataType { sugarLevel, meal, activity }

class FeedPageData {
  final List<FeedData> feedData;

  FeedPageData({required this.feedData});
}
