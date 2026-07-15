// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_segments_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanySegmentsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanySegmentsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySegmentsEvent()';
}


}

/// @nodoc
class $CompanySegmentsEventCopyWith<$Res>  {
$CompanySegmentsEventCopyWith(CompanySegmentsEvent _, $Res Function(CompanySegmentsEvent) __);
}


/// Adds pattern-matching-related methods to [CompanySegmentsEvent].
extension CompanySegmentsEventPatterns on CompanySegmentsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadRequested value)?  loadRequested,TResult Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult Function( TabShown value)?  tabShown,TResult Function( TabHidden value)?  tabHidden,TResult Function( AppBackgrounded value)?  appBackgrounded,TResult Function( AppForegrounded value)?  appForegrounded,TResult Function( PeriodChanged value)?  periodChanged,TResult Function( PeriodKeySelected value)?  periodKeySelected,TResult Function( Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case PeriodChanged() when periodChanged != null:
return periodChanged(_that);case PeriodKeySelected() when periodKeySelected != null:
return periodKeySelected(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadRequested value)  loadRequested,required TResult Function( StalenessCheckRequested value)  stalenessCheckRequested,required TResult Function( TabShown value)  tabShown,required TResult Function( TabHidden value)  tabHidden,required TResult Function( AppBackgrounded value)  appBackgrounded,required TResult Function( AppForegrounded value)  appForegrounded,required TResult Function( PeriodChanged value)  periodChanged,required TResult Function( PeriodKeySelected value)  periodKeySelected,required TResult Function( Reset value)  reset,}){
final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that);case StalenessCheckRequested():
return stalenessCheckRequested(_that);case TabShown():
return tabShown(_that);case TabHidden():
return tabHidden(_that);case AppBackgrounded():
return appBackgrounded(_that);case AppForegrounded():
return appForegrounded(_that);case PeriodChanged():
return periodChanged(_that);case PeriodKeySelected():
return periodKeySelected(_that);case Reset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadRequested value)?  loadRequested,TResult? Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult? Function( TabShown value)?  tabShown,TResult? Function( TabHidden value)?  tabHidden,TResult? Function( AppBackgrounded value)?  appBackgrounded,TResult? Function( AppForegrounded value)?  appForegrounded,TResult? Function( PeriodChanged value)?  periodChanged,TResult? Function( PeriodKeySelected value)?  periodKeySelected,TResult? Function( Reset value)?  reset,}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case PeriodChanged() when periodChanged != null:
return periodChanged(_that);case PeriodKeySelected() when periodKeySelected != null:
return periodKeySelected(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  bool forceRefresh)?  loadRequested,TResult Function( String ticker)?  stalenessCheckRequested,TResult Function( String ticker)?  tabShown,TResult Function()?  tabHidden,TResult Function()?  appBackgrounded,TResult Function()?  appForegrounded,TResult Function( bool isAnnual)?  periodChanged,TResult Function( String key,  bool isAnnual)?  periodKeySelected,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case PeriodChanged() when periodChanged != null:
return periodChanged(_that.isAnnual);case PeriodKeySelected() when periodKeySelected != null:
return periodKeySelected(_that.key,_that.isAnnual);case Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  bool forceRefresh)  loadRequested,required TResult Function( String ticker)  stalenessCheckRequested,required TResult Function( String ticker)  tabShown,required TResult Function()  tabHidden,required TResult Function()  appBackgrounded,required TResult Function()  appForegrounded,required TResult Function( bool isAnnual)  periodChanged,required TResult Function( String key,  bool isAnnual)  periodKeySelected,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested():
return stalenessCheckRequested(_that.ticker);case TabShown():
return tabShown(_that.ticker);case TabHidden():
return tabHidden();case AppBackgrounded():
return appBackgrounded();case AppForegrounded():
return appForegrounded();case PeriodChanged():
return periodChanged(_that.isAnnual);case PeriodKeySelected():
return periodKeySelected(_that.key,_that.isAnnual);case Reset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  bool forceRefresh)?  loadRequested,TResult? Function( String ticker)?  stalenessCheckRequested,TResult? Function( String ticker)?  tabShown,TResult? Function()?  tabHidden,TResult? Function()?  appBackgrounded,TResult? Function()?  appForegrounded,TResult? Function( bool isAnnual)?  periodChanged,TResult? Function( String key,  bool isAnnual)?  periodKeySelected,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case PeriodChanged() when periodChanged != null:
return periodChanged(_that.isAnnual);case PeriodKeySelected() when periodKeySelected != null:
return periodKeySelected(_that.key,_that.isAnnual);case Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class LoadRequested implements CompanySegmentsEvent {
  const LoadRequested(this.ticker, {this.forceRefresh = false});
  

 final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of CompanySegmentsEvent
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
  return 'CompanySegmentsEvent.loadRequested(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadRequestedCopyWith<$Res> implements $CompanySegmentsEventCopyWith<$Res> {
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

/// Create a copy of CompanySegmentsEvent
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


class StalenessCheckRequested implements CompanySegmentsEvent {
  const StalenessCheckRequested(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanySegmentsEvent
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
  return 'CompanySegmentsEvent.stalenessCheckRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $StalenessCheckRequestedCopyWith<$Res> implements $CompanySegmentsEventCopyWith<$Res> {
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

/// Create a copy of CompanySegmentsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(StalenessCheckRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabShown implements CompanySegmentsEvent {
  const TabShown(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanySegmentsEvent
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
  return 'CompanySegmentsEvent.tabShown(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $TabShownCopyWith<$Res> implements $CompanySegmentsEventCopyWith<$Res> {
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

/// Create a copy of CompanySegmentsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(TabShown(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabHidden implements CompanySegmentsEvent {
  const TabHidden();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabHidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySegmentsEvent.tabHidden()';
}


}




/// @nodoc


class AppBackgrounded implements CompanySegmentsEvent {
  const AppBackgrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBackgrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySegmentsEvent.appBackgrounded()';
}


}




/// @nodoc


class AppForegrounded implements CompanySegmentsEvent {
  const AppForegrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppForegrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySegmentsEvent.appForegrounded()';
}


}




/// @nodoc


class PeriodChanged implements CompanySegmentsEvent {
  const PeriodChanged({required this.isAnnual});
  

 final  bool isAnnual;

/// Create a copy of CompanySegmentsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodChangedCopyWith<PeriodChanged> get copyWith => _$PeriodChangedCopyWithImpl<PeriodChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodChanged&&(identical(other.isAnnual, isAnnual) || other.isAnnual == isAnnual));
}


@override
int get hashCode => Object.hash(runtimeType,isAnnual);

@override
String toString() {
  return 'CompanySegmentsEvent.periodChanged(isAnnual: $isAnnual)';
}


}

/// @nodoc
abstract mixin class $PeriodChangedCopyWith<$Res> implements $CompanySegmentsEventCopyWith<$Res> {
  factory $PeriodChangedCopyWith(PeriodChanged value, $Res Function(PeriodChanged) _then) = _$PeriodChangedCopyWithImpl;
@useResult
$Res call({
 bool isAnnual
});




}
/// @nodoc
class _$PeriodChangedCopyWithImpl<$Res>
    implements $PeriodChangedCopyWith<$Res> {
  _$PeriodChangedCopyWithImpl(this._self, this._then);

  final PeriodChanged _self;
  final $Res Function(PeriodChanged) _then;

/// Create a copy of CompanySegmentsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isAnnual = null,}) {
  return _then(PeriodChanged(
isAnnual: null == isAnnual ? _self.isAnnual : isAnnual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class PeriodKeySelected implements CompanySegmentsEvent {
  const PeriodKeySelected(this.key, {required this.isAnnual});
  

 final  String key;
 final  bool isAnnual;

/// Create a copy of CompanySegmentsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodKeySelectedCopyWith<PeriodKeySelected> get copyWith => _$PeriodKeySelectedCopyWithImpl<PeriodKeySelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodKeySelected&&(identical(other.key, key) || other.key == key)&&(identical(other.isAnnual, isAnnual) || other.isAnnual == isAnnual));
}


@override
int get hashCode => Object.hash(runtimeType,key,isAnnual);

@override
String toString() {
  return 'CompanySegmentsEvent.periodKeySelected(key: $key, isAnnual: $isAnnual)';
}


}

/// @nodoc
abstract mixin class $PeriodKeySelectedCopyWith<$Res> implements $CompanySegmentsEventCopyWith<$Res> {
  factory $PeriodKeySelectedCopyWith(PeriodKeySelected value, $Res Function(PeriodKeySelected) _then) = _$PeriodKeySelectedCopyWithImpl;
@useResult
$Res call({
 String key, bool isAnnual
});




}
/// @nodoc
class _$PeriodKeySelectedCopyWithImpl<$Res>
    implements $PeriodKeySelectedCopyWith<$Res> {
  _$PeriodKeySelectedCopyWithImpl(this._self, this._then);

  final PeriodKeySelected _self;
  final $Res Function(PeriodKeySelected) _then;

/// Create a copy of CompanySegmentsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? key = null,Object? isAnnual = null,}) {
  return _then(PeriodKeySelected(
null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,isAnnual: null == isAnnual ? _self.isAnnual : isAnnual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Reset implements CompanySegmentsEvent {
  const Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySegmentsEvent.reset()';
}


}




// dart format on
