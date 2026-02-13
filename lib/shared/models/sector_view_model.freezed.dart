// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sector_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SectorViewModel {

 Sector get sector; String get displayName; String get description;
/// Create a copy of SectorViewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<SectorViewModel> get copyWith => _$SectorViewModelCopyWithImpl<SectorViewModel>(this as SectorViewModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorViewModel&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,sector,displayName,description);

@override
String toString() {
  return 'SectorViewModel(sector: $sector, displayName: $displayName, description: $description)';
}


}

/// @nodoc
abstract mixin class $SectorViewModelCopyWith<$Res>  {
  factory $SectorViewModelCopyWith(SectorViewModel value, $Res Function(SectorViewModel) _then) = _$SectorViewModelCopyWithImpl;
@useResult
$Res call({
 Sector sector, String displayName, String description
});




}
/// @nodoc
class _$SectorViewModelCopyWithImpl<$Res>
    implements $SectorViewModelCopyWith<$Res> {
  _$SectorViewModelCopyWithImpl(this._self, this._then);

  final SectorViewModel _self;
  final $Res Function(SectorViewModel) _then;

/// Create a copy of SectorViewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sector = null,Object? displayName = null,Object? description = null,}) {
  return _then(_self.copyWith(
sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SectorViewModel].
extension SectorViewModelPatterns on SectorViewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectorViewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectorViewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectorViewModel value)  $default,){
final _that = this;
switch (_that) {
case _SectorViewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectorViewModel value)?  $default,){
final _that = this;
switch (_that) {
case _SectorViewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Sector sector,  String displayName,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectorViewModel() when $default != null:
return $default(_that.sector,_that.displayName,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Sector sector,  String displayName,  String description)  $default,) {final _that = this;
switch (_that) {
case _SectorViewModel():
return $default(_that.sector,_that.displayName,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Sector sector,  String displayName,  String description)?  $default,) {final _that = this;
switch (_that) {
case _SectorViewModel() when $default != null:
return $default(_that.sector,_that.displayName,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _SectorViewModel implements SectorViewModel {
  const _SectorViewModel({required this.sector, required this.displayName, required this.description});
  

@override final  Sector sector;
@override final  String displayName;
@override final  String description;

/// Create a copy of SectorViewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorViewModelCopyWith<_SectorViewModel> get copyWith => __$SectorViewModelCopyWithImpl<_SectorViewModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorViewModel&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,sector,displayName,description);

@override
String toString() {
  return 'SectorViewModel(sector: $sector, displayName: $displayName, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SectorViewModelCopyWith<$Res> implements $SectorViewModelCopyWith<$Res> {
  factory _$SectorViewModelCopyWith(_SectorViewModel value, $Res Function(_SectorViewModel) _then) = __$SectorViewModelCopyWithImpl;
@override @useResult
$Res call({
 Sector sector, String displayName, String description
});




}
/// @nodoc
class __$SectorViewModelCopyWithImpl<$Res>
    implements _$SectorViewModelCopyWith<$Res> {
  __$SectorViewModelCopyWithImpl(this._self, this._then);

  final _SectorViewModel _self;
  final $Res Function(_SectorViewModel) _then;

/// Create a copy of SectorViewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sector = null,Object? displayName = null,Object? description = null,}) {
  return _then(_SectorViewModel(
sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
