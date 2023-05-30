// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Activities _$$_ActivitiesFromJson(Map<String, dynamic> json) =>
    _$_Activities(
      id: json['id'] as String,
      patient_id: json['patient_id'] as num,
      created_at: json['created_at'] as String,
      activity_type: json['activity_type'] as String,
      duration: json['duration'] as int,
      intensity: json['intensity'] as String,
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$$_ActivitiesToJson(_$_Activities instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patient_id,
      'created_at': instance.created_at,
      'activity_type': instance.activity_type,
      'duration': instance.duration,
      'intensity': instance.intensity,
      'notes': instance.notes,
    };
