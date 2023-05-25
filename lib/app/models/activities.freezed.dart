// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Activities _$ActivitiesFromJson(Map<String, dynamic> json) {
  return _Activities.fromJson(json);
}

/// @nodoc
mixin _$Activities {
  String get id => throw _privateConstructorUsedError;
  num get patient_id => throw _privateConstructorUsedError;
  String get created_at => throw _privateConstructorUsedError;
  String get activity_type => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  String get intensity => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivitiesCopyWith<Activities> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivitiesCopyWith<$Res> {
  factory $ActivitiesCopyWith(
          Activities value, $Res Function(Activities) then) =
      _$ActivitiesCopyWithImpl<$Res, Activities>;
  @useResult
  $Res call(
      {String id,
      num patient_id,
      String created_at,
      String activity_type,
      int duration,
      String intensity,
      String notes});
}

/// @nodoc
class _$ActivitiesCopyWithImpl<$Res, $Val extends Activities>
    implements $ActivitiesCopyWith<$Res> {
  _$ActivitiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patient_id = null,
    Object? created_at = null,
    Object? activity_type = null,
    Object? duration = null,
    Object? intensity = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      patient_id: null == patient_id
          ? _value.patient_id
          : patient_id // ignore: cast_nullable_to_non_nullable
              as num,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String,
      activity_type: null == activity_type
          ? _value.activity_type
          : activity_type // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivitiesCopyWith<$Res>
    implements $ActivitiesCopyWith<$Res> {
  factory _$$_ActivitiesCopyWith(
          _$_Activities value, $Res Function(_$_Activities) then) =
      __$$_ActivitiesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      num patient_id,
      String created_at,
      String activity_type,
      int duration,
      String intensity,
      String notes});
}

/// @nodoc
class __$$_ActivitiesCopyWithImpl<$Res>
    extends _$ActivitiesCopyWithImpl<$Res, _$_Activities>
    implements _$$_ActivitiesCopyWith<$Res> {
  __$$_ActivitiesCopyWithImpl(
      _$_Activities _value, $Res Function(_$_Activities) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patient_id = null,
    Object? created_at = null,
    Object? activity_type = null,
    Object? duration = null,
    Object? intensity = null,
    Object? notes = null,
  }) {
    return _then(_$_Activities(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      patient_id: null == patient_id
          ? _value.patient_id
          : patient_id // ignore: cast_nullable_to_non_nullable
              as num,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String,
      activity_type: null == activity_type
          ? _value.activity_type
          : activity_type // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Activities implements _Activities {
  _$_Activities(
      {required this.id,
      required this.patient_id,
      required this.created_at,
      required this.activity_type,
      required this.duration,
      required this.intensity,
      required this.notes});

  factory _$_Activities.fromJson(Map<String, dynamic> json) =>
      _$$_ActivitiesFromJson(json);

  @override
  final String id;
  @override
  final num patient_id;
  @override
  final String created_at;
  @override
  final String activity_type;
  @override
  final int duration;
  @override
  final String intensity;
  @override
  final String notes;

  @override
  String toString() {
    return 'Activities(id: $id, patient_id: $patient_id, created_at: $created_at, activity_type: $activity_type, duration: $duration, intensity: $intensity, notes: $notes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Activities &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patient_id, patient_id) ||
                other.patient_id == patient_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.activity_type, activity_type) ||
                other.activity_type == activity_type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, patient_id, created_at,
      activity_type, duration, intensity, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivitiesCopyWith<_$_Activities> get copyWith =>
      __$$_ActivitiesCopyWithImpl<_$_Activities>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ActivitiesToJson(
      this,
    );
  }
}

abstract class _Activities implements Activities {
  factory _Activities(
      {required final String id,
      required final num patient_id,
      required final String created_at,
      required final String activity_type,
      required final int duration,
      required final String intensity,
      required final String notes}) = _$_Activities;

  factory _Activities.fromJson(Map<String, dynamic> json) =
      _$_Activities.fromJson;

  @override
  String get id;
  @override
  num get patient_id;
  @override
  String get created_at;
  @override
  String get activity_type;
  @override
  int get duration;
  @override
  String get intensity;
  @override
  String get notes;
  @override
  @JsonKey(ignore: true)
  _$$_ActivitiesCopyWith<_$_Activities> get copyWith =>
      throw _privateConstructorUsedError;
}
