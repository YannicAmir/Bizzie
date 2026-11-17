// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resolved_onboarding_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResolvedOnboardingData {

 OnboardingData get data; OnboardingFieldSources get sources;
/// Create a copy of ResolvedOnboardingData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResolvedOnboardingDataCopyWith<ResolvedOnboardingData> get copyWith => _$ResolvedOnboardingDataCopyWithImpl<ResolvedOnboardingData>(this as ResolvedOnboardingData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResolvedOnboardingData&&(identical(other.data, data) || other.data == data)&&(identical(other.sources, sources) || other.sources == sources));
}


@override
int get hashCode => Object.hash(runtimeType,data,sources);

@override
String toString() {
  return 'ResolvedOnboardingData(data: $data, sources: $sources)';
}


}

/// @nodoc
abstract mixin class $ResolvedOnboardingDataCopyWith<$Res>  {
  factory $ResolvedOnboardingDataCopyWith(ResolvedOnboardingData value, $Res Function(ResolvedOnboardingData) _then) = _$ResolvedOnboardingDataCopyWithImpl;
@useResult
$Res call({
 OnboardingData data, OnboardingFieldSources sources
});


$OnboardingDataCopyWith<$Res> get data;$OnboardingFieldSourcesCopyWith<$Res> get sources;

}
/// @nodoc
class _$ResolvedOnboardingDataCopyWithImpl<$Res>
    implements $ResolvedOnboardingDataCopyWith<$Res> {
  _$ResolvedOnboardingDataCopyWithImpl(this._self, this._then);

  final ResolvedOnboardingData _self;
  final $Res Function(ResolvedOnboardingData) _then;

/// Create a copy of ResolvedOnboardingData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? sources = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OnboardingData,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as OnboardingFieldSources,
  ));
}
/// Create a copy of ResolvedOnboardingData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res> get data {
  
  return $OnboardingDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of ResolvedOnboardingData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingFieldSourcesCopyWith<$Res> get sources {
  
  return $OnboardingFieldSourcesCopyWith<$Res>(_self.sources, (value) {
    return _then(_self.copyWith(sources: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResolvedOnboardingData].
extension ResolvedOnboardingDataPatterns on ResolvedOnboardingData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResolvedOnboardingData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResolvedOnboardingData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResolvedOnboardingData value)  $default,){
final _that = this;
switch (_that) {
case _ResolvedOnboardingData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResolvedOnboardingData value)?  $default,){
final _that = this;
switch (_that) {
case _ResolvedOnboardingData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingData data,  OnboardingFieldSources sources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResolvedOnboardingData() when $default != null:
return $default(_that.data,_that.sources);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingData data,  OnboardingFieldSources sources)  $default,) {final _that = this;
switch (_that) {
case _ResolvedOnboardingData():
return $default(_that.data,_that.sources);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingData data,  OnboardingFieldSources sources)?  $default,) {final _that = this;
switch (_that) {
case _ResolvedOnboardingData() when $default != null:
return $default(_that.data,_that.sources);case _:
  return null;

}
}

}

/// @nodoc


class _ResolvedOnboardingData implements ResolvedOnboardingData {
  const _ResolvedOnboardingData({required this.data, required this.sources});
  

@override final  OnboardingData data;
@override final  OnboardingFieldSources sources;

/// Create a copy of ResolvedOnboardingData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResolvedOnboardingDataCopyWith<_ResolvedOnboardingData> get copyWith => __$ResolvedOnboardingDataCopyWithImpl<_ResolvedOnboardingData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResolvedOnboardingData&&(identical(other.data, data) || other.data == data)&&(identical(other.sources, sources) || other.sources == sources));
}


@override
int get hashCode => Object.hash(runtimeType,data,sources);

@override
String toString() {
  return 'ResolvedOnboardingData(data: $data, sources: $sources)';
}


}

/// @nodoc
abstract mixin class _$ResolvedOnboardingDataCopyWith<$Res> implements $ResolvedOnboardingDataCopyWith<$Res> {
  factory _$ResolvedOnboardingDataCopyWith(_ResolvedOnboardingData value, $Res Function(_ResolvedOnboardingData) _then) = __$ResolvedOnboardingDataCopyWithImpl;
@override @useResult
$Res call({
 OnboardingData data, OnboardingFieldSources sources
});


@override $OnboardingDataCopyWith<$Res> get data;@override $OnboardingFieldSourcesCopyWith<$Res> get sources;

}
/// @nodoc
class __$ResolvedOnboardingDataCopyWithImpl<$Res>
    implements _$ResolvedOnboardingDataCopyWith<$Res> {
  __$ResolvedOnboardingDataCopyWithImpl(this._self, this._then);

  final _ResolvedOnboardingData _self;
  final $Res Function(_ResolvedOnboardingData) _then;

/// Create a copy of ResolvedOnboardingData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? sources = null,}) {
  return _then(_ResolvedOnboardingData(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OnboardingData,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as OnboardingFieldSources,
  ));
}

/// Create a copy of ResolvedOnboardingData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res> get data {
  
  return $OnboardingDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of ResolvedOnboardingData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingFieldSourcesCopyWith<$Res> get sources {
  
  return $OnboardingFieldSourcesCopyWith<$Res>(_self.sources, (value) {
    return _then(_self.copyWith(sources: value));
  });
}
}

// dart format on
