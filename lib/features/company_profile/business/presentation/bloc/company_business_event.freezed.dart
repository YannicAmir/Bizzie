// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_business_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyBusinessEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyBusinessEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBusinessEvent()';
}


}

/// @nodoc
class $CompanyBusinessEventCopyWith<$Res>  {
$CompanyBusinessEventCopyWith(CompanyBusinessEvent _, $Res Function(CompanyBusinessEvent) __);
}


/// Adds pattern-matching-related methods to [CompanyBusinessEvent].
extension CompanyBusinessEventPatterns on CompanyBusinessEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadRequested value)?  loadRequested,TResult Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult Function( TabShown value)?  tabShown,TResult Function( TabHidden value)?  tabHidden,TResult Function( AppBackgrounded value)?  appBackgrounded,TResult Function( AppForegrounded value)?  appForegrounded,TResult Function( AnalyticsInteractionOccurred value)?  analyticsInteractionOccurred,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case AnalyticsInteractionOccurred() when analyticsInteractionOccurred != null:
return analyticsInteractionOccurred(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadRequested value)  loadRequested,required TResult Function( StalenessCheckRequested value)  stalenessCheckRequested,required TResult Function( TabShown value)  tabShown,required TResult Function( TabHidden value)  tabHidden,required TResult Function( AppBackgrounded value)  appBackgrounded,required TResult Function( AppForegrounded value)  appForegrounded,required TResult Function( AnalyticsInteractionOccurred value)  analyticsInteractionOccurred,}){
final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that);case StalenessCheckRequested():
return stalenessCheckRequested(_that);case TabShown():
return tabShown(_that);case TabHidden():
return tabHidden(_that);case AppBackgrounded():
return appBackgrounded(_that);case AppForegrounded():
return appForegrounded(_that);case AnalyticsInteractionOccurred():
return analyticsInteractionOccurred(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadRequested value)?  loadRequested,TResult? Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult? Function( TabShown value)?  tabShown,TResult? Function( TabHidden value)?  tabHidden,TResult? Function( AppBackgrounded value)?  appBackgrounded,TResult? Function( AppForegrounded value)?  appForegrounded,TResult? Function( AnalyticsInteractionOccurred value)?  analyticsInteractionOccurred,}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case AnalyticsInteractionOccurred() when analyticsInteractionOccurred != null:
return analyticsInteractionOccurred(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  bool forceRefresh)?  loadRequested,TResult Function( String ticker)?  stalenessCheckRequested,TResult Function( String ticker)?  tabShown,TResult Function()?  tabHidden,TResult Function()?  appBackgrounded,TResult Function()?  appForegrounded,TResult Function( bool? tappedWebsite,  bool? tappedProxy,  bool? didExpandDescription,  bool? viewed10Ks,  bool? viewed10Qs,  bool? viewAll10KsTapped,  bool? viewAll10QsTapped)?  analyticsInteractionOccurred,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case AnalyticsInteractionOccurred() when analyticsInteractionOccurred != null:
return analyticsInteractionOccurred(_that.tappedWebsite,_that.tappedProxy,_that.didExpandDescription,_that.viewed10Ks,_that.viewed10Qs,_that.viewAll10KsTapped,_that.viewAll10QsTapped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  bool forceRefresh)  loadRequested,required TResult Function( String ticker)  stalenessCheckRequested,required TResult Function( String ticker)  tabShown,required TResult Function()  tabHidden,required TResult Function()  appBackgrounded,required TResult Function()  appForegrounded,required TResult Function( bool? tappedWebsite,  bool? tappedProxy,  bool? didExpandDescription,  bool? viewed10Ks,  bool? viewed10Qs,  bool? viewAll10KsTapped,  bool? viewAll10QsTapped)  analyticsInteractionOccurred,}) {final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested():
return stalenessCheckRequested(_that.ticker);case TabShown():
return tabShown(_that.ticker);case TabHidden():
return tabHidden();case AppBackgrounded():
return appBackgrounded();case AppForegrounded():
return appForegrounded();case AnalyticsInteractionOccurred():
return analyticsInteractionOccurred(_that.tappedWebsite,_that.tappedProxy,_that.didExpandDescription,_that.viewed10Ks,_that.viewed10Qs,_that.viewAll10KsTapped,_that.viewAll10QsTapped);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  bool forceRefresh)?  loadRequested,TResult? Function( String ticker)?  stalenessCheckRequested,TResult? Function( String ticker)?  tabShown,TResult? Function()?  tabHidden,TResult? Function()?  appBackgrounded,TResult? Function()?  appForegrounded,TResult? Function( bool? tappedWebsite,  bool? tappedProxy,  bool? didExpandDescription,  bool? viewed10Ks,  bool? viewed10Qs,  bool? viewAll10KsTapped,  bool? viewAll10QsTapped)?  analyticsInteractionOccurred,}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case AnalyticsInteractionOccurred() when analyticsInteractionOccurred != null:
return analyticsInteractionOccurred(_that.tappedWebsite,_that.tappedProxy,_that.didExpandDescription,_that.viewed10Ks,_that.viewed10Qs,_that.viewAll10KsTapped,_that.viewAll10QsTapped);case _:
  return null;

}
}

}

/// @nodoc


class LoadRequested implements CompanyBusinessEvent {
  const LoadRequested(this.ticker, {this.forceRefresh = false});
  

 final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of CompanyBusinessEvent
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
  return 'CompanyBusinessEvent.loadRequested(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadRequestedCopyWith<$Res> implements $CompanyBusinessEventCopyWith<$Res> {
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

/// Create a copy of CompanyBusinessEvent
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


class StalenessCheckRequested implements CompanyBusinessEvent {
  const StalenessCheckRequested(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyBusinessEvent
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
  return 'CompanyBusinessEvent.stalenessCheckRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $StalenessCheckRequestedCopyWith<$Res> implements $CompanyBusinessEventCopyWith<$Res> {
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

/// Create a copy of CompanyBusinessEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(StalenessCheckRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabShown implements CompanyBusinessEvent {
  const TabShown(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyBusinessEvent
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
  return 'CompanyBusinessEvent.tabShown(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $TabShownCopyWith<$Res> implements $CompanyBusinessEventCopyWith<$Res> {
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

/// Create a copy of CompanyBusinessEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(TabShown(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabHidden implements CompanyBusinessEvent {
  const TabHidden();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabHidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBusinessEvent.tabHidden()';
}


}




/// @nodoc


class AppBackgrounded implements CompanyBusinessEvent {
  const AppBackgrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBackgrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBusinessEvent.appBackgrounded()';
}


}




/// @nodoc


class AppForegrounded implements CompanyBusinessEvent {
  const AppForegrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppForegrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBusinessEvent.appForegrounded()';
}


}




/// @nodoc


class AnalyticsInteractionOccurred implements CompanyBusinessEvent {
  const AnalyticsInteractionOccurred({this.tappedWebsite, this.tappedProxy, this.didExpandDescription, this.viewed10Ks, this.viewed10Qs, this.viewAll10KsTapped, this.viewAll10QsTapped});
  

 final  bool? tappedWebsite;
 final  bool? tappedProxy;
 final  bool? didExpandDescription;
 final  bool? viewed10Ks;
 final  bool? viewed10Qs;
 final  bool? viewAll10KsTapped;
 final  bool? viewAll10QsTapped;

/// Create a copy of CompanyBusinessEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyticsInteractionOccurredCopyWith<AnalyticsInteractionOccurred> get copyWith => _$AnalyticsInteractionOccurredCopyWithImpl<AnalyticsInteractionOccurred>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyticsInteractionOccurred&&(identical(other.tappedWebsite, tappedWebsite) || other.tappedWebsite == tappedWebsite)&&(identical(other.tappedProxy, tappedProxy) || other.tappedProxy == tappedProxy)&&(identical(other.didExpandDescription, didExpandDescription) || other.didExpandDescription == didExpandDescription)&&(identical(other.viewed10Ks, viewed10Ks) || other.viewed10Ks == viewed10Ks)&&(identical(other.viewed10Qs, viewed10Qs) || other.viewed10Qs == viewed10Qs)&&(identical(other.viewAll10KsTapped, viewAll10KsTapped) || other.viewAll10KsTapped == viewAll10KsTapped)&&(identical(other.viewAll10QsTapped, viewAll10QsTapped) || other.viewAll10QsTapped == viewAll10QsTapped));
}


@override
int get hashCode => Object.hash(runtimeType,tappedWebsite,tappedProxy,didExpandDescription,viewed10Ks,viewed10Qs,viewAll10KsTapped,viewAll10QsTapped);

@override
String toString() {
  return 'CompanyBusinessEvent.analyticsInteractionOccurred(tappedWebsite: $tappedWebsite, tappedProxy: $tappedProxy, didExpandDescription: $didExpandDescription, viewed10Ks: $viewed10Ks, viewed10Qs: $viewed10Qs, viewAll10KsTapped: $viewAll10KsTapped, viewAll10QsTapped: $viewAll10QsTapped)';
}


}

/// @nodoc
abstract mixin class $AnalyticsInteractionOccurredCopyWith<$Res> implements $CompanyBusinessEventCopyWith<$Res> {
  factory $AnalyticsInteractionOccurredCopyWith(AnalyticsInteractionOccurred value, $Res Function(AnalyticsInteractionOccurred) _then) = _$AnalyticsInteractionOccurredCopyWithImpl;
@useResult
$Res call({
 bool? tappedWebsite, bool? tappedProxy, bool? didExpandDescription, bool? viewed10Ks, bool? viewed10Qs, bool? viewAll10KsTapped, bool? viewAll10QsTapped
});




}
/// @nodoc
class _$AnalyticsInteractionOccurredCopyWithImpl<$Res>
    implements $AnalyticsInteractionOccurredCopyWith<$Res> {
  _$AnalyticsInteractionOccurredCopyWithImpl(this._self, this._then);

  final AnalyticsInteractionOccurred _self;
  final $Res Function(AnalyticsInteractionOccurred) _then;

/// Create a copy of CompanyBusinessEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tappedWebsite = freezed,Object? tappedProxy = freezed,Object? didExpandDescription = freezed,Object? viewed10Ks = freezed,Object? viewed10Qs = freezed,Object? viewAll10KsTapped = freezed,Object? viewAll10QsTapped = freezed,}) {
  return _then(AnalyticsInteractionOccurred(
tappedWebsite: freezed == tappedWebsite ? _self.tappedWebsite : tappedWebsite // ignore: cast_nullable_to_non_nullable
as bool?,tappedProxy: freezed == tappedProxy ? _self.tappedProxy : tappedProxy // ignore: cast_nullable_to_non_nullable
as bool?,didExpandDescription: freezed == didExpandDescription ? _self.didExpandDescription : didExpandDescription // ignore: cast_nullable_to_non_nullable
as bool?,viewed10Ks: freezed == viewed10Ks ? _self.viewed10Ks : viewed10Ks // ignore: cast_nullable_to_non_nullable
as bool?,viewed10Qs: freezed == viewed10Qs ? _self.viewed10Qs : viewed10Qs // ignore: cast_nullable_to_non_nullable
as bool?,viewAll10KsTapped: freezed == viewAll10KsTapped ? _self.viewAll10KsTapped : viewAll10KsTapped // ignore: cast_nullable_to_non_nullable
as bool?,viewAll10QsTapped: freezed == viewAll10QsTapped ? _self.viewAll10QsTapped : viewAll10QsTapped // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
