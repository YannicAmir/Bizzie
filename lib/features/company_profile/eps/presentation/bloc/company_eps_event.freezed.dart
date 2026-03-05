// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_eps_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyEpsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyEpsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyEpsEvent()';
}


}

/// @nodoc
class $CompanyEpsEventCopyWith<$Res>  {
$CompanyEpsEventCopyWith(CompanyEpsEvent _, $Res Function(CompanyEpsEvent) __);
}


/// Adds pattern-matching-related methods to [CompanyEpsEvent].
extension CompanyEpsEventPatterns on CompanyEpsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadRequested value)?  loadRequested,TResult Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult Function( TabShown value)?  tabShown,TResult Function( TabHidden value)?  tabHidden,TResult Function( AppBackgrounded value)?  appBackgrounded,TResult Function( AppForegrounded value)?  appForegrounded,TResult Function( PeriodViewed value)?  periodViewed,TResult Function( ViewAllTapped value)?  viewAllTapped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case PeriodViewed() when periodViewed != null:
return periodViewed(_that);case ViewAllTapped() when viewAllTapped != null:
return viewAllTapped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadRequested value)  loadRequested,required TResult Function( StalenessCheckRequested value)  stalenessCheckRequested,required TResult Function( TabShown value)  tabShown,required TResult Function( TabHidden value)  tabHidden,required TResult Function( AppBackgrounded value)  appBackgrounded,required TResult Function( AppForegrounded value)  appForegrounded,required TResult Function( PeriodViewed value)  periodViewed,required TResult Function( ViewAllTapped value)  viewAllTapped,}){
final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that);case StalenessCheckRequested():
return stalenessCheckRequested(_that);case TabShown():
return tabShown(_that);case TabHidden():
return tabHidden(_that);case AppBackgrounded():
return appBackgrounded(_that);case AppForegrounded():
return appForegrounded(_that);case PeriodViewed():
return periodViewed(_that);case ViewAllTapped():
return viewAllTapped(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadRequested value)?  loadRequested,TResult? Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult? Function( TabShown value)?  tabShown,TResult? Function( TabHidden value)?  tabHidden,TResult? Function( AppBackgrounded value)?  appBackgrounded,TResult? Function( AppForegrounded value)?  appForegrounded,TResult? Function( PeriodViewed value)?  periodViewed,TResult? Function( ViewAllTapped value)?  viewAllTapped,}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case PeriodViewed() when periodViewed != null:
return periodViewed(_that);case ViewAllTapped() when viewAllTapped != null:
return viewAllTapped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  bool forceRefresh)?  loadRequested,TResult Function( String ticker)?  stalenessCheckRequested,TResult Function( String ticker)?  tabShown,TResult Function()?  tabHidden,TResult Function()?  appBackgrounded,TResult Function()?  appForegrounded,TResult Function( bool isAnnual)?  periodViewed,TResult Function( bool isAnnual,  bool isChart)?  viewAllTapped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case PeriodViewed() when periodViewed != null:
return periodViewed(_that.isAnnual);case ViewAllTapped() when viewAllTapped != null:
return viewAllTapped(_that.isAnnual,_that.isChart);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  bool forceRefresh)  loadRequested,required TResult Function( String ticker)  stalenessCheckRequested,required TResult Function( String ticker)  tabShown,required TResult Function()  tabHidden,required TResult Function()  appBackgrounded,required TResult Function()  appForegrounded,required TResult Function( bool isAnnual)  periodViewed,required TResult Function( bool isAnnual,  bool isChart)  viewAllTapped,}) {final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested():
return stalenessCheckRequested(_that.ticker);case TabShown():
return tabShown(_that.ticker);case TabHidden():
return tabHidden();case AppBackgrounded():
return appBackgrounded();case AppForegrounded():
return appForegrounded();case PeriodViewed():
return periodViewed(_that.isAnnual);case ViewAllTapped():
return viewAllTapped(_that.isAnnual,_that.isChart);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  bool forceRefresh)?  loadRequested,TResult? Function( String ticker)?  stalenessCheckRequested,TResult? Function( String ticker)?  tabShown,TResult? Function()?  tabHidden,TResult? Function()?  appBackgrounded,TResult? Function()?  appForegrounded,TResult? Function( bool isAnnual)?  periodViewed,TResult? Function( bool isAnnual,  bool isChart)?  viewAllTapped,}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case PeriodViewed() when periodViewed != null:
return periodViewed(_that.isAnnual);case ViewAllTapped() when viewAllTapped != null:
return viewAllTapped(_that.isAnnual,_that.isChart);case _:
  return null;

}
}

}

/// @nodoc


class LoadRequested implements CompanyEpsEvent {
  const LoadRequested(this.ticker, {this.forceRefresh = false});
  

 final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of CompanyEpsEvent
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
  return 'CompanyEpsEvent.loadRequested(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadRequestedCopyWith<$Res> implements $CompanyEpsEventCopyWith<$Res> {
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

/// Create a copy of CompanyEpsEvent
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


class StalenessCheckRequested implements CompanyEpsEvent {
  const StalenessCheckRequested(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyEpsEvent
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
  return 'CompanyEpsEvent.stalenessCheckRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $StalenessCheckRequestedCopyWith<$Res> implements $CompanyEpsEventCopyWith<$Res> {
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

/// Create a copy of CompanyEpsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(StalenessCheckRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabShown implements CompanyEpsEvent {
  const TabShown(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyEpsEvent
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
  return 'CompanyEpsEvent.tabShown(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $TabShownCopyWith<$Res> implements $CompanyEpsEventCopyWith<$Res> {
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

/// Create a copy of CompanyEpsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(TabShown(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabHidden implements CompanyEpsEvent {
  const TabHidden();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabHidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyEpsEvent.tabHidden()';
}


}




/// @nodoc


class AppBackgrounded implements CompanyEpsEvent {
  const AppBackgrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBackgrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyEpsEvent.appBackgrounded()';
}


}




/// @nodoc


class AppForegrounded implements CompanyEpsEvent {
  const AppForegrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppForegrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyEpsEvent.appForegrounded()';
}


}




/// @nodoc


class PeriodViewed implements CompanyEpsEvent {
  const PeriodViewed({required this.isAnnual});
  

 final  bool isAnnual;

/// Create a copy of CompanyEpsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodViewedCopyWith<PeriodViewed> get copyWith => _$PeriodViewedCopyWithImpl<PeriodViewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodViewed&&(identical(other.isAnnual, isAnnual) || other.isAnnual == isAnnual));
}


@override
int get hashCode => Object.hash(runtimeType,isAnnual);

@override
String toString() {
  return 'CompanyEpsEvent.periodViewed(isAnnual: $isAnnual)';
}


}

/// @nodoc
abstract mixin class $PeriodViewedCopyWith<$Res> implements $CompanyEpsEventCopyWith<$Res> {
  factory $PeriodViewedCopyWith(PeriodViewed value, $Res Function(PeriodViewed) _then) = _$PeriodViewedCopyWithImpl;
@useResult
$Res call({
 bool isAnnual
});




}
/// @nodoc
class _$PeriodViewedCopyWithImpl<$Res>
    implements $PeriodViewedCopyWith<$Res> {
  _$PeriodViewedCopyWithImpl(this._self, this._then);

  final PeriodViewed _self;
  final $Res Function(PeriodViewed) _then;

/// Create a copy of CompanyEpsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isAnnual = null,}) {
  return _then(PeriodViewed(
isAnnual: null == isAnnual ? _self.isAnnual : isAnnual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ViewAllTapped implements CompanyEpsEvent {
  const ViewAllTapped({required this.isAnnual, required this.isChart});
  

 final  bool isAnnual;
 final  bool isChart;

/// Create a copy of CompanyEpsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewAllTappedCopyWith<ViewAllTapped> get copyWith => _$ViewAllTappedCopyWithImpl<ViewAllTapped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewAllTapped&&(identical(other.isAnnual, isAnnual) || other.isAnnual == isAnnual)&&(identical(other.isChart, isChart) || other.isChart == isChart));
}


@override
int get hashCode => Object.hash(runtimeType,isAnnual,isChart);

@override
String toString() {
  return 'CompanyEpsEvent.viewAllTapped(isAnnual: $isAnnual, isChart: $isChart)';
}


}

/// @nodoc
abstract mixin class $ViewAllTappedCopyWith<$Res> implements $CompanyEpsEventCopyWith<$Res> {
  factory $ViewAllTappedCopyWith(ViewAllTapped value, $Res Function(ViewAllTapped) _then) = _$ViewAllTappedCopyWithImpl;
@useResult
$Res call({
 bool isAnnual, bool isChart
});




}
/// @nodoc
class _$ViewAllTappedCopyWithImpl<$Res>
    implements $ViewAllTappedCopyWith<$Res> {
  _$ViewAllTappedCopyWithImpl(this._self, this._then);

  final ViewAllTapped _self;
  final $Res Function(ViewAllTapped) _then;

/// Create a copy of CompanyEpsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isAnnual = null,Object? isChart = null,}) {
  return _then(ViewAllTapped(
isAnnual: null == isAnnual ? _self.isAnnual : isAnnual // ignore: cast_nullable_to_non_nullable
as bool,isChart: null == isChart ? _self.isChart : isChart // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
