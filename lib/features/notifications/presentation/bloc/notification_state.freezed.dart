// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationState {

 NotificationStatus get status; bool get isAppReady; NotificationIntent? get pendingIntent;
/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationStateCopyWith<NotificationState> get copyWith => _$NotificationStateCopyWithImpl<NotificationState>(this as NotificationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationState&&(identical(other.status, status) || other.status == status)&&(identical(other.isAppReady, isAppReady) || other.isAppReady == isAppReady)&&(identical(other.pendingIntent, pendingIntent) || other.pendingIntent == pendingIntent));
}


@override
int get hashCode => Object.hash(runtimeType,status,isAppReady,pendingIntent);

@override
String toString() {
  return 'NotificationState(status: $status, isAppReady: $isAppReady, pendingIntent: $pendingIntent)';
}


}

/// @nodoc
abstract mixin class $NotificationStateCopyWith<$Res>  {
  factory $NotificationStateCopyWith(NotificationState value, $Res Function(NotificationState) _then) = _$NotificationStateCopyWithImpl;
@useResult
$Res call({
 NotificationStatus status, bool isAppReady, NotificationIntent? pendingIntent
});


$NotificationStatusCopyWith<$Res> get status;$NotificationIntentCopyWith<$Res>? get pendingIntent;

}
/// @nodoc
class _$NotificationStateCopyWithImpl<$Res>
    implements $NotificationStateCopyWith<$Res> {
  _$NotificationStateCopyWithImpl(this._self, this._then);

  final NotificationState _self;
  final $Res Function(NotificationState) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? isAppReady = null,Object? pendingIntent = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotificationStatus,isAppReady: null == isAppReady ? _self.isAppReady : isAppReady // ignore: cast_nullable_to_non_nullable
as bool,pendingIntent: freezed == pendingIntent ? _self.pendingIntent : pendingIntent // ignore: cast_nullable_to_non_nullable
as NotificationIntent?,
  ));
}
/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationStatusCopyWith<$Res> get status {
  
  return $NotificationStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationIntentCopyWith<$Res>? get pendingIntent {
    if (_self.pendingIntent == null) {
    return null;
  }

  return $NotificationIntentCopyWith<$Res>(_self.pendingIntent!, (value) {
    return _then(_self.copyWith(pendingIntent: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationState].
extension NotificationStatePatterns on NotificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotificationStatus status,  bool isAppReady,  NotificationIntent? pendingIntent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationState() when $default != null:
return $default(_that.status,_that.isAppReady,_that.pendingIntent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotificationStatus status,  bool isAppReady,  NotificationIntent? pendingIntent)  $default,) {final _that = this;
switch (_that) {
case _NotificationState():
return $default(_that.status,_that.isAppReady,_that.pendingIntent);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotificationStatus status,  bool isAppReady,  NotificationIntent? pendingIntent)?  $default,) {final _that = this;
switch (_that) {
case _NotificationState() when $default != null:
return $default(_that.status,_that.isAppReady,_that.pendingIntent);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationState implements NotificationState {
  const _NotificationState({required this.status, required this.isAppReady, this.pendingIntent});
  

@override final  NotificationStatus status;
@override final  bool isAppReady;
@override final  NotificationIntent? pendingIntent;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationStateCopyWith<_NotificationState> get copyWith => __$NotificationStateCopyWithImpl<_NotificationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationState&&(identical(other.status, status) || other.status == status)&&(identical(other.isAppReady, isAppReady) || other.isAppReady == isAppReady)&&(identical(other.pendingIntent, pendingIntent) || other.pendingIntent == pendingIntent));
}


@override
int get hashCode => Object.hash(runtimeType,status,isAppReady,pendingIntent);

@override
String toString() {
  return 'NotificationState(status: $status, isAppReady: $isAppReady, pendingIntent: $pendingIntent)';
}


}

/// @nodoc
abstract mixin class _$NotificationStateCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$NotificationStateCopyWith(_NotificationState value, $Res Function(_NotificationState) _then) = __$NotificationStateCopyWithImpl;
@override @useResult
$Res call({
 NotificationStatus status, bool isAppReady, NotificationIntent? pendingIntent
});


@override $NotificationStatusCopyWith<$Res> get status;@override $NotificationIntentCopyWith<$Res>? get pendingIntent;

}
/// @nodoc
class __$NotificationStateCopyWithImpl<$Res>
    implements _$NotificationStateCopyWith<$Res> {
  __$NotificationStateCopyWithImpl(this._self, this._then);

  final _NotificationState _self;
  final $Res Function(_NotificationState) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? isAppReady = null,Object? pendingIntent = freezed,}) {
  return _then(_NotificationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotificationStatus,isAppReady: null == isAppReady ? _self.isAppReady : isAppReady // ignore: cast_nullable_to_non_nullable
as bool,pendingIntent: freezed == pendingIntent ? _self.pendingIntent : pendingIntent // ignore: cast_nullable_to_non_nullable
as NotificationIntent?,
  ));
}

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationStatusCopyWith<$Res> get status {
  
  return $NotificationStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationIntentCopyWith<$Res>? get pendingIntent {
    if (_self.pendingIntent == null) {
    return null;
  }

  return $NotificationIntentCopyWith<$Res>(_self.pendingIntent!, (value) {
    return _then(_self.copyWith(pendingIntent: value));
  });
}
}

// dart format on
