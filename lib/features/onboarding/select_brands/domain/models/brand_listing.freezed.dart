// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandListing {

 List<Brand> get globalBrands; List<Brand> get sectorBrands;
/// Create a copy of BrandListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandListingCopyWith<BrandListing> get copyWith => _$BrandListingCopyWithImpl<BrandListing>(this as BrandListing, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandListing&&const DeepCollectionEquality().equals(other.globalBrands, globalBrands)&&const DeepCollectionEquality().equals(other.sectorBrands, sectorBrands));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(globalBrands),const DeepCollectionEquality().hash(sectorBrands));

@override
String toString() {
  return 'BrandListing(globalBrands: $globalBrands, sectorBrands: $sectorBrands)';
}


}

/// @nodoc
abstract mixin class $BrandListingCopyWith<$Res>  {
  factory $BrandListingCopyWith(BrandListing value, $Res Function(BrandListing) _then) = _$BrandListingCopyWithImpl;
@useResult
$Res call({
 List<Brand> globalBrands, List<Brand> sectorBrands
});




}
/// @nodoc
class _$BrandListingCopyWithImpl<$Res>
    implements $BrandListingCopyWith<$Res> {
  _$BrandListingCopyWithImpl(this._self, this._then);

  final BrandListing _self;
  final $Res Function(BrandListing) _then;

/// Create a copy of BrandListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? globalBrands = null,Object? sectorBrands = null,}) {
  return _then(_self.copyWith(
globalBrands: null == globalBrands ? _self.globalBrands : globalBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,sectorBrands: null == sectorBrands ? _self.sectorBrands : sectorBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandListing].
extension BrandListingPatterns on BrandListing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandListing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandListing value)  $default,){
final _that = this;
switch (_that) {
case _BrandListing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandListing value)?  $default,){
final _that = this;
switch (_that) {
case _BrandListing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Brand> globalBrands,  List<Brand> sectorBrands)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandListing() when $default != null:
return $default(_that.globalBrands,_that.sectorBrands);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Brand> globalBrands,  List<Brand> sectorBrands)  $default,) {final _that = this;
switch (_that) {
case _BrandListing():
return $default(_that.globalBrands,_that.sectorBrands);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Brand> globalBrands,  List<Brand> sectorBrands)?  $default,) {final _that = this;
switch (_that) {
case _BrandListing() when $default != null:
return $default(_that.globalBrands,_that.sectorBrands);case _:
  return null;

}
}

}

/// @nodoc


class _BrandListing implements BrandListing {
  const _BrandListing({required final  List<Brand> globalBrands, required final  List<Brand> sectorBrands}): _globalBrands = globalBrands,_sectorBrands = sectorBrands;
  

 final  List<Brand> _globalBrands;
@override List<Brand> get globalBrands {
  if (_globalBrands is EqualUnmodifiableListView) return _globalBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_globalBrands);
}

 final  List<Brand> _sectorBrands;
@override List<Brand> get sectorBrands {
  if (_sectorBrands is EqualUnmodifiableListView) return _sectorBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectorBrands);
}


/// Create a copy of BrandListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandListingCopyWith<_BrandListing> get copyWith => __$BrandListingCopyWithImpl<_BrandListing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandListing&&const DeepCollectionEquality().equals(other._globalBrands, _globalBrands)&&const DeepCollectionEquality().equals(other._sectorBrands, _sectorBrands));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_globalBrands),const DeepCollectionEquality().hash(_sectorBrands));

@override
String toString() {
  return 'BrandListing(globalBrands: $globalBrands, sectorBrands: $sectorBrands)';
}


}

/// @nodoc
abstract mixin class _$BrandListingCopyWith<$Res> implements $BrandListingCopyWith<$Res> {
  factory _$BrandListingCopyWith(_BrandListing value, $Res Function(_BrandListing) _then) = __$BrandListingCopyWithImpl;
@override @useResult
$Res call({
 List<Brand> globalBrands, List<Brand> sectorBrands
});




}
/// @nodoc
class __$BrandListingCopyWithImpl<$Res>
    implements _$BrandListingCopyWith<$Res> {
  __$BrandListingCopyWithImpl(this._self, this._then);

  final _BrandListing _self;
  final $Res Function(_BrandListing) _then;

/// Create a copy of BrandListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? globalBrands = null,Object? sectorBrands = null,}) {
  return _then(_BrandListing(
globalBrands: null == globalBrands ? _self._globalBrands : globalBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,sectorBrands: null == sectorBrands ? _self._sectorBrands : sectorBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,
  ));
}


}

// dart format on
