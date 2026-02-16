// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_ratings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppRatingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRatingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppRatingsEvent()';
}


}

/// @nodoc
class $AppRatingsEventCopyWith<$Res>  {
$AppRatingsEventCopyWith(AppRatingsEvent _, $Res Function(AppRatingsEvent) __);
}


/// Adds pattern-matching-related methods to [AppRatingsEvent].
extension AppRatingsEventPatterns on AppRatingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InteractionDetected value)?  interactionDetected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InteractionDetected() when interactionDetected != null:
return interactionDetected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InteractionDetected value)  interactionDetected,}){
final _that = this;
switch (_that) {
case _InteractionDetected():
return interactionDetected(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InteractionDetected value)?  interactionDetected,}){
final _that = this;
switch (_that) {
case _InteractionDetected() when interactionDetected != null:
return interactionDetected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  interactionDetected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InteractionDetected() when interactionDetected != null:
return interactionDetected();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  interactionDetected,}) {final _that = this;
switch (_that) {
case _InteractionDetected():
return interactionDetected();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  interactionDetected,}) {final _that = this;
switch (_that) {
case _InteractionDetected() when interactionDetected != null:
return interactionDetected();case _:
  return null;

}
}

}

/// @nodoc


class _InteractionDetected implements AppRatingsEvent {
  const _InteractionDetected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InteractionDetected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppRatingsEvent.interactionDetected()';
}


}




/// @nodoc
mixin _$AppRatingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRatingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppRatingsState()';
}


}

/// @nodoc
class $AppRatingsStateCopyWith<$Res>  {
$AppRatingsStateCopyWith(AppRatingsState _, $Res Function(AppRatingsState) __);
}


/// Adds pattern-matching-related methods to [AppRatingsState].
extension AppRatingsStatePatterns on AppRatingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _RequestReview value)?  requestReview,TResult Function( _Idle value)?  idle,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _RequestReview() when requestReview != null:
return requestReview(_that);case _Idle() when idle != null:
return idle(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _RequestReview value)  requestReview,required TResult Function( _Idle value)  idle,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _RequestReview():
return requestReview(_that);case _Idle():
return idle(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _RequestReview value)?  requestReview,TResult? Function( _Idle value)?  idle,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _RequestReview() when requestReview != null:
return requestReview(_that);case _Idle() when idle != null:
return idle(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  requestReview,TResult Function()?  idle,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _RequestReview() when requestReview != null:
return requestReview();case _Idle() when idle != null:
return idle();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  requestReview,required TResult Function()  idle,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _RequestReview():
return requestReview();case _Idle():
return idle();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  requestReview,TResult? Function()?  idle,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _RequestReview() when requestReview != null:
return requestReview();case _Idle() when idle != null:
return idle();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AppRatingsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppRatingsState.initial()';
}


}




/// @nodoc


class _RequestReview implements AppRatingsState {
  const _RequestReview();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestReview);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppRatingsState.requestReview()';
}


}




/// @nodoc


class _Idle implements AppRatingsState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppRatingsState.idle()';
}


}




// dart format on
