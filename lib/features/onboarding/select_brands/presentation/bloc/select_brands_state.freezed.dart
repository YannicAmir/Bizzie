// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_brands_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectBrandsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectBrandsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectBrandsState()';
}


}

/// @nodoc
class $SelectBrandsStateCopyWith<$Res>  {
$SelectBrandsStateCopyWith(SelectBrandsState _, $Res Function(SelectBrandsState) __);
}


/// Adds pattern-matching-related methods to [SelectBrandsState].
extension SelectBrandsStatePatterns on SelectBrandsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Error value)?  error,TResult Function( _Loaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Error() when error != null:
return error(_that);case _Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Error value)  error,required TResult Function( _Loaded value)  loaded,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Error():
return error(_that);case _Loaded():
return loaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Error value)?  error,TResult? Function( _Loaded value)?  loaded,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Error() when error != null:
return error(_that);case _Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String message)?  error,TResult Function( List<SelectBrandsViewModel> sectorBrands,  List<SelectBrandsViewModel> globalBrands,  List<SelectBrandsViewModel> selectedBrands,  String sectorName)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Error() when error != null:
return error(_that.message);case _Loaded() when loaded != null:
return loaded(_that.sectorBrands,_that.globalBrands,_that.selectedBrands,_that.sectorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String message)  error,required TResult Function( List<SelectBrandsViewModel> sectorBrands,  List<SelectBrandsViewModel> globalBrands,  List<SelectBrandsViewModel> selectedBrands,  String sectorName)  loaded,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Error():
return error(_that.message);case _Loaded():
return loaded(_that.sectorBrands,_that.globalBrands,_that.selectedBrands,_that.sectorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String message)?  error,TResult? Function( List<SelectBrandsViewModel> sectorBrands,  List<SelectBrandsViewModel> globalBrands,  List<SelectBrandsViewModel> selectedBrands,  String sectorName)?  loaded,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Error() when error != null:
return error(_that.message);case _Loaded() when loaded != null:
return loaded(_that.sectorBrands,_that.globalBrands,_that.selectedBrands,_that.sectorName);case _:
  return null;

}
}

}

/// @nodoc


class _Initial extends SelectBrandsState {
  const _Initial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectBrandsState.initial()';
}


}




/// @nodoc


class _Error extends SelectBrandsState {
  const _Error(this.message): super._();
  

 final  String message;

/// Create a copy of SelectBrandsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SelectBrandsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SelectBrandsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of SelectBrandsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Loaded extends SelectBrandsState {
  const _Loaded({required final  List<SelectBrandsViewModel> sectorBrands, required final  List<SelectBrandsViewModel> globalBrands, required final  List<SelectBrandsViewModel> selectedBrands, required this.sectorName}): _sectorBrands = sectorBrands,_globalBrands = globalBrands,_selectedBrands = selectedBrands,super._();
  

 final  List<SelectBrandsViewModel> _sectorBrands;
 List<SelectBrandsViewModel> get sectorBrands {
  if (_sectorBrands is EqualUnmodifiableListView) return _sectorBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectorBrands);
}

 final  List<SelectBrandsViewModel> _globalBrands;
 List<SelectBrandsViewModel> get globalBrands {
  if (_globalBrands is EqualUnmodifiableListView) return _globalBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_globalBrands);
}

 final  List<SelectBrandsViewModel> _selectedBrands;
 List<SelectBrandsViewModel> get selectedBrands {
  if (_selectedBrands is EqualUnmodifiableListView) return _selectedBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedBrands);
}

 final  String sectorName;

/// Create a copy of SelectBrandsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._sectorBrands, _sectorBrands)&&const DeepCollectionEquality().equals(other._globalBrands, _globalBrands)&&const DeepCollectionEquality().equals(other._selectedBrands, _selectedBrands)&&(identical(other.sectorName, sectorName) || other.sectorName == sectorName));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sectorBrands),const DeepCollectionEquality().hash(_globalBrands),const DeepCollectionEquality().hash(_selectedBrands),sectorName);

@override
String toString() {
  return 'SelectBrandsState.loaded(sectorBrands: $sectorBrands, globalBrands: $globalBrands, selectedBrands: $selectedBrands, sectorName: $sectorName)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SelectBrandsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<SelectBrandsViewModel> sectorBrands, List<SelectBrandsViewModel> globalBrands, List<SelectBrandsViewModel> selectedBrands, String sectorName
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SelectBrandsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sectorBrands = null,Object? globalBrands = null,Object? selectedBrands = null,Object? sectorName = null,}) {
  return _then(_Loaded(
sectorBrands: null == sectorBrands ? _self._sectorBrands : sectorBrands // ignore: cast_nullable_to_non_nullable
as List<SelectBrandsViewModel>,globalBrands: null == globalBrands ? _self._globalBrands : globalBrands // ignore: cast_nullable_to_non_nullable
as List<SelectBrandsViewModel>,selectedBrands: null == selectedBrands ? _self._selectedBrands : selectedBrands // ignore: cast_nullable_to_non_nullable
as List<SelectBrandsViewModel>,sectorName: null == sectorName ? _self.sectorName : sectorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
