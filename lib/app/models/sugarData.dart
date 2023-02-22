// ignore_for_file: unnecessary_this, unnecessary_null_comparison

class SugarData {
  int? id;
  String? personId;
  String? createdAt;
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
      createdAt: json['createdAt'] as String,
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
      sugarLevels.add(SugarData(
          id: data['id'],
          personId: data['personId'],
          sugarLevel: data['sugar_level'],
          createdAt: data['created_at']));
    }
    return sugarLevels;
  }
}
