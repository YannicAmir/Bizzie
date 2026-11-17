// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_status_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppStatusEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStatusEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppStatusEvent()';
}


}

/// @nodoc
class $AppStatusEventCopyWith<$Res>  {
$AppStatusEventCopyWith(AppStatusEvent _, $Res Function(AppStatusEvent) __);
}


/// Adds pattern-matching-related methods to [AppStatusEvent].
extension AppStatusEventPatterns on AppStatusEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppStatusStarted value)?  started,TResult Function( AppStatusRefreshed value)?  refreshed,TResult Function( AppStatusStatusChanged value)?  statusChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppStatusStarted() when started != null:
return started(_that);case AppStatusRefreshed() when refreshed != null:
return refreshed(_that);case AppStatusStatusChanged() when statusChanged != null:
return statusChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppStatusStarted value)  started,required TResult Function( AppStatusRefreshed value)  refreshed,required TResult Function( AppStatusStatusChanged value)  statusChanged,}){
final _that = this;
switch (_that) {
case AppStatusStarted():
return started(_that);case AppStatusRefreshed():
return refreshed(_that);case AppStatusStatusChanged():
return statusChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppStatusStarted value)?  started,TResult? Function( AppStatusRefreshed value)?  refreshed,TResult? Function( AppStatusStatusChanged value)?  statusChanged,}){
final _that = this;
switch (_that) {
case AppStatusStarted() when started != null:
return started(_that);case AppStatusRefreshed() when refreshed != null:
return refreshed(_that);case AppStatusStatusChanged() when statusChanged != null:
return statusChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( AppStatus status,  bool isManualRefresh)?  statusChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppStatusStarted() when started != null:
return started();case AppStatusRefreshed() when refreshed != null:
return refreshed();case AppStatusStatusChanged() when statusChanged != null:
return statusChanged(_that.status,_that.isManualRefresh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( AppStatus status,  bool isManualRefresh)  statusChanged,}) {final _that = this;
switch (_that) {
case AppStatusStarted():
return started();case AppStatusRefreshed():
return refreshed();case AppStatusStatusChanged():
return statusChanged(_that.status,_that.isManualRefresh);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( AppStatus status,  bool isManualRefresh)?  statusChanged,}) {final _that = this;
switch (_that) {
case AppStatusStarted() when started != null:
return started();case AppStatusRefreshed() when refreshed != null:
return refreshed();case AppStatusStatusChanged() when statusChanged != null:
return statusChanged(_that.status,_that.isManualRefresh);case _:
  return null;

}
}

}

/// @nodoc


class AppStatusStarted implements AppStatusEvent {
  const AppStatusStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStatusStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppStatusEvent.started()';
}


}




/// @nodoc


class AppStatusRefreshed implements AppStatusEvent {
  const AppStatusRefreshed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStatusRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppStatusEvent.refreshed()';
}


}




/// @nodoc


class AppStatusStatusChanged implements AppStatusEvent {
  const AppStatusStatusChanged(this.status, {this.isManualRefresh = false});
  

 final  AppStatus status;
@JsonKey() final  bool isManualRefresh;

/// Create a copy of AppStatusEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStatusStatusChangedCopyWith<AppStatusStatusChanged> get copyWith => _$AppStatusStatusChangedCopyWithImpl<AppStatusStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStatusStatusChanged&&(identical(other.status, status) || other.status == status)&&(identical(other.isManualRefresh, isManualRefresh) || other.isManualRefresh == isManualRefresh));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,isManualRefresh);
}

@override
String toString() {
    return 'AppStatusEvent.statusChanged(status: $status, isManualRefresh: $isManualRefresh)';
}


}

/// @nodoc
abstract mixin class $AppStatusStatusChangedCopyWith<$Res> implements $AppStatusEventCopyWith<$Res> {
  factory $AppStatusStatusChangedCopyWith(AppStatusStatusChanged value, $Res Function(AppStatusStatusChanged) _then) = _$AppStatusStatusChangedCopyWithImpl;
@useResult
$Res call({
 AppStatus status, bool isManualRefresh
});


$AppStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$AppStatusStatusChangedCopyWithImpl<$Res>
    implements $AppStatusStatusChangedCopyWith<$Res> {
  _$AppStatusStatusChangedCopyWithImpl(this._self, this._then);

  final AppStatusStatusChanged _self;
  final $Res Function(AppStatusStatusChanged) _then;

/// Create a copy of AppStatusEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,Object? isManualRefresh = null,}) {
  return _then(AppStatusStatusChanged(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppStatus,isManualRefresh: null == isManualRefresh ? _self.isManualRefresh : isManualRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AppStatusEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppStatusCopyWith<$Res> get status {
  
  return $AppStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
