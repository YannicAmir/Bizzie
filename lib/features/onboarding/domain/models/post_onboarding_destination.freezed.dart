// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_onboarding_destination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostOnboardingDestination {

 String get ticker; OnboardingValueSource get tickerSource; bool get shouldPromptNotifications; bool get shouldPersistNotificationGrant;
/// Create a copy of PostOnboardingDestination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostOnboardingDestinationCopyWith<PostOnboardingDestination> get copyWith => _$PostOnboardingDestinationCopyWithImpl<PostOnboardingDestination>(this as PostOnboardingDestination, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PostOnboardingDestination;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostOnboardingDestination&&(identical(other.ticker, _this.ticker) || other.ticker == _this.ticker)&&(identical(other.tickerSource, _this.tickerSource) || other.tickerSource == _this.tickerSource)&&(identical(other.shouldPromptNotifications, _this.shouldPromptNotifications) || other.shouldPromptNotifications == _this.shouldPromptNotifications)&&(identical(other.shouldPersistNotificationGrant, _this.shouldPersistNotificationGrant) || other.shouldPersistNotificationGrant == _this.shouldPersistNotificationGrant));
}


@override
int get hashCode {
  final _this = this as PostOnboardingDestination;
  return Object.hash(runtimeType,_this.ticker,_this.tickerSource,_this.shouldPromptNotifications,_this.shouldPersistNotificationGrant);
}

@override
String toString() {
  final _this = this as PostOnboardingDestination;
  return 'PostOnboardingDestination(ticker: ${_this.ticker}, tickerSource: ${_this.tickerSource}, shouldPromptNotifications: ${_this.shouldPromptNotifications}, shouldPersistNotificationGrant: ${_this.shouldPersistNotificationGrant})';
}


}

/// @nodoc
abstract mixin class $PostOnboardingDestinationCopyWith<$Res>  {
  factory $PostOnboardingDestinationCopyWith(PostOnboardingDestination value, $Res Function(PostOnboardingDestination) _then) = _$PostOnboardingDestinationCopyWithImpl;
@useResult
$Res call({
 String ticker, OnboardingValueSource tickerSource, bool shouldPromptNotifications, bool shouldPersistNotificationGrant
});




}
/// @nodoc
class _$PostOnboardingDestinationCopyWithImpl<$Res>
    implements $PostOnboardingDestinationCopyWith<$Res> {
  _$PostOnboardingDestinationCopyWithImpl(this._self, this._then);

  final PostOnboardingDestination _self;
  final $Res Function(PostOnboardingDestination) _then;

/// Create a copy of PostOnboardingDestination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? tickerSource = null,Object? shouldPromptNotifications = null,Object? shouldPersistNotificationGrant = null,}) {
  return _then(PostOnboardingDestination(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,tickerSource: null == tickerSource ? _self.tickerSource : tickerSource // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,shouldPromptNotifications: null == shouldPromptNotifications ? _self.shouldPromptNotifications : shouldPromptNotifications // ignore: cast_nullable_to_non_nullable
as bool,shouldPersistNotificationGrant: null == shouldPersistNotificationGrant ? _self.shouldPersistNotificationGrant : shouldPersistNotificationGrant // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostOnboardingDestination].
extension PostOnboardingDestinationPatterns on PostOnboardingDestination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostOnboardingDestination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostOnboardingDestination() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostOnboardingDestination value)  $default,){
final _that = this;
switch (_that) {
case _PostOnboardingDestination():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostOnboardingDestination value)?  $default,){
final _that = this;
switch (_that) {
case _PostOnboardingDestination() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  OnboardingValueSource tickerSource,  bool shouldPromptNotifications,  bool shouldPersistNotificationGrant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostOnboardingDestination() when $default != null:
return $default(_that.ticker,_that.tickerSource,_that.shouldPromptNotifications,_that.shouldPersistNotificationGrant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  OnboardingValueSource tickerSource,  bool shouldPromptNotifications,  bool shouldPersistNotificationGrant)  $default,) {final _that = this;
switch (_that) {
case _PostOnboardingDestination():
return $default(_that.ticker,_that.tickerSource,_that.shouldPromptNotifications,_that.shouldPersistNotificationGrant);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  OnboardingValueSource tickerSource,  bool shouldPromptNotifications,  bool shouldPersistNotificationGrant)?  $default,) {final _that = this;
switch (_that) {
case _PostOnboardingDestination() when $default != null:
return $default(_that.ticker,_that.tickerSource,_that.shouldPromptNotifications,_that.shouldPersistNotificationGrant);case _:
  return null;

}
}

}

/// @nodoc


class _PostOnboardingDestination implements PostOnboardingDestination {
  const _PostOnboardingDestination({required this.ticker, required this.tickerSource, required this.shouldPromptNotifications, this.shouldPersistNotificationGrant = false});
  

@override final  String ticker;
@override final  OnboardingValueSource tickerSource;
@override final  bool shouldPromptNotifications;
@override@JsonKey() final  bool shouldPersistNotificationGrant;

/// Create a copy of PostOnboardingDestination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostOnboardingDestinationCopyWith<_PostOnboardingDestination> get copyWith => __$PostOnboardingDestinationCopyWithImpl<_PostOnboardingDestination>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostOnboardingDestination&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.tickerSource, tickerSource) || other.tickerSource == tickerSource)&&(identical(other.shouldPromptNotifications, shouldPromptNotifications) || other.shouldPromptNotifications == shouldPromptNotifications)&&(identical(other.shouldPersistNotificationGrant, shouldPersistNotificationGrant) || other.shouldPersistNotificationGrant == shouldPersistNotificationGrant));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticker,tickerSource,shouldPromptNotifications,shouldPersistNotificationGrant);
}

@override
String toString() {
    return 'PostOnboardingDestination(ticker: $ticker, tickerSource: $tickerSource, shouldPromptNotifications: $shouldPromptNotifications, shouldPersistNotificationGrant: $shouldPersistNotificationGrant)';
}


}

/// @nodoc
abstract mixin class _$PostOnboardingDestinationCopyWith<$Res> implements $PostOnboardingDestinationCopyWith<$Res> {
  factory _$PostOnboardingDestinationCopyWith(_PostOnboardingDestination value, $Res Function(_PostOnboardingDestination) _then) = __$PostOnboardingDestinationCopyWithImpl;
@override @useResult
$Res call({
 String ticker, OnboardingValueSource tickerSource, bool shouldPromptNotifications, bool shouldPersistNotificationGrant
});




}
/// @nodoc
class __$PostOnboardingDestinationCopyWithImpl<$Res>
    implements _$PostOnboardingDestinationCopyWith<$Res> {
  __$PostOnboardingDestinationCopyWithImpl(this._self, this._then);

  final _PostOnboardingDestination _self;
  final $Res Function(_PostOnboardingDestination) _then;

/// Create a copy of PostOnboardingDestination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? tickerSource = null,Object? shouldPromptNotifications = null,Object? shouldPersistNotificationGrant = null,}) {
  return _then(_PostOnboardingDestination(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,tickerSource: null == tickerSource ? _self.tickerSource : tickerSource // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,shouldPromptNotifications: null == shouldPromptNotifications ? _self.shouldPromptNotifications : shouldPromptNotifications // ignore: cast_nullable_to_non_nullable
as bool,shouldPersistNotificationGrant: null == shouldPersistNotificationGrant ? _self.shouldPersistNotificationGrant : shouldPersistNotificationGrant // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
