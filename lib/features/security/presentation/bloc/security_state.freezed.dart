// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityState()';
}


}

/// @nodoc
class $SecurityStateCopyWith<$Res>  {
$SecurityStateCopyWith(SecurityState _, $Res Function(SecurityState) __);
}


/// Adds pattern-matching-related methods to [SecurityState].
extension SecurityStatePatterns on SecurityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Safe value)?  safe,TResult Function( Lockout value)?  lockout,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Safe() when safe != null:
return safe(_that);case Lockout() when lockout != null:
return lockout(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Safe value)  safe,required TResult Function( Lockout value)  lockout,}){
final _that = this;
switch (_that) {
case Safe():
return safe(_that);case Lockout():
return lockout(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Safe value)?  safe,TResult? Function( Lockout value)?  lockout,}){
final _that = this;
switch (_that) {
case Safe() when safe != null:
return safe(_that);case Lockout() when lockout != null:
return lockout(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  safe,TResult Function()?  lockout,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Safe() when safe != null:
return safe();case Lockout() when lockout != null:
return lockout();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  safe,required TResult Function()  lockout,}) {final _that = this;
switch (_that) {
case Safe():
return safe();case Lockout():
return lockout();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  safe,TResult? Function()?  lockout,}) {final _that = this;
switch (_that) {
case Safe() when safe != null:
return safe();case Lockout() when lockout != null:
return lockout();case _:
  return null;

}
}

}

/// @nodoc


class Safe implements SecurityState {
  const Safe();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Safe);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityState.safe()';
}


}




/// @nodoc


class Lockout implements SecurityState {
  const Lockout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lockout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityState.lockout()';
}


}




// dart format on
