// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) {
  return _FoodItem.fromJson(json);
}

/// @nodoc
mixin _$FoodItem {
  int get foodId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get calories => throw _privateConstructorUsedError;
  String? get servingSize => throw _privateConstructorUsedError;
  String? get servingUnit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodItemCopyWith<FoodItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodItemCopyWith<$Res> {
  factory $FoodItemCopyWith(FoodItem value, $Res Function(FoodItem) then) =
      _$FoodItemCopyWithImpl<$Res, FoodItem>;
  @useResult
  $Res call(
      {int foodId,
      String name,
      int calories,
      String? servingSize,
      String? servingUnit});
}

/// @nodoc
class _$FoodItemCopyWithImpl<$Res, $Val extends FoodItem>
    implements $FoodItemCopyWith<$Res> {
  _$FoodItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? name = null,
    Object? calories = null,
    Object? servingSize = freezed,
    Object? servingUnit = freezed,
  }) {
    return _then(_value.copyWith(
      foodId: null == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      servingSize: freezed == servingSize
          ? _value.servingSize
          : servingSize // ignore: cast_nullable_to_non_nullable
              as String?,
      servingUnit: freezed == servingUnit
          ? _value.servingUnit
          : servingUnit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FoodItemCopyWith<$Res> implements $FoodItemCopyWith<$Res> {
  factory _$$_FoodItemCopyWith(
          _$_FoodItem value, $Res Function(_$_FoodItem) then) =
      __$$_FoodItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int foodId,
      String name,
      int calories,
      String? servingSize,
      String? servingUnit});
}

/// @nodoc
class __$$_FoodItemCopyWithImpl<$Res>
    extends _$FoodItemCopyWithImpl<$Res, _$_FoodItem>
    implements _$$_FoodItemCopyWith<$Res> {
  __$$_FoodItemCopyWithImpl(
      _$_FoodItem _value, $Res Function(_$_FoodItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? name = null,
    Object? calories = null,
    Object? servingSize = freezed,
    Object? servingUnit = freezed,
  }) {
    return _then(_$_FoodItem(
      foodId: null == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      servingSize: freezed == servingSize
          ? _value.servingSize
          : servingSize // ignore: cast_nullable_to_non_nullable
              as String?,
      servingUnit: freezed == servingUnit
          ? _value.servingUnit
          : servingUnit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FoodItem with DiagnosticableTreeMixin implements _FoodItem {
  _$_FoodItem(
      {required this.foodId,
      required this.name,
      required this.calories,
      this.servingSize,
      this.servingUnit});

  factory _$_FoodItem.fromJson(Map<String, dynamic> json) =>
      _$$_FoodItemFromJson(json);

  @override
  final int foodId;
  @override
  final String name;
  @override
  final int calories;
  @override
  final String? servingSize;
  @override
  final String? servingUnit;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodItem(foodId: $foodId, name: $name, calories: $calories, servingSize: $servingSize, servingUnit: $servingUnit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodItem'))
      ..add(DiagnosticsProperty('foodId', foodId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('calories', calories))
      ..add(DiagnosticsProperty('servingSize', servingSize))
      ..add(DiagnosticsProperty('servingUnit', servingUnit));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FoodItem &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.servingSize, servingSize) ||
                other.servingSize == servingSize) &&
            (identical(other.servingUnit, servingUnit) ||
                other.servingUnit == servingUnit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, foodId, name, calories, servingSize, servingUnit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FoodItemCopyWith<_$_FoodItem> get copyWith =>
      __$$_FoodItemCopyWithImpl<_$_FoodItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FoodItemToJson(
      this,
    );
  }
}

abstract class _FoodItem implements FoodItem {
  factory _FoodItem(
      {required final int foodId,
      required final String name,
      required final int calories,
      final String? servingSize,
      final String? servingUnit}) = _$_FoodItem;

  factory _FoodItem.fromJson(Map<String, dynamic> json) = _$_FoodItem.fromJson;

  @override
  int get foodId;
  @override
  String get name;
  @override
  int get calories;
  @override
  String? get servingSize;
  @override
  String? get servingUnit;
  @override
  @JsonKey(ignore: true)
  _$$_FoodItemCopyWith<_$_FoodItem> get copyWith =>
      throw _privateConstructorUsedError;
}
