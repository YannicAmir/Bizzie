// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_sector_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectSectorState {

 SectorViewModel get initialSector; SectorViewModel get selectedSector; List<SectorViewModel> get availableSectors;
/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectSectorStateCopyWith<SelectSectorState> get copyWith => _$SelectSectorStateCopyWithImpl<SelectSectorState>(this as SelectSectorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectSectorState&&(identical(other.initialSector, initialSector) || other.initialSector == initialSector)&&(identical(other.selectedSector, selectedSector) || other.selectedSector == selectedSector)&&const DeepCollectionEquality().equals(other.availableSectors, availableSectors));
}


@override
int get hashCode => Object.hash(runtimeType,initialSector,selectedSector,const DeepCollectionEquality().hash(availableSectors));

@override
String toString() {
  return 'SelectSectorState(initialSector: $initialSector, selectedSector: $selectedSector, availableSectors: $availableSectors)';
}


}

/// @nodoc
abstract mixin class $SelectSectorStateCopyWith<$Res>  {
  factory $SelectSectorStateCopyWith(SelectSectorState value, $Res Function(SelectSectorState) _then) = _$SelectSectorStateCopyWithImpl;
@useResult
$Res call({
 SectorViewModel initialSector, SectorViewModel selectedSector, List<SectorViewModel> availableSectors
});


$SectorViewModelCopyWith<$Res> get initialSector;$SectorViewModelCopyWith<$Res> get selectedSector;

}
/// @nodoc
class _$SelectSectorStateCopyWithImpl<$Res>
    implements $SelectSectorStateCopyWith<$Res> {
  _$SelectSectorStateCopyWithImpl(this._self, this._then);

  final SelectSectorState _self;
  final $Res Function(SelectSectorState) _then;

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialSector = null,Object? selectedSector = null,Object? availableSectors = null,}) {
  return _then(_self.copyWith(
initialSector: null == initialSector ? _self.initialSector : initialSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,selectedSector: null == selectedSector ? _self.selectedSector : selectedSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,availableSectors: null == availableSectors ? _self.availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<SectorViewModel>,
  ));
}
/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get initialSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.initialSector, (value) {
    return _then(_self.copyWith(initialSector: value));
  });
}/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get selectedSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.selectedSector, (value) {
    return _then(_self.copyWith(selectedSector: value));
  });
}
}


/// Adds pattern-matching-related methods to [SelectSectorState].
extension SelectSectorStatePatterns on SelectSectorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)?  initial,TResult Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)?  loading,TResult Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)?  success,TResult Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors,  Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Loading() when loading != null:
return loading(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Success() when success != null:
return success(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Failure() when failure != null:
return failure(_that.initialSector,_that.selectedSector,_that.availableSectors,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)  initial,required TResult Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)  loading,required TResult Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)  success,required TResult Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors,  Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Loading():
return loading(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Success():
return success(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Failure():
return failure(_that.initialSector,_that.selectedSector,_that.availableSectors,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)?  initial,TResult? Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)?  loading,TResult? Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors)?  success,TResult? Function( SectorViewModel initialSector,  SectorViewModel selectedSector,  List<SectorViewModel> availableSectors,  Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Loading() when loading != null:
return loading(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Success() when success != null:
return success(_that.initialSector,_that.selectedSector,_that.availableSectors);case _Failure() when failure != null:
return failure(_that.initialSector,_that.selectedSector,_that.availableSectors,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial extends SelectSectorState {
  const _Initial({required this.initialSector, required this.selectedSector, required final  List<SectorViewModel> availableSectors}): _availableSectors = availableSectors,super._();
  

@override final  SectorViewModel initialSector;
@override final  SectorViewModel selectedSector;
 final  List<SectorViewModel> _availableSectors;
@override List<SectorViewModel> get availableSectors {
  if (_availableSectors is EqualUnmodifiableListView) return _availableSectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableSectors);
}


/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.initialSector, initialSector) || other.initialSector == initialSector)&&(identical(other.selectedSector, selectedSector) || other.selectedSector == selectedSector)&&const DeepCollectionEquality().equals(other._availableSectors, _availableSectors));
}


@override
int get hashCode => Object.hash(runtimeType,initialSector,selectedSector,const DeepCollectionEquality().hash(_availableSectors));

@override
String toString() {
  return 'SelectSectorState.initial(initialSector: $initialSector, selectedSector: $selectedSector, availableSectors: $availableSectors)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $SelectSectorStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 SectorViewModel initialSector, SectorViewModel selectedSector, List<SectorViewModel> availableSectors
});


@override $SectorViewModelCopyWith<$Res> get initialSector;@override $SectorViewModelCopyWith<$Res> get selectedSector;

}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialSector = null,Object? selectedSector = null,Object? availableSectors = null,}) {
  return _then(_Initial(
initialSector: null == initialSector ? _self.initialSector : initialSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,selectedSector: null == selectedSector ? _self.selectedSector : selectedSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,availableSectors: null == availableSectors ? _self._availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<SectorViewModel>,
  ));
}

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get initialSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.initialSector, (value) {
    return _then(_self.copyWith(initialSector: value));
  });
}/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get selectedSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.selectedSector, (value) {
    return _then(_self.copyWith(selectedSector: value));
  });
}
}

/// @nodoc


class _Loading extends SelectSectorState {
  const _Loading({required this.initialSector, required this.selectedSector, required final  List<SectorViewModel> availableSectors}): _availableSectors = availableSectors,super._();
  

@override final  SectorViewModel initialSector;
@override final  SectorViewModel selectedSector;
 final  List<SectorViewModel> _availableSectors;
@override List<SectorViewModel> get availableSectors {
  if (_availableSectors is EqualUnmodifiableListView) return _availableSectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableSectors);
}


/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.initialSector, initialSector) || other.initialSector == initialSector)&&(identical(other.selectedSector, selectedSector) || other.selectedSector == selectedSector)&&const DeepCollectionEquality().equals(other._availableSectors, _availableSectors));
}


@override
int get hashCode => Object.hash(runtimeType,initialSector,selectedSector,const DeepCollectionEquality().hash(_availableSectors));

@override
String toString() {
  return 'SelectSectorState.loading(initialSector: $initialSector, selectedSector: $selectedSector, availableSectors: $availableSectors)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $SelectSectorStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 SectorViewModel initialSector, SectorViewModel selectedSector, List<SectorViewModel> availableSectors
});


@override $SectorViewModelCopyWith<$Res> get initialSector;@override $SectorViewModelCopyWith<$Res> get selectedSector;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialSector = null,Object? selectedSector = null,Object? availableSectors = null,}) {
  return _then(_Loading(
initialSector: null == initialSector ? _self.initialSector : initialSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,selectedSector: null == selectedSector ? _self.selectedSector : selectedSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,availableSectors: null == availableSectors ? _self._availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<SectorViewModel>,
  ));
}

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get initialSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.initialSector, (value) {
    return _then(_self.copyWith(initialSector: value));
  });
}/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get selectedSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.selectedSector, (value) {
    return _then(_self.copyWith(selectedSector: value));
  });
}
}

/// @nodoc


class _Success extends SelectSectorState {
  const _Success({required this.initialSector, required this.selectedSector, required final  List<SectorViewModel> availableSectors}): _availableSectors = availableSectors,super._();
  

@override final  SectorViewModel initialSector;
@override final  SectorViewModel selectedSector;
 final  List<SectorViewModel> _availableSectors;
@override List<SectorViewModel> get availableSectors {
  if (_availableSectors is EqualUnmodifiableListView) return _availableSectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableSectors);
}


/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.initialSector, initialSector) || other.initialSector == initialSector)&&(identical(other.selectedSector, selectedSector) || other.selectedSector == selectedSector)&&const DeepCollectionEquality().equals(other._availableSectors, _availableSectors));
}


@override
int get hashCode => Object.hash(runtimeType,initialSector,selectedSector,const DeepCollectionEquality().hash(_availableSectors));

@override
String toString() {
  return 'SelectSectorState.success(initialSector: $initialSector, selectedSector: $selectedSector, availableSectors: $availableSectors)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $SelectSectorStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@override @useResult
$Res call({
 SectorViewModel initialSector, SectorViewModel selectedSector, List<SectorViewModel> availableSectors
});


@override $SectorViewModelCopyWith<$Res> get initialSector;@override $SectorViewModelCopyWith<$Res> get selectedSector;

}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialSector = null,Object? selectedSector = null,Object? availableSectors = null,}) {
  return _then(_Success(
initialSector: null == initialSector ? _self.initialSector : initialSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,selectedSector: null == selectedSector ? _self.selectedSector : selectedSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,availableSectors: null == availableSectors ? _self._availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<SectorViewModel>,
  ));
}

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get initialSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.initialSector, (value) {
    return _then(_self.copyWith(initialSector: value));
  });
}/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get selectedSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.selectedSector, (value) {
    return _then(_self.copyWith(selectedSector: value));
  });
}
}

/// @nodoc


class _Failure extends SelectSectorState {
  const _Failure({required this.initialSector, required this.selectedSector, required final  List<SectorViewModel> availableSectors, required this.failure}): _availableSectors = availableSectors,super._();
  

@override final  SectorViewModel initialSector;
@override final  SectorViewModel selectedSector;
 final  List<SectorViewModel> _availableSectors;
@override List<SectorViewModel> get availableSectors {
  if (_availableSectors is EqualUnmodifiableListView) return _availableSectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableSectors);
}

 final  Failure failure;

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.initialSector, initialSector) || other.initialSector == initialSector)&&(identical(other.selectedSector, selectedSector) || other.selectedSector == selectedSector)&&const DeepCollectionEquality().equals(other._availableSectors, _availableSectors)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,initialSector,selectedSector,const DeepCollectionEquality().hash(_availableSectors),failure);

@override
String toString() {
  return 'SelectSectorState.failure(initialSector: $initialSector, selectedSector: $selectedSector, availableSectors: $availableSectors, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $SelectSectorStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@override @useResult
$Res call({
 SectorViewModel initialSector, SectorViewModel selectedSector, List<SectorViewModel> availableSectors, Failure failure
});


@override $SectorViewModelCopyWith<$Res> get initialSector;@override $SectorViewModelCopyWith<$Res> get selectedSector;$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialSector = null,Object? selectedSector = null,Object? availableSectors = null,Object? failure = null,}) {
  return _then(_Failure(
initialSector: null == initialSector ? _self.initialSector : initialSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,selectedSector: null == selectedSector ? _self.selectedSector : selectedSector // ignore: cast_nullable_to_non_nullable
as SectorViewModel,availableSectors: null == availableSectors ? _self._availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<SectorViewModel>,failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get initialSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.initialSector, (value) {
    return _then(_self.copyWith(initialSector: value));
  });
}/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorViewModelCopyWith<$Res> get selectedSector {
  
  return $SectorViewModelCopyWith<$Res>(_self.selectedSector, (value) {
    return _then(_self.copyWith(selectedSector: value));
  });
}/// Create a copy of SelectSectorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
