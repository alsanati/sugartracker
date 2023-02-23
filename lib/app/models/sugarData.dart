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

  static dynamic convertTimeStampToDay(List<SugarData> items) {
    if (items == null) {
      return null;
    }

    List<SugarData> sugarLevels = [];
    for (var i = 0; i < items.length; i++) {
      var timestampString = items[i].createdAt!;
      var correctFormat = DateFormat('dd/MM');
      var correctDate = correctFormat.format(timestampString);

      var sugarData = SugarData(
          id: items[i].id,
          personId: items[i].personId,
          sugarLevel: items[i].sugarLevel,
          createdAt: timestampString);

      sugarLevels.add(sugarData);
    }
    return sugarLevels;
  }
}
