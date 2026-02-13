// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_subscription_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncSubscriptionResult {

 bool get isActive; String? get status; DateTime? get expirationDate;
/// Create a copy of SyncSubscriptionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncSubscriptionResultCopyWith<SyncSubscriptionResult> get copyWith => _$SyncSubscriptionResultCopyWithImpl<SyncSubscriptionResult>(this as SyncSubscriptionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSubscriptionResult&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.status, status) || other.status == status)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate));
}


@override
int get hashCode => Object.hash(runtimeType,isActive,status,expirationDate);

@override
String toString() {
  return 'SyncSubscriptionResult(isActive: $isActive, status: $status, expirationDate: $expirationDate)';
}


}

/// @nodoc
abstract mixin class $SyncSubscriptionResultCopyWith<$Res>  {
  factory $SyncSubscriptionResultCopyWith(SyncSubscriptionResult value, $Res Function(SyncSubscriptionResult) _then) = _$SyncSubscriptionResultCopyWithImpl;
@useResult
$Res call({
 bool isActive, String? status, DateTime? expirationDate
});




}
/// @nodoc
class _$SyncSubscriptionResultCopyWithImpl<$Res>
    implements $SyncSubscriptionResultCopyWith<$Res> {
  _$SyncSubscriptionResultCopyWithImpl(this._self, this._then);

  final SyncSubscriptionResult _self;
  final $Res Function(SyncSubscriptionResult) _then;

/// Create a copy of SyncSubscriptionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isActive = null,Object? status = freezed,Object? expirationDate = freezed,}) {
  return _then(_self.copyWith(
isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncSubscriptionResult].
extension SyncSubscriptionResultPatterns on SyncSubscriptionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncSubscriptionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncSubscriptionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncSubscriptionResult value)  $default,){
final _that = this;
switch (_that) {
case _SyncSubscriptionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncSubscriptionResult value)?  $default,){
final _that = this;
switch (_that) {
case _SyncSubscriptionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isActive,  String? status,  DateTime? expirationDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncSubscriptionResult() when $default != null:
return $default(_that.isActive,_that.status,_that.expirationDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isActive,  String? status,  DateTime? expirationDate)  $default,) {final _that = this;
switch (_that) {
case _SyncSubscriptionResult():
return $default(_that.isActive,_that.status,_that.expirationDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isActive,  String? status,  DateTime? expirationDate)?  $default,) {final _that = this;
switch (_that) {
case _SyncSubscriptionResult() when $default != null:
return $default(_that.isActive,_that.status,_that.expirationDate);case _:
  return null;

}
}

}

/// @nodoc


class _SyncSubscriptionResult implements SyncSubscriptionResult {
  const _SyncSubscriptionResult({required this.isActive, this.status, this.expirationDate});
  

@override final  bool isActive;
@override final  String? status;
@override final  DateTime? expirationDate;

/// Create a copy of SyncSubscriptionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncSubscriptionResultCopyWith<_SyncSubscriptionResult> get copyWith => __$SyncSubscriptionResultCopyWithImpl<_SyncSubscriptionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncSubscriptionResult&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.status, status) || other.status == status)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate));
}


@override
int get hashCode => Object.hash(runtimeType,isActive,status,expirationDate);

@override
String toString() {
  return 'SyncSubscriptionResult(isActive: $isActive, status: $status, expirationDate: $expirationDate)';
}


}

/// @nodoc
abstract mixin class _$SyncSubscriptionResultCopyWith<$Res> implements $SyncSubscriptionResultCopyWith<$Res> {
  factory _$SyncSubscriptionResultCopyWith(_SyncSubscriptionResult value, $Res Function(_SyncSubscriptionResult) _then) = __$SyncSubscriptionResultCopyWithImpl;
@override @useResult
$Res call({
 bool isActive, String? status, DateTime? expirationDate
});




}
/// @nodoc
class __$SyncSubscriptionResultCopyWithImpl<$Res>
    implements _$SyncSubscriptionResultCopyWith<$Res> {
  __$SyncSubscriptionResultCopyWithImpl(this._self, this._then);

  final _SyncSubscriptionResult _self;
  final $Res Function(_SyncSubscriptionResult) _then;

/// Create a copy of SyncSubscriptionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isActive = null,Object? status = freezed,Object? expirationDate = freezed,}) {
  return _then(_SyncSubscriptionResult(
isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
