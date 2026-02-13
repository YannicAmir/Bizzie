// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_display_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileDisplayData {

 String get displayName; String get sectorName; String get sectorDescription; DateTime get joinedDate; double? get sectorPe; double? get sectorAverageChange; DateTime? get marketDataDate;
/// Create a copy of ProfileDisplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDisplayDataCopyWith<ProfileDisplayData> get copyWith => _$ProfileDisplayDataCopyWithImpl<ProfileDisplayData>(this as ProfileDisplayData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileDisplayData&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.sectorName, sectorName) || other.sectorName == sectorName)&&(identical(other.sectorDescription, sectorDescription) || other.sectorDescription == sectorDescription)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.sectorPe, sectorPe) || other.sectorPe == sectorPe)&&(identical(other.sectorAverageChange, sectorAverageChange) || other.sectorAverageChange == sectorAverageChange)&&(identical(other.marketDataDate, marketDataDate) || other.marketDataDate == marketDataDate));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,sectorName,sectorDescription,joinedDate,sectorPe,sectorAverageChange,marketDataDate);

@override
String toString() {
  return 'ProfileDisplayData(displayName: $displayName, sectorName: $sectorName, sectorDescription: $sectorDescription, joinedDate: $joinedDate, sectorPe: $sectorPe, sectorAverageChange: $sectorAverageChange, marketDataDate: $marketDataDate)';
}


}

/// @nodoc
abstract mixin class $ProfileDisplayDataCopyWith<$Res>  {
  factory $ProfileDisplayDataCopyWith(ProfileDisplayData value, $Res Function(ProfileDisplayData) _then) = _$ProfileDisplayDataCopyWithImpl;
@useResult
$Res call({
 String displayName, String sectorName, String sectorDescription, DateTime joinedDate, double? sectorPe, double? sectorAverageChange, DateTime? marketDataDate
});




}
/// @nodoc
class _$ProfileDisplayDataCopyWithImpl<$Res>
    implements $ProfileDisplayDataCopyWith<$Res> {
  _$ProfileDisplayDataCopyWithImpl(this._self, this._then);

  final ProfileDisplayData _self;
  final $Res Function(ProfileDisplayData) _then;

/// Create a copy of ProfileDisplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? sectorName = null,Object? sectorDescription = null,Object? joinedDate = null,Object? sectorPe = freezed,Object? sectorAverageChange = freezed,Object? marketDataDate = freezed,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,sectorName: null == sectorName ? _self.sectorName : sectorName // ignore: cast_nullable_to_non_nullable
as String,sectorDescription: null == sectorDescription ? _self.sectorDescription : sectorDescription // ignore: cast_nullable_to_non_nullable
as String,joinedDate: null == joinedDate ? _self.joinedDate : joinedDate // ignore: cast_nullable_to_non_nullable
as DateTime,sectorPe: freezed == sectorPe ? _self.sectorPe : sectorPe // ignore: cast_nullable_to_non_nullable
as double?,sectorAverageChange: freezed == sectorAverageChange ? _self.sectorAverageChange : sectorAverageChange // ignore: cast_nullable_to_non_nullable
as double?,marketDataDate: freezed == marketDataDate ? _self.marketDataDate : marketDataDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileDisplayData].
extension ProfileDisplayDataPatterns on ProfileDisplayData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileDisplayData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileDisplayData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileDisplayData value)  $default,){
final _that = this;
switch (_that) {
case _ProfileDisplayData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileDisplayData value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileDisplayData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String sectorName,  String sectorDescription,  DateTime joinedDate,  double? sectorPe,  double? sectorAverageChange,  DateTime? marketDataDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileDisplayData() when $default != null:
return $default(_that.displayName,_that.sectorName,_that.sectorDescription,_that.joinedDate,_that.sectorPe,_that.sectorAverageChange,_that.marketDataDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String sectorName,  String sectorDescription,  DateTime joinedDate,  double? sectorPe,  double? sectorAverageChange,  DateTime? marketDataDate)  $default,) {final _that = this;
switch (_that) {
case _ProfileDisplayData():
return $default(_that.displayName,_that.sectorName,_that.sectorDescription,_that.joinedDate,_that.sectorPe,_that.sectorAverageChange,_that.marketDataDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String sectorName,  String sectorDescription,  DateTime joinedDate,  double? sectorPe,  double? sectorAverageChange,  DateTime? marketDataDate)?  $default,) {final _that = this;
switch (_that) {
case _ProfileDisplayData() when $default != null:
return $default(_that.displayName,_that.sectorName,_that.sectorDescription,_that.joinedDate,_that.sectorPe,_that.sectorAverageChange,_that.marketDataDate);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileDisplayData implements ProfileDisplayData {
  const _ProfileDisplayData({required this.displayName, required this.sectorName, required this.sectorDescription, required this.joinedDate, required this.sectorPe, required this.sectorAverageChange, required this.marketDataDate});
  

@override final  String displayName;
@override final  String sectorName;
@override final  String sectorDescription;
@override final  DateTime joinedDate;
@override final  double? sectorPe;
@override final  double? sectorAverageChange;
@override final  DateTime? marketDataDate;

/// Create a copy of ProfileDisplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDisplayDataCopyWith<_ProfileDisplayData> get copyWith => __$ProfileDisplayDataCopyWithImpl<_ProfileDisplayData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileDisplayData&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.sectorName, sectorName) || other.sectorName == sectorName)&&(identical(other.sectorDescription, sectorDescription) || other.sectorDescription == sectorDescription)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.sectorPe, sectorPe) || other.sectorPe == sectorPe)&&(identical(other.sectorAverageChange, sectorAverageChange) || other.sectorAverageChange == sectorAverageChange)&&(identical(other.marketDataDate, marketDataDate) || other.marketDataDate == marketDataDate));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,sectorName,sectorDescription,joinedDate,sectorPe,sectorAverageChange,marketDataDate);

@override
String toString() {
  return 'ProfileDisplayData(displayName: $displayName, sectorName: $sectorName, sectorDescription: $sectorDescription, joinedDate: $joinedDate, sectorPe: $sectorPe, sectorAverageChange: $sectorAverageChange, marketDataDate: $marketDataDate)';
}


}

/// @nodoc
abstract mixin class _$ProfileDisplayDataCopyWith<$Res> implements $ProfileDisplayDataCopyWith<$Res> {
  factory _$ProfileDisplayDataCopyWith(_ProfileDisplayData value, $Res Function(_ProfileDisplayData) _then) = __$ProfileDisplayDataCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String sectorName, String sectorDescription, DateTime joinedDate, double? sectorPe, double? sectorAverageChange, DateTime? marketDataDate
});




}
/// @nodoc
class __$ProfileDisplayDataCopyWithImpl<$Res>
    implements _$ProfileDisplayDataCopyWith<$Res> {
  __$ProfileDisplayDataCopyWithImpl(this._self, this._then);

  final _ProfileDisplayData _self;
  final $Res Function(_ProfileDisplayData) _then;

/// Create a copy of ProfileDisplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? sectorName = null,Object? sectorDescription = null,Object? joinedDate = null,Object? sectorPe = freezed,Object? sectorAverageChange = freezed,Object? marketDataDate = freezed,}) {
  return _then(_ProfileDisplayData(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,sectorName: null == sectorName ? _self.sectorName : sectorName // ignore: cast_nullable_to_non_nullable
as String,sectorDescription: null == sectorDescription ? _self.sectorDescription : sectorDescription // ignore: cast_nullable_to_non_nullable
as String,joinedDate: null == joinedDate ? _self.joinedDate : joinedDate // ignore: cast_nullable_to_non_nullable
as DateTime,sectorPe: freezed == sectorPe ? _self.sectorPe : sectorPe // ignore: cast_nullable_to_non_nullable
as double?,sectorAverageChange: freezed == sectorAverageChange ? _self.sectorAverageChange : sectorAverageChange // ignore: cast_nullable_to_non_nullable
as double?,marketDataDate: freezed == marketDataDate ? _self.marketDataDate : marketDataDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
