// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_security_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanySecurityEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanySecurityEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySecurityEvent()';
}


}

/// @nodoc
class $CompanySecurityEventCopyWith<$Res>  {
$CompanySecurityEventCopyWith(CompanySecurityEvent _, $Res Function(CompanySecurityEvent) __);
}


/// Adds pattern-matching-related methods to [CompanySecurityEvent].
extension CompanySecurityEventPatterns on CompanySecurityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadRequested value)?  loadRequested,TResult Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult Function( TabShown value)?  tabShown,TResult Function( TabHidden value)?  tabHidden,TResult Function( AppBackgrounded value)?  appBackgrounded,TResult Function( AppForegrounded value)?  appForegrounded,TResult Function( PriceAnalyticsUpdated value)?  priceAnalyticsUpdated,TResult Function( EarningsAnalyticsUpdated value)?  earningsAnalyticsUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case PriceAnalyticsUpdated() when priceAnalyticsUpdated != null:
return priceAnalyticsUpdated(_that);case EarningsAnalyticsUpdated() when earningsAnalyticsUpdated != null:
return earningsAnalyticsUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadRequested value)  loadRequested,required TResult Function( StalenessCheckRequested value)  stalenessCheckRequested,required TResult Function( TabShown value)  tabShown,required TResult Function( TabHidden value)  tabHidden,required TResult Function( AppBackgrounded value)  appBackgrounded,required TResult Function( AppForegrounded value)  appForegrounded,required TResult Function( PriceAnalyticsUpdated value)  priceAnalyticsUpdated,required TResult Function( EarningsAnalyticsUpdated value)  earningsAnalyticsUpdated,}){
final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that);case StalenessCheckRequested():
return stalenessCheckRequested(_that);case TabShown():
return tabShown(_that);case TabHidden():
return tabHidden(_that);case AppBackgrounded():
return appBackgrounded(_that);case AppForegrounded():
return appForegrounded(_that);case PriceAnalyticsUpdated():
return priceAnalyticsUpdated(_that);case EarningsAnalyticsUpdated():
return earningsAnalyticsUpdated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadRequested value)?  loadRequested,TResult? Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult? Function( TabShown value)?  tabShown,TResult? Function( TabHidden value)?  tabHidden,TResult? Function( AppBackgrounded value)?  appBackgrounded,TResult? Function( AppForegrounded value)?  appForegrounded,TResult? Function( PriceAnalyticsUpdated value)?  priceAnalyticsUpdated,TResult? Function( EarningsAnalyticsUpdated value)?  earningsAnalyticsUpdated,}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case PriceAnalyticsUpdated() when priceAnalyticsUpdated != null:
return priceAnalyticsUpdated(_that);case EarningsAnalyticsUpdated() when earningsAnalyticsUpdated != null:
return earningsAnalyticsUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  bool forceRefresh)?  loadRequested,TResult Function( String ticker)?  stalenessCheckRequested,TResult Function( String ticker)?  tabShown,TResult Function()?  tabHidden,TResult Function()?  appBackgrounded,TResult Function()?  appForegrounded,TResult Function( int? loadTimeMs,  bool? isSuccess,  String? finalTimeframe,  int? chartChangeCount)?  priceAnalyticsUpdated,TResult Function( bool? hasUpcoming,  String? daysAway)?  earningsAnalyticsUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case PriceAnalyticsUpdated() when priceAnalyticsUpdated != null:
return priceAnalyticsUpdated(_that.loadTimeMs,_that.isSuccess,_that.finalTimeframe,_that.chartChangeCount);case EarningsAnalyticsUpdated() when earningsAnalyticsUpdated != null:
return earningsAnalyticsUpdated(_that.hasUpcoming,_that.daysAway);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  bool forceRefresh)  loadRequested,required TResult Function( String ticker)  stalenessCheckRequested,required TResult Function( String ticker)  tabShown,required TResult Function()  tabHidden,required TResult Function()  appBackgrounded,required TResult Function()  appForegrounded,required TResult Function( int? loadTimeMs,  bool? isSuccess,  String? finalTimeframe,  int? chartChangeCount)  priceAnalyticsUpdated,required TResult Function( bool? hasUpcoming,  String? daysAway)  earningsAnalyticsUpdated,}) {final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested():
return stalenessCheckRequested(_that.ticker);case TabShown():
return tabShown(_that.ticker);case TabHidden():
return tabHidden();case AppBackgrounded():
return appBackgrounded();case AppForegrounded():
return appForegrounded();case PriceAnalyticsUpdated():
return priceAnalyticsUpdated(_that.loadTimeMs,_that.isSuccess,_that.finalTimeframe,_that.chartChangeCount);case EarningsAnalyticsUpdated():
return earningsAnalyticsUpdated(_that.hasUpcoming,_that.daysAway);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  bool forceRefresh)?  loadRequested,TResult? Function( String ticker)?  stalenessCheckRequested,TResult? Function( String ticker)?  tabShown,TResult? Function()?  tabHidden,TResult? Function()?  appBackgrounded,TResult? Function()?  appForegrounded,TResult? Function( int? loadTimeMs,  bool? isSuccess,  String? finalTimeframe,  int? chartChangeCount)?  priceAnalyticsUpdated,TResult? Function( bool? hasUpcoming,  String? daysAway)?  earningsAnalyticsUpdated,}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case PriceAnalyticsUpdated() when priceAnalyticsUpdated != null:
return priceAnalyticsUpdated(_that.loadTimeMs,_that.isSuccess,_that.finalTimeframe,_that.chartChangeCount);case EarningsAnalyticsUpdated() when earningsAnalyticsUpdated != null:
return earningsAnalyticsUpdated(_that.hasUpcoming,_that.daysAway);case _:
  return null;

}
}

}

/// @nodoc


class LoadRequested implements CompanySecurityEvent {
  const LoadRequested(this.ticker, {this.forceRefresh = false});
  

 final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadRequestedCopyWith<LoadRequested> get copyWith => _$LoadRequestedCopyWithImpl<LoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadRequested&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'CompanySecurityEvent.loadRequested(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadRequestedCopyWith<$Res> implements $CompanySecurityEventCopyWith<$Res> {
  factory $LoadRequestedCopyWith(LoadRequested value, $Res Function(LoadRequested) _then) = _$LoadRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$LoadRequestedCopyWithImpl<$Res>
    implements $LoadRequestedCopyWith<$Res> {
  _$LoadRequestedCopyWithImpl(this._self, this._then);

  final LoadRequested _self;
  final $Res Function(LoadRequested) _then;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StalenessCheckRequested implements CompanySecurityEvent {
  const StalenessCheckRequested(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StalenessCheckRequestedCopyWith<StalenessCheckRequested> get copyWith => _$StalenessCheckRequestedCopyWithImpl<StalenessCheckRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StalenessCheckRequested&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'CompanySecurityEvent.stalenessCheckRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $StalenessCheckRequestedCopyWith<$Res> implements $CompanySecurityEventCopyWith<$Res> {
  factory $StalenessCheckRequestedCopyWith(StalenessCheckRequested value, $Res Function(StalenessCheckRequested) _then) = _$StalenessCheckRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$StalenessCheckRequestedCopyWithImpl<$Res>
    implements $StalenessCheckRequestedCopyWith<$Res> {
  _$StalenessCheckRequestedCopyWithImpl(this._self, this._then);

  final StalenessCheckRequested _self;
  final $Res Function(StalenessCheckRequested) _then;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(StalenessCheckRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabShown implements CompanySecurityEvent {
  const TabShown(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabShownCopyWith<TabShown> get copyWith => _$TabShownCopyWithImpl<TabShown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabShown&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'CompanySecurityEvent.tabShown(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $TabShownCopyWith<$Res> implements $CompanySecurityEventCopyWith<$Res> {
  factory $TabShownCopyWith(TabShown value, $Res Function(TabShown) _then) = _$TabShownCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$TabShownCopyWithImpl<$Res>
    implements $TabShownCopyWith<$Res> {
  _$TabShownCopyWithImpl(this._self, this._then);

  final TabShown _self;
  final $Res Function(TabShown) _then;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(TabShown(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabHidden implements CompanySecurityEvent {
  const TabHidden();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabHidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySecurityEvent.tabHidden()';
}


}




/// @nodoc


class AppBackgrounded implements CompanySecurityEvent {
  const AppBackgrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBackgrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySecurityEvent.appBackgrounded()';
}


}




/// @nodoc


class AppForegrounded implements CompanySecurityEvent {
  const AppForegrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppForegrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySecurityEvent.appForegrounded()';
}


}




/// @nodoc


class PriceAnalyticsUpdated implements CompanySecurityEvent {
  const PriceAnalyticsUpdated({this.loadTimeMs, this.isSuccess, this.finalTimeframe, this.chartChangeCount});
  

 final  int? loadTimeMs;
 final  bool? isSuccess;
 final  String? finalTimeframe;
 final  int? chartChangeCount;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceAnalyticsUpdatedCopyWith<PriceAnalyticsUpdated> get copyWith => _$PriceAnalyticsUpdatedCopyWithImpl<PriceAnalyticsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceAnalyticsUpdated&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.finalTimeframe, finalTimeframe) || other.finalTimeframe == finalTimeframe)&&(identical(other.chartChangeCount, chartChangeCount) || other.chartChangeCount == chartChangeCount));
}


@override
int get hashCode => Object.hash(runtimeType,loadTimeMs,isSuccess,finalTimeframe,chartChangeCount);

@override
String toString() {
  return 'CompanySecurityEvent.priceAnalyticsUpdated(loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, finalTimeframe: $finalTimeframe, chartChangeCount: $chartChangeCount)';
}


}

/// @nodoc
abstract mixin class $PriceAnalyticsUpdatedCopyWith<$Res> implements $CompanySecurityEventCopyWith<$Res> {
  factory $PriceAnalyticsUpdatedCopyWith(PriceAnalyticsUpdated value, $Res Function(PriceAnalyticsUpdated) _then) = _$PriceAnalyticsUpdatedCopyWithImpl;
@useResult
$Res call({
 int? loadTimeMs, bool? isSuccess, String? finalTimeframe, int? chartChangeCount
});




}
/// @nodoc
class _$PriceAnalyticsUpdatedCopyWithImpl<$Res>
    implements $PriceAnalyticsUpdatedCopyWith<$Res> {
  _$PriceAnalyticsUpdatedCopyWithImpl(this._self, this._then);

  final PriceAnalyticsUpdated _self;
  final $Res Function(PriceAnalyticsUpdated) _then;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loadTimeMs = freezed,Object? isSuccess = freezed,Object? finalTimeframe = freezed,Object? chartChangeCount = freezed,}) {
  return _then(PriceAnalyticsUpdated(
loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: freezed == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool?,finalTimeframe: freezed == finalTimeframe ? _self.finalTimeframe : finalTimeframe // ignore: cast_nullable_to_non_nullable
as String?,chartChangeCount: freezed == chartChangeCount ? _self.chartChangeCount : chartChangeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class EarningsAnalyticsUpdated implements CompanySecurityEvent {
  const EarningsAnalyticsUpdated({this.hasUpcoming, this.daysAway});
  

 final  bool? hasUpcoming;
 final  String? daysAway;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsAnalyticsUpdatedCopyWith<EarningsAnalyticsUpdated> get copyWith => _$EarningsAnalyticsUpdatedCopyWithImpl<EarningsAnalyticsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningsAnalyticsUpdated&&(identical(other.hasUpcoming, hasUpcoming) || other.hasUpcoming == hasUpcoming)&&(identical(other.daysAway, daysAway) || other.daysAway == daysAway));
}


@override
int get hashCode => Object.hash(runtimeType,hasUpcoming,daysAway);

@override
String toString() {
  return 'CompanySecurityEvent.earningsAnalyticsUpdated(hasUpcoming: $hasUpcoming, daysAway: $daysAway)';
}


}

/// @nodoc
abstract mixin class $EarningsAnalyticsUpdatedCopyWith<$Res> implements $CompanySecurityEventCopyWith<$Res> {
  factory $EarningsAnalyticsUpdatedCopyWith(EarningsAnalyticsUpdated value, $Res Function(EarningsAnalyticsUpdated) _then) = _$EarningsAnalyticsUpdatedCopyWithImpl;
@useResult
$Res call({
 bool? hasUpcoming, String? daysAway
});




}
/// @nodoc
class _$EarningsAnalyticsUpdatedCopyWithImpl<$Res>
    implements $EarningsAnalyticsUpdatedCopyWith<$Res> {
  _$EarningsAnalyticsUpdatedCopyWithImpl(this._self, this._then);

  final EarningsAnalyticsUpdated _self;
  final $Res Function(EarningsAnalyticsUpdated) _then;

/// Create a copy of CompanySecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hasUpcoming = freezed,Object? daysAway = freezed,}) {
  return _then(EarningsAnalyticsUpdated(
hasUpcoming: freezed == hasUpcoming ? _self.hasUpcoming : hasUpcoming // ignore: cast_nullable_to_non_nullable
as bool?,daysAway: freezed == daysAway ? _self.daysAway : daysAway // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
