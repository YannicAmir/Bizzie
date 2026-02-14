// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedbackState {

 bool get isCoolingDown;
/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackStateCopyWith<FeedbackState> get copyWith => _$FeedbackStateCopyWithImpl<FeedbackState>(this as FeedbackState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackState&&(identical(other.isCoolingDown, isCoolingDown) || other.isCoolingDown == isCoolingDown));
}


@override
int get hashCode => Object.hash(runtimeType,isCoolingDown);

@override
String toString() {
  return 'FeedbackState(isCoolingDown: $isCoolingDown)';
}


}

/// @nodoc
abstract mixin class $FeedbackStateCopyWith<$Res>  {
  factory $FeedbackStateCopyWith(FeedbackState value, $Res Function(FeedbackState) _then) = _$FeedbackStateCopyWithImpl;
@useResult
$Res call({
 bool isCoolingDown
});




}
/// @nodoc
class _$FeedbackStateCopyWithImpl<$Res>
    implements $FeedbackStateCopyWith<$Res> {
  _$FeedbackStateCopyWithImpl(this._self, this._then);

  final FeedbackState _self;
  final $Res Function(FeedbackState) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isCoolingDown = null,}) {
  return _then(_self.copyWith(
isCoolingDown: null == isCoolingDown ? _self.isCoolingDown : isCoolingDown // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackState].
extension FeedbackStatePatterns on FeedbackState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Success value)?  success,TResult Function( FailureState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case FailureState() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Success value)  success,required TResult Function( FailureState value)  failure,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Success():
return success(_that);case FailureState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Success value)?  success,TResult? Function( FailureState value)?  failure,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case FailureState() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isCoolingDown)?  initial,TResult Function( bool isCoolingDown)?  loading,TResult Function( bool isCoolingDown)?  success,TResult Function( Failure failure,  bool isCoolingDown)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.isCoolingDown);case Loading() when loading != null:
return loading(_that.isCoolingDown);case Success() when success != null:
return success(_that.isCoolingDown);case FailureState() when failure != null:
return failure(_that.failure,_that.isCoolingDown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isCoolingDown)  initial,required TResult Function( bool isCoolingDown)  loading,required TResult Function( bool isCoolingDown)  success,required TResult Function( Failure failure,  bool isCoolingDown)  failure,}) {final _that = this;
switch (_that) {
case Initial():
return initial(_that.isCoolingDown);case Loading():
return loading(_that.isCoolingDown);case Success():
return success(_that.isCoolingDown);case FailureState():
return failure(_that.failure,_that.isCoolingDown);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isCoolingDown)?  initial,TResult? Function( bool isCoolingDown)?  loading,TResult? Function( bool isCoolingDown)?  success,TResult? Function( Failure failure,  bool isCoolingDown)?  failure,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.isCoolingDown);case Loading() when loading != null:
return loading(_that.isCoolingDown);case Success() when success != null:
return success(_that.isCoolingDown);case FailureState() when failure != null:
return failure(_that.failure,_that.isCoolingDown);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements FeedbackState {
  const Initial({this.isCoolingDown = false});
  

@override@JsonKey() final  bool isCoolingDown;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialCopyWith<Initial> get copyWith => _$InitialCopyWithImpl<Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial&&(identical(other.isCoolingDown, isCoolingDown) || other.isCoolingDown == isCoolingDown));
}


@override
int get hashCode => Object.hash(runtimeType,isCoolingDown);

@override
String toString() {
  return 'FeedbackState.initial(isCoolingDown: $isCoolingDown)';
}


}

/// @nodoc
abstract mixin class $InitialCopyWith<$Res> implements $FeedbackStateCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) _then) = _$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isCoolingDown
});




}
/// @nodoc
class _$InitialCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(this._self, this._then);

  final Initial _self;
  final $Res Function(Initial) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isCoolingDown = null,}) {
  return _then(Initial(
isCoolingDown: null == isCoolingDown ? _self.isCoolingDown : isCoolingDown // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Loading implements FeedbackState {
  const Loading({this.isCoolingDown = false});
  

@override@JsonKey() final  bool isCoolingDown;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingCopyWith<Loading> get copyWith => _$LoadingCopyWithImpl<Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading&&(identical(other.isCoolingDown, isCoolingDown) || other.isCoolingDown == isCoolingDown));
}


@override
int get hashCode => Object.hash(runtimeType,isCoolingDown);

@override
String toString() {
  return 'FeedbackState.loading(isCoolingDown: $isCoolingDown)';
}


}

/// @nodoc
abstract mixin class $LoadingCopyWith<$Res> implements $FeedbackStateCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) _then) = _$LoadingCopyWithImpl;
@override @useResult
$Res call({
 bool isCoolingDown
});




}
/// @nodoc
class _$LoadingCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(this._self, this._then);

  final Loading _self;
  final $Res Function(Loading) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isCoolingDown = null,}) {
  return _then(Loading(
isCoolingDown: null == isCoolingDown ? _self.isCoolingDown : isCoolingDown // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Success implements FeedbackState {
  const Success({this.isCoolingDown = true});
  

@override@JsonKey() final  bool isCoolingDown;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.isCoolingDown, isCoolingDown) || other.isCoolingDown == isCoolingDown));
}


@override
int get hashCode => Object.hash(runtimeType,isCoolingDown);

@override
String toString() {
  return 'FeedbackState.success(isCoolingDown: $isCoolingDown)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $FeedbackStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@override @useResult
$Res call({
 bool isCoolingDown
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isCoolingDown = null,}) {
  return _then(Success(
isCoolingDown: null == isCoolingDown ? _self.isCoolingDown : isCoolingDown // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class FailureState implements FeedbackState {
  const FailureState(this.failure, {this.isCoolingDown = false});
  

 final  Failure failure;
@override@JsonKey() final  bool isCoolingDown;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureStateCopyWith<FailureState> get copyWith => _$FailureStateCopyWithImpl<FailureState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureState&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isCoolingDown, isCoolingDown) || other.isCoolingDown == isCoolingDown));
}


@override
int get hashCode => Object.hash(runtimeType,failure,isCoolingDown);

@override
String toString() {
  return 'FeedbackState.failure(failure: $failure, isCoolingDown: $isCoolingDown)';
}


}

/// @nodoc
abstract mixin class $FailureStateCopyWith<$Res> implements $FeedbackStateCopyWith<$Res> {
  factory $FailureStateCopyWith(FailureState value, $Res Function(FailureState) _then) = _$FailureStateCopyWithImpl;
@override @useResult
$Res call({
 Failure failure, bool isCoolingDown
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$FailureStateCopyWithImpl<$Res>
    implements $FailureStateCopyWith<$Res> {
  _$FailureStateCopyWithImpl(this._self, this._then);

  final FailureState _self;
  final $Res Function(FailureState) _then;

/// Create a copy of FeedbackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? isCoolingDown = null,}) {
  return _then(FailureState(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,isCoolingDown: null == isCoolingDown ? _self.isCoolingDown : isCoolingDown // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FeedbackState
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
