import 'package:freezed_annotation/freezed_annotation.dart';

part 'activities.freezed.dart';
part 'activities.g.dart';

@freezed
class Activities with _$Activities {
  factory Activities(
      {required String id,
      required num patient_id,
      required String created_at,
      required String activity_type,
      required int duration,
      required String intensity,
      required String notes}) = _Activities;

  factory Activities.fromJson(Map<String, dynamic> json) =>
      _$ActivitiesFromJson(json);
}
