// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_event_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistEventStatus {

 String get badgeText; WatchlistBadgeType get badgeType; DateTime get eventDate; DateTime get lastUpdated;
/// Create a copy of WatchlistEventStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistEventStatusCopyWith<WatchlistEventStatus> get copyWith => _$WatchlistEventStatusCopyWithImpl<WatchlistEventStatus>(this as WatchlistEventStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistEventStatus&&(identical(other.badgeText, badgeText) || other.badgeText == badgeText)&&(identical(other.badgeType, badgeType) || other.badgeType == badgeType)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,badgeText,badgeType,eventDate,lastUpdated);

@override
String toString() {
  return 'WatchlistEventStatus(badgeText: $badgeText, badgeType: $badgeType, eventDate: $eventDate, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $WatchlistEventStatusCopyWith<$Res>  {
  factory $WatchlistEventStatusCopyWith(WatchlistEventStatus value, $Res Function(WatchlistEventStatus) _then) = _$WatchlistEventStatusCopyWithImpl;
@useResult
$Res call({
 String badgeText, WatchlistBadgeType badgeType, DateTime eventDate, DateTime lastUpdated
});




}
/// @nodoc
class _$WatchlistEventStatusCopyWithImpl<$Res>
    implements $WatchlistEventStatusCopyWith<$Res> {
  _$WatchlistEventStatusCopyWithImpl(this._self, this._then);

  final WatchlistEventStatus _self;
  final $Res Function(WatchlistEventStatus) _then;

/// Create a copy of WatchlistEventStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? badgeText = null,Object? badgeType = null,Object? eventDate = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
badgeText: null == badgeText ? _self.badgeText : badgeText // ignore: cast_nullable_to_non_nullable
as String,badgeType: null == badgeType ? _self.badgeType : badgeType // ignore: cast_nullable_to_non_nullable
as WatchlistBadgeType,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistEventStatus].
extension WatchlistEventStatusPatterns on WatchlistEventStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistEventStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistEventStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistEventStatus value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistEventStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistEventStatus value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistEventStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String badgeText,  WatchlistBadgeType badgeType,  DateTime eventDate,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistEventStatus() when $default != null:
return $default(_that.badgeText,_that.badgeType,_that.eventDate,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String badgeText,  WatchlistBadgeType badgeType,  DateTime eventDate,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _WatchlistEventStatus():
return $default(_that.badgeText,_that.badgeType,_that.eventDate,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String badgeText,  WatchlistBadgeType badgeType,  DateTime eventDate,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistEventStatus() when $default != null:
return $default(_that.badgeText,_that.badgeType,_that.eventDate,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _WatchlistEventStatus implements WatchlistEventStatus {
  const _WatchlistEventStatus({required this.badgeText, required this.badgeType, required this.eventDate, required this.lastUpdated});
  

@override final  String badgeText;
@override final  WatchlistBadgeType badgeType;
@override final  DateTime eventDate;
@override final  DateTime lastUpdated;

/// Create a copy of WatchlistEventStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistEventStatusCopyWith<_WatchlistEventStatus> get copyWith => __$WatchlistEventStatusCopyWithImpl<_WatchlistEventStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistEventStatus&&(identical(other.badgeText, badgeText) || other.badgeText == badgeText)&&(identical(other.badgeType, badgeType) || other.badgeType == badgeType)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,badgeText,badgeType,eventDate,lastUpdated);

@override
String toString() {
  return 'WatchlistEventStatus(badgeText: $badgeText, badgeType: $badgeType, eventDate: $eventDate, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$WatchlistEventStatusCopyWith<$Res> implements $WatchlistEventStatusCopyWith<$Res> {
  factory _$WatchlistEventStatusCopyWith(_WatchlistEventStatus value, $Res Function(_WatchlistEventStatus) _then) = __$WatchlistEventStatusCopyWithImpl;
@override @useResult
$Res call({
 String badgeText, WatchlistBadgeType badgeType, DateTime eventDate, DateTime lastUpdated
});




}
/// @nodoc
class __$WatchlistEventStatusCopyWithImpl<$Res>
    implements _$WatchlistEventStatusCopyWith<$Res> {
  __$WatchlistEventStatusCopyWithImpl(this._self, this._then);

  final _WatchlistEventStatus _self;
  final $Res Function(_WatchlistEventStatus) _then;

/// Create a copy of WatchlistEventStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? badgeText = null,Object? badgeType = null,Object? eventDate = null,Object? lastUpdated = null,}) {
  return _then(_WatchlistEventStatus(
badgeText: null == badgeText ? _self.badgeText : badgeText // ignore: cast_nullable_to_non_nullable
as String,badgeType: null == badgeType ? _self.badgeType : badgeType // ignore: cast_nullable_to_non_nullable
as WatchlistBadgeType,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
