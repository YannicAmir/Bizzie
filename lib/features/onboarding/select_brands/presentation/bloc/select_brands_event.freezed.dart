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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( Updated value)?  updated,TResult Function( Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Updated() when updated != null:
return updated(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( Updated value)  updated,required TResult Function( Reset value)  reset,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case Updated():
return updated(_that);case Reset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( Updated value)?  updated,TResult? Function( Reset value)?  reset,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Updated() when updated != null:
return updated(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Sector? sector,  String sectorName,  List<Brand> selectedBrands)?  started,TResult Function( List<Brand> selectedBrands)?  updated,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that.sector,_that.sectorName,_that.selectedBrands);case Updated() when updated != null:
return updated(_that.selectedBrands);case Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Sector? sector,  String sectorName,  List<Brand> selectedBrands)  started,required TResult Function( List<Brand> selectedBrands)  updated,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case Started():
return started(_that.sector,_that.sectorName,_that.selectedBrands);case Updated():
return updated(_that.selectedBrands);case Reset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Sector? sector,  String sectorName,  List<Brand> selectedBrands)?  started,TResult? Function( List<Brand> selectedBrands)?  updated,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that.sector,_that.sectorName,_that.selectedBrands);case Updated() when updated != null:
return updated(_that.selectedBrands);case Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class Started implements SelectBrandsEvent {
  const Started({this.sector, required this.sectorName, required final  List<Brand> selectedBrands}): _selectedBrands = selectedBrands;
  

 final  Sector? sector;
 final  String sectorName;
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
$StartedCopyWith<Started> get copyWith => _$StartedCopyWithImpl<Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.sectorName, sectorName) || other.sectorName == sectorName)&&const DeepCollectionEquality().equals(other._selectedBrands, _selectedBrands));
}


@override
int get hashCode => Object.hash(runtimeType,sector,sectorName,const DeepCollectionEquality().hash(_selectedBrands));

@override
String toString() {
  return 'SelectBrandsEvent.started(sector: $sector, sectorName: $sectorName, selectedBrands: $selectedBrands)';
}


}

/// @nodoc
abstract mixin class $StartedCopyWith<$Res> implements $SelectBrandsEventCopyWith<$Res> {
  factory $StartedCopyWith(Started value, $Res Function(Started) _then) = _$StartedCopyWithImpl;
@useResult
$Res call({
 Sector? sector, String sectorName, List<Brand> selectedBrands
});




}
/// @nodoc
class _$StartedCopyWithImpl<$Res>
    implements $StartedCopyWith<$Res> {
  _$StartedCopyWithImpl(this._self, this._then);

  final Started _self;
  final $Res Function(Started) _then;

/// Create a copy of SelectBrandsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sector = freezed,Object? sectorName = null,Object? selectedBrands = null,}) {
  return _then(Started(
sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector?,sectorName: null == sectorName ? _self.sectorName : sectorName // ignore: cast_nullable_to_non_nullable
as String,selectedBrands: null == selectedBrands ? _self._selectedBrands : selectedBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,
  ));
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


class Reset implements SelectBrandsEvent {
  const Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectBrandsEvent.reset()';
}


}




// dart format on
