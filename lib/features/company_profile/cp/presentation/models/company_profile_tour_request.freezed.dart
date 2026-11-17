// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_tour_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyProfileTourRequest {

 bool get shouldPromptNotifications; void Function() get onPromptNotifications; void Function()? get onTourSkipped;
/// Create a copy of CompanyProfileTourRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyProfileTourRequestCopyWith<CompanyProfileTourRequest> get copyWith => _$CompanyProfileTourRequestCopyWithImpl<CompanyProfileTourRequest>(this as CompanyProfileTourRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CompanyProfileTourRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileTourRequest&&(identical(other.shouldPromptNotifications, _this.shouldPromptNotifications) || other.shouldPromptNotifications == _this.shouldPromptNotifications)&&(identical(other.onPromptNotifications, _this.onPromptNotifications) || other.onPromptNotifications == _this.onPromptNotifications)&&(identical(other.onTourSkipped, _this.onTourSkipped) || other.onTourSkipped == _this.onTourSkipped));
}


@override
int get hashCode {
  final _this = this as CompanyProfileTourRequest;
  return Object.hash(runtimeType,_this.shouldPromptNotifications,_this.onPromptNotifications,_this.onTourSkipped);
}

@override
String toString() {
  final _this = this as CompanyProfileTourRequest;
  return 'CompanyProfileTourRequest(shouldPromptNotifications: ${_this.shouldPromptNotifications}, onPromptNotifications: ${_this.onPromptNotifications}, onTourSkipped: ${_this.onTourSkipped})';
}


}

/// @nodoc
abstract mixin class $CompanyProfileTourRequestCopyWith<$Res>  {
  factory $CompanyProfileTourRequestCopyWith(CompanyProfileTourRequest value, $Res Function(CompanyProfileTourRequest) _then) = _$CompanyProfileTourRequestCopyWithImpl;
@useResult
$Res call({
 bool shouldPromptNotifications, void Function() onPromptNotifications, void Function()? onTourSkipped
});




}
/// @nodoc
class _$CompanyProfileTourRequestCopyWithImpl<$Res>
    implements $CompanyProfileTourRequestCopyWith<$Res> {
  _$CompanyProfileTourRequestCopyWithImpl(this._self, this._then);

  final CompanyProfileTourRequest _self;
  final $Res Function(CompanyProfileTourRequest) _then;

/// Create a copy of CompanyProfileTourRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shouldPromptNotifications = null,Object? onPromptNotifications = null,Object? onTourSkipped = freezed,}) {
  return _then(CompanyProfileTourRequest(
shouldPromptNotifications: null == shouldPromptNotifications ? _self.shouldPromptNotifications : shouldPromptNotifications // ignore: cast_nullable_to_non_nullable
as bool,onPromptNotifications: null == onPromptNotifications ? _self.onPromptNotifications : onPromptNotifications // ignore: cast_nullable_to_non_nullable
as void Function(),onTourSkipped: freezed == onTourSkipped ? _self.onTourSkipped : onTourSkipped // ignore: cast_nullable_to_non_nullable
as void Function()?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyProfileTourRequest].
extension CompanyProfileTourRequestPatterns on CompanyProfileTourRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyProfileTourRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyProfileTourRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyProfileTourRequest value)  $default,){
final _that = this;
switch (_that) {
case _CompanyProfileTourRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyProfileTourRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyProfileTourRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool shouldPromptNotifications,  void Function() onPromptNotifications,  void Function()? onTourSkipped)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyProfileTourRequest() when $default != null:
return $default(_that.shouldPromptNotifications,_that.onPromptNotifications,_that.onTourSkipped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool shouldPromptNotifications,  void Function() onPromptNotifications,  void Function()? onTourSkipped)  $default,) {final _that = this;
switch (_that) {
case _CompanyProfileTourRequest():
return $default(_that.shouldPromptNotifications,_that.onPromptNotifications,_that.onTourSkipped);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool shouldPromptNotifications,  void Function() onPromptNotifications,  void Function()? onTourSkipped)?  $default,) {final _that = this;
switch (_that) {
case _CompanyProfileTourRequest() when $default != null:
return $default(_that.shouldPromptNotifications,_that.onPromptNotifications,_that.onTourSkipped);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyProfileTourRequest implements CompanyProfileTourRequest {
  const _CompanyProfileTourRequest({required this.shouldPromptNotifications, required this.onPromptNotifications, this.onTourSkipped});
  

@override final  bool shouldPromptNotifications;
@override final  void Function() onPromptNotifications;
@override final  void Function()? onTourSkipped;

/// Create a copy of CompanyProfileTourRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyProfileTourRequestCopyWith<_CompanyProfileTourRequest> get copyWith => __$CompanyProfileTourRequestCopyWithImpl<_CompanyProfileTourRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyProfileTourRequest&&(identical(other.shouldPromptNotifications, shouldPromptNotifications) || other.shouldPromptNotifications == shouldPromptNotifications)&&(identical(other.onPromptNotifications, onPromptNotifications) || other.onPromptNotifications == onPromptNotifications)&&(identical(other.onTourSkipped, onTourSkipped) || other.onTourSkipped == onTourSkipped));
}


@override
int get hashCode {
    return Object.hash(runtimeType,shouldPromptNotifications,onPromptNotifications,onTourSkipped);
}

@override
String toString() {
    return 'CompanyProfileTourRequest(shouldPromptNotifications: $shouldPromptNotifications, onPromptNotifications: $onPromptNotifications, onTourSkipped: $onTourSkipped)';
}


}

/// @nodoc
abstract mixin class _$CompanyProfileTourRequestCopyWith<$Res> implements $CompanyProfileTourRequestCopyWith<$Res> {
  factory _$CompanyProfileTourRequestCopyWith(_CompanyProfileTourRequest value, $Res Function(_CompanyProfileTourRequest) _then) = __$CompanyProfileTourRequestCopyWithImpl;
@override @useResult
$Res call({
 bool shouldPromptNotifications, void Function() onPromptNotifications, void Function()? onTourSkipped
});




}
/// @nodoc
class __$CompanyProfileTourRequestCopyWithImpl<$Res>
    implements _$CompanyProfileTourRequestCopyWith<$Res> {
  __$CompanyProfileTourRequestCopyWithImpl(this._self, this._then);

  final _CompanyProfileTourRequest _self;
  final $Res Function(_CompanyProfileTourRequest) _then;

/// Create a copy of CompanyProfileTourRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shouldPromptNotifications = null,Object? onPromptNotifications = null,Object? onTourSkipped = freezed,}) {
  return _then(_CompanyProfileTourRequest(
shouldPromptNotifications: null == shouldPromptNotifications ? _self.shouldPromptNotifications : shouldPromptNotifications // ignore: cast_nullable_to_non_nullable
as bool,onPromptNotifications: null == onPromptNotifications ? _self.onPromptNotifications : onPromptNotifications // ignore: cast_nullable_to_non_nullable
as void Function(),onTourSkipped: freezed == onTourSkipped ? _self.onTourSkipped : onTourSkipped // ignore: cast_nullable_to_non_nullable
as void Function()?,
  ));
}


}

// dart format on
