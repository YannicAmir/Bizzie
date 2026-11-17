// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_ratings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppRatingsEvent {

 CompanyProfile get company; String get currentTab;
/// Create a copy of AppRatingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppRatingsEventCopyWith<AppRatingsEvent> get copyWith => _$AppRatingsEventCopyWithImpl<AppRatingsEvent>(this as AppRatingsEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppRatingsEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRatingsEvent&&(identical(other.company, _this.company) || other.company == _this.company)&&(identical(other.currentTab, _this.currentTab) || other.currentTab == _this.currentTab));
}


@override
int get hashCode {
  final _this = this as AppRatingsEvent;
  return Object.hash(runtimeType,_this.company,_this.currentTab);
}

@override
String toString() {
  final _this = this as AppRatingsEvent;
  return 'AppRatingsEvent(company: ${_this.company}, currentTab: ${_this.currentTab})';
}


}

/// @nodoc
abstract mixin class $AppRatingsEventCopyWith<$Res>  {
  factory $AppRatingsEventCopyWith(AppRatingsEvent value, $Res Function(AppRatingsEvent) _then) = _$AppRatingsEventCopyWithImpl;
@useResult
$Res call({
 CompanyProfile company, String currentTab
});


$CompanyProfileCopyWith<$Res> get company;

}
/// @nodoc
class _$AppRatingsEventCopyWithImpl<$Res>
    implements $AppRatingsEventCopyWith<$Res> {
  _$AppRatingsEventCopyWithImpl(this._self, this._then);

  final AppRatingsEvent _self;
  final $Res Function(AppRatingsEvent) _then;

/// Create a copy of AppRatingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? company = null,Object? currentTab = null,}) {
  return _then(AppRatingsEvent.interactionDetected(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as CompanyProfile,currentTab: null == currentTab ? _self.currentTab : currentTab // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AppRatingsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyProfileCopyWith<$Res> get company {
  
  return $CompanyProfileCopyWith<$Res>(_self.company, (value) {
    return _then(_self.copyWith(company: value));
  });
}
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppRatingsInteractionDetected value)?  interactionDetected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppRatingsInteractionDetected() when interactionDetected != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppRatingsInteractionDetected value)  interactionDetected,}){
final _that = this;
switch (_that) {
case AppRatingsInteractionDetected():
return interactionDetected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppRatingsInteractionDetected value)?  interactionDetected,}){
final _that = this;
switch (_that) {
case AppRatingsInteractionDetected() when interactionDetected != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CompanyProfile company,  String currentTab)?  interactionDetected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppRatingsInteractionDetected() when interactionDetected != null:
return interactionDetected(_that.company,_that.currentTab);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CompanyProfile company,  String currentTab)  interactionDetected,}) {final _that = this;
switch (_that) {
case AppRatingsInteractionDetected():
return interactionDetected(_that.company,_that.currentTab);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CompanyProfile company,  String currentTab)?  interactionDetected,}) {final _that = this;
switch (_that) {
case AppRatingsInteractionDetected() when interactionDetected != null:
return interactionDetected(_that.company,_that.currentTab);case _:
  return null;

}
}

}

/// @nodoc


class AppRatingsInteractionDetected implements AppRatingsEvent {
  const AppRatingsInteractionDetected({required this.company, required this.currentTab});
  

@override final  CompanyProfile company;
@override final  String currentTab;

/// Create a copy of AppRatingsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppRatingsInteractionDetectedCopyWith<AppRatingsInteractionDetected> get copyWith => _$AppRatingsInteractionDetectedCopyWithImpl<AppRatingsInteractionDetected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRatingsInteractionDetected&&(identical(other.company, company) || other.company == company)&&(identical(other.currentTab, currentTab) || other.currentTab == currentTab));
}


@override
int get hashCode {
    return Object.hash(runtimeType,company,currentTab);
}

@override
String toString() {
    return 'AppRatingsEvent.interactionDetected(company: $company, currentTab: $currentTab)';
}


}

/// @nodoc
abstract mixin class $AppRatingsInteractionDetectedCopyWith<$Res> implements $AppRatingsEventCopyWith<$Res> {
  factory $AppRatingsInteractionDetectedCopyWith(AppRatingsInteractionDetected value, $Res Function(AppRatingsInteractionDetected) _then) = _$AppRatingsInteractionDetectedCopyWithImpl;
@override @useResult
$Res call({
 CompanyProfile company, String currentTab
});


@override $CompanyProfileCopyWith<$Res> get company;

}
/// @nodoc
class _$AppRatingsInteractionDetectedCopyWithImpl<$Res>
    implements $AppRatingsInteractionDetectedCopyWith<$Res> {
  _$AppRatingsInteractionDetectedCopyWithImpl(this._self, this._then);

  final AppRatingsInteractionDetected _self;
  final $Res Function(AppRatingsInteractionDetected) _then;

/// Create a copy of AppRatingsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? company = null,Object? currentTab = null,}) {
  return _then(AppRatingsInteractionDetected(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as CompanyProfile,currentTab: null == currentTab ? _self.currentTab : currentTab // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AppRatingsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyProfileCopyWith<$Res> get company {
  
  return $CompanyProfileCopyWith<$Res>(_self.company, (value) {
    return _then(_self.copyWith(company: value));
  });
}
}

// dart format on
