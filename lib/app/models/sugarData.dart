// ignore_for_file: unnecessary_this, unnecessary_null_comparison

import 'package:intl/intl.dart';

class SugarData {
  int? id;
  String? personId;
  DateTime? createdAt;
  int? sugarLevel;

  SugarData({this.id, this.personId, this.createdAt, this.sugarLevel});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'personId': this.personId,
      'createdAt': this.createdAt,
      'sugarLevel': this.sugarLevel,
    };
  }

  factory SugarData.fromJson(dynamic json) {
    return SugarData(
      id: json['id'] as int,
      personId: json['personId'] as String,
      createdAt: json['createdAt'] as DateTime,
      sugarLevel: json['sugarLevel'] as int,
    );
  }

  Map<String, dynamic> toJson(response) => <String, dynamic>{
        'id': id,
        'personId': personId,
        'createdAt': createdAt,
        'sugarLevel': sugarLevel
      };

  static dynamic getListMap(List<dynamic> items) {
    if (items == null) {
      return null;
    }
    List<SugarData> sugarLevels = [];
    for (var i = 0; i < items.length; i++) {
      final data = items[i];
      final date = data["created_at"];
      final correctFormat =
          date != null ? DateTime.parse(date) : DateTime.now();
      sugarLevels.add(SugarData(
          id: data['id'],
          personId: data['personId'],
          sugarLevel: data['sugar_level'],
          createdAt: correctFormat));
    }
    return sugarLevels;
  }

  static List<SugarData> getLast7DaysEntries(List<SugarData> sugarDataList) {
    List<SugarData> last7DaysEntries = [];

    // Sort the list of SugarData objects in descending order based on their createdAt property
    sugarDataList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Loop through the sorted list and add the entries for the last 7 days to the new list
    for (var i = 0; i < sugarDataList.length; i++) {
      SugarData sugarData = sugarDataList[i];
      Duration difference = currentDate.difference(sugarData.createdAt!);
      if (difference.inDays <= 6) {
        last7DaysEntries.add(sugarData);
      }
    }

    return last7DaysEntries;
  }

  static List<SugarData> groupByDay(List<SugarData> items) {
    final Map<String, List<SugarData>> groupedItems = {};

    // Group items by day
    for (var item in items) {
      final date = DateFormat('dd/MM/yyyy').format(item.createdAt!);
      if (!groupedItems.containsKey(date)) {
        groupedItems[date] = [];
      }
      groupedItems[date]!.add(item);
    }

    // Calculate average sugar level for each day
    final List<SugarData> result = [];
    groupedItems.forEach((key, value) {
      final avgSugarLevel =
          value.map((e) => e.sugarLevel!).reduce((a, b) => a + b) /
              value.length;
      final item = SugarData(
        id: value.first.id,
        personId: value.first.personId,
        sugarLevel: avgSugarLevel.round(),
        createdAt: value.first.createdAt,
      );
      result.add(item);
    });

    // Sort by date and return the last 7 days
    result.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return result.take(7).toList();
  }
}
