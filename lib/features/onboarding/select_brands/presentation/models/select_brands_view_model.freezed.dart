// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_brands_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectBrandsViewModel {

 Brand get brand; bool get isSelected; bool get shouldAnimate;
/// Create a copy of SelectBrandsViewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectBrandsViewModelCopyWith<SelectBrandsViewModel> get copyWith => _$SelectBrandsViewModelCopyWithImpl<SelectBrandsViewModel>(this as SelectBrandsViewModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectBrandsViewModel&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.shouldAnimate, shouldAnimate) || other.shouldAnimate == shouldAnimate));
}


@override
int get hashCode => Object.hash(runtimeType,brand,isSelected,shouldAnimate);

@override
String toString() {
  return 'SelectBrandsViewModel(brand: $brand, isSelected: $isSelected, shouldAnimate: $shouldAnimate)';
}


}

/// @nodoc
abstract mixin class $SelectBrandsViewModelCopyWith<$Res>  {
  factory $SelectBrandsViewModelCopyWith(SelectBrandsViewModel value, $Res Function(SelectBrandsViewModel) _then) = _$SelectBrandsViewModelCopyWithImpl;
@useResult
$Res call({
 Brand brand, bool isSelected, bool shouldAnimate
});


$BrandCopyWith<$Res> get brand;

}
/// @nodoc
class _$SelectBrandsViewModelCopyWithImpl<$Res>
    implements $SelectBrandsViewModelCopyWith<$Res> {
  _$SelectBrandsViewModelCopyWithImpl(this._self, this._then);

  final SelectBrandsViewModel _self;
  final $Res Function(SelectBrandsViewModel) _then;

/// Create a copy of SelectBrandsViewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? brand = null,Object? isSelected = null,Object? shouldAnimate = null,}) {
  return _then(_self.copyWith(
brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,shouldAnimate: null == shouldAnimate ? _self.shouldAnimate : shouldAnimate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SelectBrandsViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrandCopyWith<$Res> get brand {
  
  return $BrandCopyWith<$Res>(_self.brand, (value) {
    return _then(_self.copyWith(brand: value));
  });
}
}


/// Adds pattern-matching-related methods to [SelectBrandsViewModel].
extension SelectBrandsViewModelPatterns on SelectBrandsViewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectBrandsViewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectBrandsViewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectBrandsViewModel value)  $default,){
final _that = this;
switch (_that) {
case _SelectBrandsViewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectBrandsViewModel value)?  $default,){
final _that = this;
switch (_that) {
case _SelectBrandsViewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Brand brand,  bool isSelected,  bool shouldAnimate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectBrandsViewModel() when $default != null:
return $default(_that.brand,_that.isSelected,_that.shouldAnimate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Brand brand,  bool isSelected,  bool shouldAnimate)  $default,) {final _that = this;
switch (_that) {
case _SelectBrandsViewModel():
return $default(_that.brand,_that.isSelected,_that.shouldAnimate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Brand brand,  bool isSelected,  bool shouldAnimate)?  $default,) {final _that = this;
switch (_that) {
case _SelectBrandsViewModel() when $default != null:
return $default(_that.brand,_that.isSelected,_that.shouldAnimate);case _:
  return null;

}
}

}

/// @nodoc


class _SelectBrandsViewModel implements SelectBrandsViewModel {
  const _SelectBrandsViewModel({required this.brand, this.isSelected = false, this.shouldAnimate = false});
  

@override final  Brand brand;
@override@JsonKey() final  bool isSelected;
@override@JsonKey() final  bool shouldAnimate;

/// Create a copy of SelectBrandsViewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectBrandsViewModelCopyWith<_SelectBrandsViewModel> get copyWith => __$SelectBrandsViewModelCopyWithImpl<_SelectBrandsViewModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectBrandsViewModel&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.shouldAnimate, shouldAnimate) || other.shouldAnimate == shouldAnimate));
}


@override
int get hashCode => Object.hash(runtimeType,brand,isSelected,shouldAnimate);

@override
String toString() {
  return 'SelectBrandsViewModel(brand: $brand, isSelected: $isSelected, shouldAnimate: $shouldAnimate)';
}


}

/// @nodoc
abstract mixin class _$SelectBrandsViewModelCopyWith<$Res> implements $SelectBrandsViewModelCopyWith<$Res> {
  factory _$SelectBrandsViewModelCopyWith(_SelectBrandsViewModel value, $Res Function(_SelectBrandsViewModel) _then) = __$SelectBrandsViewModelCopyWithImpl;
@override @useResult
$Res call({
 Brand brand, bool isSelected, bool shouldAnimate
});


@override $BrandCopyWith<$Res> get brand;

}
/// @nodoc
class __$SelectBrandsViewModelCopyWithImpl<$Res>
    implements _$SelectBrandsViewModelCopyWith<$Res> {
  __$SelectBrandsViewModelCopyWithImpl(this._self, this._then);

  final _SelectBrandsViewModel _self;
  final $Res Function(_SelectBrandsViewModel) _then;

/// Create a copy of SelectBrandsViewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? brand = null,Object? isSelected = null,Object? shouldAnimate = null,}) {
  return _then(_SelectBrandsViewModel(
brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,shouldAnimate: null == shouldAnimate ? _self.shouldAnimate : shouldAnimate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SelectBrandsViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrandCopyWith<$Res> get brand {
  
  return $BrandCopyWith<$Res>(_self.brand, (value) {
    return _then(_self.copyWith(brand: value));
  });
}
}

// dart format on
