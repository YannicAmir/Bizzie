// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_more_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyMoreState {

 MoreDataStatus get ratiosStatus; List<CompanyRatios> get ratios; Failure? get ratiosError; DateTime? get ratiosLastUpdated; MoreDataStatus get keyMetricsStatus; List<KeyMetrics> get keyMetrics; Failure? get keyMetricsError; DateTime? get keyMetricsLastUpdated;
/// Create a copy of CompanyMoreState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyMoreStateCopyWith<CompanyMoreState> get copyWith => _$CompanyMoreStateCopyWithImpl<CompanyMoreState>(this as CompanyMoreState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyMoreState&&(identical(other.ratiosStatus, ratiosStatus) || other.ratiosStatus == ratiosStatus)&&const DeepCollectionEquality().equals(other.ratios, ratios)&&(identical(other.ratiosError, ratiosError) || other.ratiosError == ratiosError)&&(identical(other.ratiosLastUpdated, ratiosLastUpdated) || other.ratiosLastUpdated == ratiosLastUpdated)&&(identical(other.keyMetricsStatus, keyMetricsStatus) || other.keyMetricsStatus == keyMetricsStatus)&&const DeepCollectionEquality().equals(other.keyMetrics, keyMetrics)&&(identical(other.keyMetricsError, keyMetricsError) || other.keyMetricsError == keyMetricsError)&&(identical(other.keyMetricsLastUpdated, keyMetricsLastUpdated) || other.keyMetricsLastUpdated == keyMetricsLastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,ratiosStatus,const DeepCollectionEquality().hash(ratios),ratiosError,ratiosLastUpdated,keyMetricsStatus,const DeepCollectionEquality().hash(keyMetrics),keyMetricsError,keyMetricsLastUpdated);

@override
String toString() {
  return 'CompanyMoreState(ratiosStatus: $ratiosStatus, ratios: $ratios, ratiosError: $ratiosError, ratiosLastUpdated: $ratiosLastUpdated, keyMetricsStatus: $keyMetricsStatus, keyMetrics: $keyMetrics, keyMetricsError: $keyMetricsError, keyMetricsLastUpdated: $keyMetricsLastUpdated)';
}


}

/// @nodoc
abstract mixin class $CompanyMoreStateCopyWith<$Res>  {
  factory $CompanyMoreStateCopyWith(CompanyMoreState value, $Res Function(CompanyMoreState) _then) = _$CompanyMoreStateCopyWithImpl;
@useResult
$Res call({
 MoreDataStatus ratiosStatus, List<CompanyRatios> ratios, Failure? ratiosError, DateTime? ratiosLastUpdated, MoreDataStatus keyMetricsStatus, List<KeyMetrics> keyMetrics, Failure? keyMetricsError, DateTime? keyMetricsLastUpdated
});




}
/// @nodoc
class _$CompanyMoreStateCopyWithImpl<$Res>
    implements $CompanyMoreStateCopyWith<$Res> {
  _$CompanyMoreStateCopyWithImpl(this._self, this._then);

  final CompanyMoreState _self;
  final $Res Function(CompanyMoreState) _then;

/// Create a copy of CompanyMoreState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ratiosStatus = null,Object? ratios = null,Object? ratiosError = freezed,Object? ratiosLastUpdated = freezed,Object? keyMetricsStatus = null,Object? keyMetrics = null,Object? keyMetricsError = freezed,Object? keyMetricsLastUpdated = freezed,}) {
  return _then(_self.copyWith(
ratiosStatus: null == ratiosStatus ? _self.ratiosStatus : ratiosStatus // ignore: cast_nullable_to_non_nullable
as MoreDataStatus,ratios: null == ratios ? _self.ratios : ratios // ignore: cast_nullable_to_non_nullable
as List<CompanyRatios>,ratiosError: freezed == ratiosError ? _self.ratiosError : ratiosError // ignore: cast_nullable_to_non_nullable
as Failure?,ratiosLastUpdated: freezed == ratiosLastUpdated ? _self.ratiosLastUpdated : ratiosLastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,keyMetricsStatus: null == keyMetricsStatus ? _self.keyMetricsStatus : keyMetricsStatus // ignore: cast_nullable_to_non_nullable
as MoreDataStatus,keyMetrics: null == keyMetrics ? _self.keyMetrics : keyMetrics // ignore: cast_nullable_to_non_nullable
as List<KeyMetrics>,keyMetricsError: freezed == keyMetricsError ? _self.keyMetricsError : keyMetricsError // ignore: cast_nullable_to_non_nullable
as Failure?,keyMetricsLastUpdated: freezed == keyMetricsLastUpdated ? _self.keyMetricsLastUpdated : keyMetricsLastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyMoreState].
extension CompanyMoreStatePatterns on CompanyMoreState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyMoreState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyMoreState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyMoreState value)  $default,){
final _that = this;
switch (_that) {
case _CompanyMoreState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyMoreState value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyMoreState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MoreDataStatus ratiosStatus,  List<CompanyRatios> ratios,  Failure? ratiosError,  DateTime? ratiosLastUpdated,  MoreDataStatus keyMetricsStatus,  List<KeyMetrics> keyMetrics,  Failure? keyMetricsError,  DateTime? keyMetricsLastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyMoreState() when $default != null:
return $default(_that.ratiosStatus,_that.ratios,_that.ratiosError,_that.ratiosLastUpdated,_that.keyMetricsStatus,_that.keyMetrics,_that.keyMetricsError,_that.keyMetricsLastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MoreDataStatus ratiosStatus,  List<CompanyRatios> ratios,  Failure? ratiosError,  DateTime? ratiosLastUpdated,  MoreDataStatus keyMetricsStatus,  List<KeyMetrics> keyMetrics,  Failure? keyMetricsError,  DateTime? keyMetricsLastUpdated)  $default,) {final _that = this;
switch (_that) {
case _CompanyMoreState():
return $default(_that.ratiosStatus,_that.ratios,_that.ratiosError,_that.ratiosLastUpdated,_that.keyMetricsStatus,_that.keyMetrics,_that.keyMetricsError,_that.keyMetricsLastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MoreDataStatus ratiosStatus,  List<CompanyRatios> ratios,  Failure? ratiosError,  DateTime? ratiosLastUpdated,  MoreDataStatus keyMetricsStatus,  List<KeyMetrics> keyMetrics,  Failure? keyMetricsError,  DateTime? keyMetricsLastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _CompanyMoreState() when $default != null:
return $default(_that.ratiosStatus,_that.ratios,_that.ratiosError,_that.ratiosLastUpdated,_that.keyMetricsStatus,_that.keyMetrics,_that.keyMetricsError,_that.keyMetricsLastUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyMoreState implements CompanyMoreState {
  const _CompanyMoreState({this.ratiosStatus = MoreDataStatus.initial, final  List<CompanyRatios> ratios = const [], this.ratiosError, this.ratiosLastUpdated, this.keyMetricsStatus = MoreDataStatus.initial, final  List<KeyMetrics> keyMetrics = const [], this.keyMetricsError, this.keyMetricsLastUpdated}): _ratios = ratios,_keyMetrics = keyMetrics;
  

@override@JsonKey() final  MoreDataStatus ratiosStatus;
 final  List<CompanyRatios> _ratios;
@override@JsonKey() List<CompanyRatios> get ratios {
  if (_ratios is EqualUnmodifiableListView) return _ratios;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ratios);
}

@override final  Failure? ratiosError;
@override final  DateTime? ratiosLastUpdated;
@override@JsonKey() final  MoreDataStatus keyMetricsStatus;
 final  List<KeyMetrics> _keyMetrics;
@override@JsonKey() List<KeyMetrics> get keyMetrics {
  if (_keyMetrics is EqualUnmodifiableListView) return _keyMetrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keyMetrics);
}

@override final  Failure? keyMetricsError;
@override final  DateTime? keyMetricsLastUpdated;

/// Create a copy of CompanyMoreState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyMoreStateCopyWith<_CompanyMoreState> get copyWith => __$CompanyMoreStateCopyWithImpl<_CompanyMoreState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyMoreState&&(identical(other.ratiosStatus, ratiosStatus) || other.ratiosStatus == ratiosStatus)&&const DeepCollectionEquality().equals(other._ratios, _ratios)&&(identical(other.ratiosError, ratiosError) || other.ratiosError == ratiosError)&&(identical(other.ratiosLastUpdated, ratiosLastUpdated) || other.ratiosLastUpdated == ratiosLastUpdated)&&(identical(other.keyMetricsStatus, keyMetricsStatus) || other.keyMetricsStatus == keyMetricsStatus)&&const DeepCollectionEquality().equals(other._keyMetrics, _keyMetrics)&&(identical(other.keyMetricsError, keyMetricsError) || other.keyMetricsError == keyMetricsError)&&(identical(other.keyMetricsLastUpdated, keyMetricsLastUpdated) || other.keyMetricsLastUpdated == keyMetricsLastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,ratiosStatus,const DeepCollectionEquality().hash(_ratios),ratiosError,ratiosLastUpdated,keyMetricsStatus,const DeepCollectionEquality().hash(_keyMetrics),keyMetricsError,keyMetricsLastUpdated);

@override
String toString() {
  return 'CompanyMoreState(ratiosStatus: $ratiosStatus, ratios: $ratios, ratiosError: $ratiosError, ratiosLastUpdated: $ratiosLastUpdated, keyMetricsStatus: $keyMetricsStatus, keyMetrics: $keyMetrics, keyMetricsError: $keyMetricsError, keyMetricsLastUpdated: $keyMetricsLastUpdated)';
}


}

/// @nodoc
abstract mixin class _$CompanyMoreStateCopyWith<$Res> implements $CompanyMoreStateCopyWith<$Res> {
  factory _$CompanyMoreStateCopyWith(_CompanyMoreState value, $Res Function(_CompanyMoreState) _then) = __$CompanyMoreStateCopyWithImpl;
@override @useResult
$Res call({
 MoreDataStatus ratiosStatus, List<CompanyRatios> ratios, Failure? ratiosError, DateTime? ratiosLastUpdated, MoreDataStatus keyMetricsStatus, List<KeyMetrics> keyMetrics, Failure? keyMetricsError, DateTime? keyMetricsLastUpdated
});




}
/// @nodoc
class __$CompanyMoreStateCopyWithImpl<$Res>
    implements _$CompanyMoreStateCopyWith<$Res> {
  __$CompanyMoreStateCopyWithImpl(this._self, this._then);

  final _CompanyMoreState _self;
  final $Res Function(_CompanyMoreState) _then;

/// Create a copy of CompanyMoreState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ratiosStatus = null,Object? ratios = null,Object? ratiosError = freezed,Object? ratiosLastUpdated = freezed,Object? keyMetricsStatus = null,Object? keyMetrics = null,Object? keyMetricsError = freezed,Object? keyMetricsLastUpdated = freezed,}) {
  return _then(_CompanyMoreState(
ratiosStatus: null == ratiosStatus ? _self.ratiosStatus : ratiosStatus // ignore: cast_nullable_to_non_nullable
as MoreDataStatus,ratios: null == ratios ? _self._ratios : ratios // ignore: cast_nullable_to_non_nullable
as List<CompanyRatios>,ratiosError: freezed == ratiosError ? _self.ratiosError : ratiosError // ignore: cast_nullable_to_non_nullable
as Failure?,ratiosLastUpdated: freezed == ratiosLastUpdated ? _self.ratiosLastUpdated : ratiosLastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,keyMetricsStatus: null == keyMetricsStatus ? _self.keyMetricsStatus : keyMetricsStatus // ignore: cast_nullable_to_non_nullable
as MoreDataStatus,keyMetrics: null == keyMetrics ? _self._keyMetrics : keyMetrics // ignore: cast_nullable_to_non_nullable
as List<KeyMetrics>,keyMetricsError: freezed == keyMetricsError ? _self.keyMetricsError : keyMetricsError // ignore: cast_nullable_to_non_nullable
as Failure?,keyMetricsLastUpdated: freezed == keyMetricsLastUpdated ? _self.keyMetricsLastUpdated : keyMetricsLastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
