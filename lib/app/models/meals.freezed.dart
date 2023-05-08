// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Meal _$MealFromJson(Map<String, dynamic> json) {
  return _Meal.fromJson(json);
}

/// @nodoc
mixin _$Meal {
  int get mealId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  DateTime get mealDate => throw _privateConstructorUsedError;
  DateTime get mealTime => throw _privateConstructorUsedError;
  List<FoodItem> get foodItems => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MealCopyWith<Meal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealCopyWith<$Res> {
  factory $MealCopyWith(Meal value, $Res Function(Meal) then) =
      _$MealCopyWithImpl<$Res, Meal>;
  @useResult
  $Res call(
      {int mealId,
      int userId,
      MealType mealType,
      DateTime mealDate,
      DateTime mealTime,
      List<FoodItem> foodItems,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$MealCopyWithImpl<$Res, $Val extends Meal>
    implements $MealCopyWith<$Res> {
  _$MealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? userId = null,
    Object? mealType = null,
    Object? mealDate = null,
    Object? mealTime = null,
    Object? foodItems = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      mealDate: null == mealDate
          ? _value.mealDate
          : mealDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealTime: null == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      foodItems: null == foodItems
          ? _value.foodItems
          : foodItems // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MealCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$$_MealCopyWith(_$_Meal value, $Res Function(_$_Meal) then) =
      __$$_MealCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int mealId,
      int userId,
      MealType mealType,
      DateTime mealDate,
      DateTime mealTime,
      List<FoodItem> foodItems,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$_MealCopyWithImpl<$Res> extends _$MealCopyWithImpl<$Res, _$_Meal>
    implements _$$_MealCopyWith<$Res> {
  __$$_MealCopyWithImpl(_$_Meal _value, $Res Function(_$_Meal) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? userId = null,
    Object? mealType = null,
    Object? mealDate = null,
    Object? mealTime = null,
    Object? foodItems = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_Meal(
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      mealDate: null == mealDate
          ? _value.mealDate
          : mealDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealTime: null == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      foodItems: null == foodItems
          ? _value._foodItems
          : foodItems // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Meal with DiagnosticableTreeMixin implements _Meal {
  _$_Meal(
      {required this.mealId,
      required this.userId,
      required this.mealType,
      required this.mealDate,
      required this.mealTime,
      required final List<FoodItem> foodItems,
      required this.createdAt,
      required this.updatedAt})
      : _foodItems = foodItems;

  factory _$_Meal.fromJson(Map<String, dynamic> json) => _$$_MealFromJson(json);

  @override
  final int mealId;
  @override
  final int userId;
  @override
  final MealType mealType;
  @override
  final DateTime mealDate;
  @override
  final DateTime mealTime;
  final List<FoodItem> _foodItems;
  @override
  List<FoodItem> get foodItems {
    if (_foodItems is EqualUnmodifiableListView) return _foodItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodItems);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Meal(mealId: $mealId, userId: $userId, mealType: $mealType, mealDate: $mealDate, mealTime: $mealTime, foodItems: $foodItems, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Meal'))
      ..add(DiagnosticsProperty('mealId', mealId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('mealType', mealType))
      ..add(DiagnosticsProperty('mealDate', mealDate))
      ..add(DiagnosticsProperty('mealTime', mealTime))
      ..add(DiagnosticsProperty('foodItems', foodItems))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Meal &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.mealDate, mealDate) ||
                other.mealDate == mealDate) &&
            (identical(other.mealTime, mealTime) ||
                other.mealTime == mealTime) &&
            const DeepCollectionEquality()
                .equals(other._foodItems, _foodItems) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mealId,
      userId,
      mealType,
      mealDate,
      mealTime,
      const DeepCollectionEquality().hash(_foodItems),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MealCopyWith<_$_Meal> get copyWith =>
      __$$_MealCopyWithImpl<_$_Meal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MealToJson(
      this,
    );
  }
}

abstract class _Meal implements Meal {
  factory _Meal(
      {required final int mealId,
      required final int userId,
      required final MealType mealType,
      required final DateTime mealDate,
      required final DateTime mealTime,
      required final List<FoodItem> foodItems,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$_Meal;

  factory _Meal.fromJson(Map<String, dynamic> json) = _$_Meal.fromJson;

  @override
  int get mealId;
  @override
  int get userId;
  @override
  MealType get mealType;
  @override
  DateTime get mealDate;
  @override
  DateTime get mealTime;
  @override
  List<FoodItem> get foodItems;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_MealCopyWith<_$_Meal> get copyWith => throw _privateConstructorUsedError;
}
