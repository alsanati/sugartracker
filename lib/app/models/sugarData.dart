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

  static dynamic getListMap(List<dynamic> items) {
    if (items == null) {
      return null;
    }
    List<Map<String, dynamic>> list = [];
    items.forEach((element) {
      list.add(element.toMap());
    });
    return list;
  }
}
