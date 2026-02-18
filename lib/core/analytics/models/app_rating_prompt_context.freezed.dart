// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_rating_prompt_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppRatingPromptContext {

// Company Information
 String get ticker; String get companyName; String get sector; String get industry;// User Profile
 String get experienceLevel; String get favoriteSector; bool get isPremium; int get watchlistCount;// Engagement & Status
 bool get notificationsEnabled; int get interactionCount; int get promptAttempts; String get currentTab; int get thresholdCount;
/// Create a copy of AppRatingPromptContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppRatingPromptContextCopyWith<AppRatingPromptContext> get copyWith => _$AppRatingPromptContextCopyWithImpl<AppRatingPromptContext>(this as AppRatingPromptContext, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRatingPromptContext&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.watchlistCount, watchlistCount) || other.watchlistCount == watchlistCount)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.interactionCount, interactionCount) || other.interactionCount == interactionCount)&&(identical(other.promptAttempts, promptAttempts) || other.promptAttempts == promptAttempts)&&(identical(other.currentTab, currentTab) || other.currentTab == currentTab)&&(identical(other.thresholdCount, thresholdCount) || other.thresholdCount == thresholdCount));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,sector,industry,experienceLevel,favoriteSector,isPremium,watchlistCount,notificationsEnabled,interactionCount,promptAttempts,currentTab,thresholdCount);

@override
String toString() {
  return 'AppRatingPromptContext(ticker: $ticker, companyName: $companyName, sector: $sector, industry: $industry, experienceLevel: $experienceLevel, favoriteSector: $favoriteSector, isPremium: $isPremium, watchlistCount: $watchlistCount, notificationsEnabled: $notificationsEnabled, interactionCount: $interactionCount, promptAttempts: $promptAttempts, currentTab: $currentTab, thresholdCount: $thresholdCount)';
}


}

/// @nodoc
abstract mixin class $AppRatingPromptContextCopyWith<$Res>  {
  factory $AppRatingPromptContextCopyWith(AppRatingPromptContext value, $Res Function(AppRatingPromptContext) _then) = _$AppRatingPromptContextCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName, String sector, String industry, String experienceLevel, String favoriteSector, bool isPremium, int watchlistCount, bool notificationsEnabled, int interactionCount, int promptAttempts, String currentTab, int thresholdCount
});




}
/// @nodoc
class _$AppRatingPromptContextCopyWithImpl<$Res>
    implements $AppRatingPromptContextCopyWith<$Res> {
  _$AppRatingPromptContextCopyWithImpl(this._self, this._then);

  final AppRatingPromptContext _self;
  final $Res Function(AppRatingPromptContext) _then;

/// Create a copy of AppRatingPromptContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? companyName = null,Object? sector = null,Object? industry = null,Object? experienceLevel = null,Object? favoriteSector = null,Object? isPremium = null,Object? watchlistCount = null,Object? notificationsEnabled = null,Object? interactionCount = null,Object? promptAttempts = null,Object? currentTab = null,Object? thresholdCount = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String,favoriteSector: null == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,watchlistCount: null == watchlistCount ? _self.watchlistCount : watchlistCount // ignore: cast_nullable_to_non_nullable
as int,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,interactionCount: null == interactionCount ? _self.interactionCount : interactionCount // ignore: cast_nullable_to_non_nullable
as int,promptAttempts: null == promptAttempts ? _self.promptAttempts : promptAttempts // ignore: cast_nullable_to_non_nullable
as int,currentTab: null == currentTab ? _self.currentTab : currentTab // ignore: cast_nullable_to_non_nullable
as String,thresholdCount: null == thresholdCount ? _self.thresholdCount : thresholdCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppRatingPromptContext].
extension AppRatingPromptContextPatterns on AppRatingPromptContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppRatingPromptContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppRatingPromptContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppRatingPromptContext value)  $default,){
final _that = this;
switch (_that) {
case _AppRatingPromptContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppRatingPromptContext value)?  $default,){
final _that = this;
switch (_that) {
case _AppRatingPromptContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String companyName,  String sector,  String industry,  String experienceLevel,  String favoriteSector,  bool isPremium,  int watchlistCount,  bool notificationsEnabled,  int interactionCount,  int promptAttempts,  String currentTab,  int thresholdCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppRatingPromptContext() when $default != null:
return $default(_that.ticker,_that.companyName,_that.sector,_that.industry,_that.experienceLevel,_that.favoriteSector,_that.isPremium,_that.watchlistCount,_that.notificationsEnabled,_that.interactionCount,_that.promptAttempts,_that.currentTab,_that.thresholdCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String companyName,  String sector,  String industry,  String experienceLevel,  String favoriteSector,  bool isPremium,  int watchlistCount,  bool notificationsEnabled,  int interactionCount,  int promptAttempts,  String currentTab,  int thresholdCount)  $default,) {final _that = this;
switch (_that) {
case _AppRatingPromptContext():
return $default(_that.ticker,_that.companyName,_that.sector,_that.industry,_that.experienceLevel,_that.favoriteSector,_that.isPremium,_that.watchlistCount,_that.notificationsEnabled,_that.interactionCount,_that.promptAttempts,_that.currentTab,_that.thresholdCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String companyName,  String sector,  String industry,  String experienceLevel,  String favoriteSector,  bool isPremium,  int watchlistCount,  bool notificationsEnabled,  int interactionCount,  int promptAttempts,  String currentTab,  int thresholdCount)?  $default,) {final _that = this;
switch (_that) {
case _AppRatingPromptContext() when $default != null:
return $default(_that.ticker,_that.companyName,_that.sector,_that.industry,_that.experienceLevel,_that.favoriteSector,_that.isPremium,_that.watchlistCount,_that.notificationsEnabled,_that.interactionCount,_that.promptAttempts,_that.currentTab,_that.thresholdCount);case _:
  return null;

}
}

}

/// @nodoc


class _AppRatingPromptContext extends AppRatingPromptContext {
  const _AppRatingPromptContext({required this.ticker, required this.companyName, required this.sector, required this.industry, required this.experienceLevel, required this.favoriteSector, required this.isPremium, required this.watchlistCount, required this.notificationsEnabled, required this.interactionCount, required this.promptAttempts, required this.currentTab, required this.thresholdCount}): super._();
  

// Company Information
@override final  String ticker;
@override final  String companyName;
@override final  String sector;
@override final  String industry;
// User Profile
@override final  String experienceLevel;
@override final  String favoriteSector;
@override final  bool isPremium;
@override final  int watchlistCount;
// Engagement & Status
@override final  bool notificationsEnabled;
@override final  int interactionCount;
@override final  int promptAttempts;
@override final  String currentTab;
@override final  int thresholdCount;

/// Create a copy of AppRatingPromptContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppRatingPromptContextCopyWith<_AppRatingPromptContext> get copyWith => __$AppRatingPromptContextCopyWithImpl<_AppRatingPromptContext>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppRatingPromptContext&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.watchlistCount, watchlistCount) || other.watchlistCount == watchlistCount)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.interactionCount, interactionCount) || other.interactionCount == interactionCount)&&(identical(other.promptAttempts, promptAttempts) || other.promptAttempts == promptAttempts)&&(identical(other.currentTab, currentTab) || other.currentTab == currentTab)&&(identical(other.thresholdCount, thresholdCount) || other.thresholdCount == thresholdCount));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,sector,industry,experienceLevel,favoriteSector,isPremium,watchlistCount,notificationsEnabled,interactionCount,promptAttempts,currentTab,thresholdCount);

@override
String toString() {
  return 'AppRatingPromptContext(ticker: $ticker, companyName: $companyName, sector: $sector, industry: $industry, experienceLevel: $experienceLevel, favoriteSector: $favoriteSector, isPremium: $isPremium, watchlistCount: $watchlistCount, notificationsEnabled: $notificationsEnabled, interactionCount: $interactionCount, promptAttempts: $promptAttempts, currentTab: $currentTab, thresholdCount: $thresholdCount)';
}


}

/// @nodoc
abstract mixin class _$AppRatingPromptContextCopyWith<$Res> implements $AppRatingPromptContextCopyWith<$Res> {
  factory _$AppRatingPromptContextCopyWith(_AppRatingPromptContext value, $Res Function(_AppRatingPromptContext) _then) = __$AppRatingPromptContextCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String companyName, String sector, String industry, String experienceLevel, String favoriteSector, bool isPremium, int watchlistCount, bool notificationsEnabled, int interactionCount, int promptAttempts, String currentTab, int thresholdCount
});




}
/// @nodoc
class __$AppRatingPromptContextCopyWithImpl<$Res>
    implements _$AppRatingPromptContextCopyWith<$Res> {
  __$AppRatingPromptContextCopyWithImpl(this._self, this._then);

  final _AppRatingPromptContext _self;
  final $Res Function(_AppRatingPromptContext) _then;

/// Create a copy of AppRatingPromptContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? sector = null,Object? industry = null,Object? experienceLevel = null,Object? favoriteSector = null,Object? isPremium = null,Object? watchlistCount = null,Object? notificationsEnabled = null,Object? interactionCount = null,Object? promptAttempts = null,Object? currentTab = null,Object? thresholdCount = null,}) {
  return _then(_AppRatingPromptContext(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String,favoriteSector: null == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,watchlistCount: null == watchlistCount ? _self.watchlistCount : watchlistCount // ignore: cast_nullable_to_non_nullable
as int,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,interactionCount: null == interactionCount ? _self.interactionCount : interactionCount // ignore: cast_nullable_to_non_nullable
as int,promptAttempts: null == promptAttempts ? _self.promptAttempts : promptAttempts // ignore: cast_nullable_to_non_nullable
as int,currentTab: null == currentTab ? _self.currentTab : currentTab // ignore: cast_nullable_to_non_nullable
as String,thresholdCount: null == thresholdCount ? _self.thresholdCount : thresholdCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
