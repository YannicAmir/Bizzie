// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_brands_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectBrandsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectBrandsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectBrandsEvent()';
}


}

/// @nodoc
class $SelectBrandsEventCopyWith<$Res>  {
$SelectBrandsEventCopyWith(SelectBrandsEvent _, $Res Function(SelectBrandsEvent) __);
}


/// Adds pattern-matching-related methods to [SelectBrandsEvent].
extension SelectBrandsEventPatterns on SelectBrandsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( Updated value)?  updated,TResult Function( ToggleBrand value)?  toggleBrand,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Updated() when updated != null:
return updated(_that);case ToggleBrand() when toggleBrand != null:
return toggleBrand(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( Updated value)  updated,required TResult Function( ToggleBrand value)  toggleBrand,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case Updated():
return updated(_that);case ToggleBrand():
return toggleBrand(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( Updated value)?  updated,TResult? Function( ToggleBrand value)?  toggleBrand,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Updated() when updated != null:
return updated(_that);case ToggleBrand() when toggleBrand != null:
return toggleBrand(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( List<Brand> selectedBrands)?  updated,TResult Function( Brand brand)?  toggleBrand,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case Updated() when updated != null:
return updated(_that.selectedBrands);case ToggleBrand() when toggleBrand != null:
return toggleBrand(_that.brand);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( List<Brand> selectedBrands)  updated,required TResult Function( Brand brand)  toggleBrand,}) {final _that = this;
switch (_that) {
case Started():
return started();case Updated():
return updated(_that.selectedBrands);case ToggleBrand():
return toggleBrand(_that.brand);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( List<Brand> selectedBrands)?  updated,TResult? Function( Brand brand)?  toggleBrand,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case Updated() when updated != null:
return updated(_that.selectedBrands);case ToggleBrand() when toggleBrand != null:
return toggleBrand(_that.brand);case _:
  return null;

}
}

}

/// @nodoc


class Started implements SelectBrandsEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectBrandsEvent.started()';
}


}




/// @nodoc


class Updated implements SelectBrandsEvent {
  const Updated({required final  List<Brand> selectedBrands}): _selectedBrands = selectedBrands;
  

 final  List<Brand> _selectedBrands;
 List<Brand> get selectedBrands {
  if (_selectedBrands is EqualUnmodifiableListView) return _selectedBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedBrands);
}


/// Create a copy of SelectBrandsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdatedCopyWith<Updated> get copyWith => _$UpdatedCopyWithImpl<Updated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Updated&&const DeepCollectionEquality().equals(other._selectedBrands, _selectedBrands));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedBrands));

@override
String toString() {
  return 'SelectBrandsEvent.updated(selectedBrands: $selectedBrands)';
}


}

/// @nodoc
abstract mixin class $UpdatedCopyWith<$Res> implements $SelectBrandsEventCopyWith<$Res> {
  factory $UpdatedCopyWith(Updated value, $Res Function(Updated) _then) = _$UpdatedCopyWithImpl;
@useResult
$Res call({
 List<Brand> selectedBrands
});




}
/// @nodoc
class _$UpdatedCopyWithImpl<$Res>
    implements $UpdatedCopyWith<$Res> {
  _$UpdatedCopyWithImpl(this._self, this._then);

  final Updated _self;
  final $Res Function(Updated) _then;

/// Create a copy of SelectBrandsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedBrands = null,}) {
  return _then(Updated(
selectedBrands: null == selectedBrands ? _self._selectedBrands : selectedBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,
  ));
}


}

/// @nodoc


class ToggleBrand implements SelectBrandsEvent {
  const ToggleBrand(this.brand);
  

 final  Brand brand;

/// Create a copy of SelectBrandsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleBrandCopyWith<ToggleBrand> get copyWith => _$ToggleBrandCopyWithImpl<ToggleBrand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleBrand&&(identical(other.brand, brand) || other.brand == brand));
}


@override
int get hashCode => Object.hash(runtimeType,brand);

@override
String toString() {
  return 'SelectBrandsEvent.toggleBrand(brand: $brand)';
}


}

/// @nodoc
abstract mixin class $ToggleBrandCopyWith<$Res> implements $SelectBrandsEventCopyWith<$Res> {
  factory $ToggleBrandCopyWith(ToggleBrand value, $Res Function(ToggleBrand) _then) = _$ToggleBrandCopyWithImpl;
@useResult
$Res call({
 Brand brand
});


$BrandCopyWith<$Res> get brand;

}
/// @nodoc
class _$ToggleBrandCopyWithImpl<$Res>
    implements $ToggleBrandCopyWith<$Res> {
  _$ToggleBrandCopyWithImpl(this._self, this._then);

  final ToggleBrand _self;
  final $Res Function(ToggleBrand) _then;

/// Create a copy of SelectBrandsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brand = null,}) {
  return _then(ToggleBrand(
null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand,
  ));
}

/// Create a copy of SelectBrandsEvent
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
