// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileEvent()';
}


}

/// @nodoc
class $CompanyProfileEventCopyWith<$Res>  {
$CompanyProfileEventCopyWith(CompanyProfileEvent _, $Res Function(CompanyProfileEvent) __);
}


/// Adds pattern-matching-related methods to [CompanyProfileEvent].
extension CompanyProfileEventPatterns on CompanyProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Opened value)?  opened,TResult Function( _TabViewed value)?  tabViewed,TResult Function( _WatchlistStatusChanged value)?  watchlistStatusChanged,TResult Function( _LifecycleChanged value)?  lifecycleChanged,TResult Function( _MoreTabIndexChanged value)?  moreTabIndexChanged,TResult Function( _Closed value)?  closed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Opened() when opened != null:
return opened(_that);case _TabViewed() when tabViewed != null:
return tabViewed(_that);case _WatchlistStatusChanged() when watchlistStatusChanged != null:
return watchlistStatusChanged(_that);case _LifecycleChanged() when lifecycleChanged != null:
return lifecycleChanged(_that);case _MoreTabIndexChanged() when moreTabIndexChanged != null:
return moreTabIndexChanged(_that);case _Closed() when closed != null:
return closed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Opened value)  opened,required TResult Function( _TabViewed value)  tabViewed,required TResult Function( _WatchlistStatusChanged value)  watchlistStatusChanged,required TResult Function( _LifecycleChanged value)  lifecycleChanged,required TResult Function( _MoreTabIndexChanged value)  moreTabIndexChanged,required TResult Function( _Closed value)  closed,}){
final _that = this;
switch (_that) {
case _Opened():
return opened(_that);case _TabViewed():
return tabViewed(_that);case _WatchlistStatusChanged():
return watchlistStatusChanged(_that);case _LifecycleChanged():
return lifecycleChanged(_that);case _MoreTabIndexChanged():
return moreTabIndexChanged(_that);case _Closed():
return closed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Opened value)?  opened,TResult? Function( _TabViewed value)?  tabViewed,TResult? Function( _WatchlistStatusChanged value)?  watchlistStatusChanged,TResult? Function( _LifecycleChanged value)?  lifecycleChanged,TResult? Function( _MoreTabIndexChanged value)?  moreTabIndexChanged,TResult? Function( _Closed value)?  closed,}){
final _that = this;
switch (_that) {
case _Opened() when opened != null:
return opened(_that);case _TabViewed() when tabViewed != null:
return tabViewed(_that);case _WatchlistStatusChanged() when watchlistStatusChanged != null:
return watchlistStatusChanged(_that);case _LifecycleChanged() when lifecycleChanged != null:
return lifecycleChanged(_that);case _MoreTabIndexChanged() when moreTabIndexChanged != null:
return moreTabIndexChanged(_that);case _Closed() when closed != null:
return closed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  String companyName,  String? industry,  String? sector,  String initialTabName,  bool isWatchlisted,  bool isCompany,  bool isEtf,  bool isFund)?  opened,TResult Function( String tabName)?  tabViewed,TResult Function( bool isWatchlisted)?  watchlistStatusChanged,TResult Function( BizzieLifecycleState state)?  lifecycleChanged,TResult Function( int index)?  moreTabIndexChanged,TResult Function()?  closed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Opened() when opened != null:
return opened(_that.ticker,_that.companyName,_that.industry,_that.sector,_that.initialTabName,_that.isWatchlisted,_that.isCompany,_that.isEtf,_that.isFund);case _TabViewed() when tabViewed != null:
return tabViewed(_that.tabName);case _WatchlistStatusChanged() when watchlistStatusChanged != null:
return watchlistStatusChanged(_that.isWatchlisted);case _LifecycleChanged() when lifecycleChanged != null:
return lifecycleChanged(_that.state);case _MoreTabIndexChanged() when moreTabIndexChanged != null:
return moreTabIndexChanged(_that.index);case _Closed() when closed != null:
return closed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  String companyName,  String? industry,  String? sector,  String initialTabName,  bool isWatchlisted,  bool isCompany,  bool isEtf,  bool isFund)  opened,required TResult Function( String tabName)  tabViewed,required TResult Function( bool isWatchlisted)  watchlistStatusChanged,required TResult Function( BizzieLifecycleState state)  lifecycleChanged,required TResult Function( int index)  moreTabIndexChanged,required TResult Function()  closed,}) {final _that = this;
switch (_that) {
case _Opened():
return opened(_that.ticker,_that.companyName,_that.industry,_that.sector,_that.initialTabName,_that.isWatchlisted,_that.isCompany,_that.isEtf,_that.isFund);case _TabViewed():
return tabViewed(_that.tabName);case _WatchlistStatusChanged():
return watchlistStatusChanged(_that.isWatchlisted);case _LifecycleChanged():
return lifecycleChanged(_that.state);case _MoreTabIndexChanged():
return moreTabIndexChanged(_that.index);case _Closed():
return closed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  String companyName,  String? industry,  String? sector,  String initialTabName,  bool isWatchlisted,  bool isCompany,  bool isEtf,  bool isFund)?  opened,TResult? Function( String tabName)?  tabViewed,TResult? Function( bool isWatchlisted)?  watchlistStatusChanged,TResult? Function( BizzieLifecycleState state)?  lifecycleChanged,TResult? Function( int index)?  moreTabIndexChanged,TResult? Function()?  closed,}) {final _that = this;
switch (_that) {
case _Opened() when opened != null:
return opened(_that.ticker,_that.companyName,_that.industry,_that.sector,_that.initialTabName,_that.isWatchlisted,_that.isCompany,_that.isEtf,_that.isFund);case _TabViewed() when tabViewed != null:
return tabViewed(_that.tabName);case _WatchlistStatusChanged() when watchlistStatusChanged != null:
return watchlistStatusChanged(_that.isWatchlisted);case _LifecycleChanged() when lifecycleChanged != null:
return lifecycleChanged(_that.state);case _MoreTabIndexChanged() when moreTabIndexChanged != null:
return moreTabIndexChanged(_that.index);case _Closed() when closed != null:
return closed();case _:
  return null;

}
}

}

/// @nodoc


class _Opened implements CompanyProfileEvent {
  const _Opened({required this.ticker, required this.companyName, required this.industry, required this.sector, required this.initialTabName, required this.isWatchlisted, required this.isCompany, required this.isEtf, required this.isFund});
  

 final  String ticker;
 final  String companyName;
 final  String? industry;
 final  String? sector;
 final  String initialTabName;
 final  bool isWatchlisted;
 final  bool isCompany;
 final  bool isEtf;
 final  bool isFund;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenedCopyWith<_Opened> get copyWith => __$OpenedCopyWithImpl<_Opened>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Opened&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.initialTabName, initialTabName) || other.initialTabName == initialTabName)&&(identical(other.isWatchlisted, isWatchlisted) || other.isWatchlisted == isWatchlisted)&&(identical(other.isCompany, isCompany) || other.isCompany == isCompany)&&(identical(other.isEtf, isEtf) || other.isEtf == isEtf)&&(identical(other.isFund, isFund) || other.isFund == isFund));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,industry,sector,initialTabName,isWatchlisted,isCompany,isEtf,isFund);

@override
String toString() {
  return 'CompanyProfileEvent.opened(ticker: $ticker, companyName: $companyName, industry: $industry, sector: $sector, initialTabName: $initialTabName, isWatchlisted: $isWatchlisted, isCompany: $isCompany, isEtf: $isEtf, isFund: $isFund)';
}


}

/// @nodoc
abstract mixin class _$OpenedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory _$OpenedCopyWith(_Opened value, $Res Function(_Opened) _then) = __$OpenedCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName, String? industry, String? sector, String initialTabName, bool isWatchlisted, bool isCompany, bool isEtf, bool isFund
});




}
/// @nodoc
class __$OpenedCopyWithImpl<$Res>
    implements _$OpenedCopyWith<$Res> {
  __$OpenedCopyWithImpl(this._self, this._then);

  final _Opened _self;
  final $Res Function(_Opened) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? industry = freezed,Object? sector = freezed,Object? initialTabName = null,Object? isWatchlisted = null,Object? isCompany = null,Object? isEtf = null,Object? isFund = null,}) {
  return _then(_Opened(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String?,initialTabName: null == initialTabName ? _self.initialTabName : initialTabName // ignore: cast_nullable_to_non_nullable
as String,isWatchlisted: null == isWatchlisted ? _self.isWatchlisted : isWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,isCompany: null == isCompany ? _self.isCompany : isCompany // ignore: cast_nullable_to_non_nullable
as bool,isEtf: null == isEtf ? _self.isEtf : isEtf // ignore: cast_nullable_to_non_nullable
as bool,isFund: null == isFund ? _self.isFund : isFund // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _TabViewed implements CompanyProfileEvent {
  const _TabViewed({required this.tabName});
  

 final  String tabName;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabViewedCopyWith<_TabViewed> get copyWith => __$TabViewedCopyWithImpl<_TabViewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabViewed&&(identical(other.tabName, tabName) || other.tabName == tabName));
}


@override
int get hashCode => Object.hash(runtimeType,tabName);

@override
String toString() {
  return 'CompanyProfileEvent.tabViewed(tabName: $tabName)';
}


}

/// @nodoc
abstract mixin class _$TabViewedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory _$TabViewedCopyWith(_TabViewed value, $Res Function(_TabViewed) _then) = __$TabViewedCopyWithImpl;
@useResult
$Res call({
 String tabName
});




}
/// @nodoc
class __$TabViewedCopyWithImpl<$Res>
    implements _$TabViewedCopyWith<$Res> {
  __$TabViewedCopyWithImpl(this._self, this._then);

  final _TabViewed _self;
  final $Res Function(_TabViewed) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tabName = null,}) {
  return _then(_TabViewed(
tabName: null == tabName ? _self.tabName : tabName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WatchlistStatusChanged implements CompanyProfileEvent {
  const _WatchlistStatusChanged({required this.isWatchlisted});
  

 final  bool isWatchlisted;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistStatusChangedCopyWith<_WatchlistStatusChanged> get copyWith => __$WatchlistStatusChangedCopyWithImpl<_WatchlistStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistStatusChanged&&(identical(other.isWatchlisted, isWatchlisted) || other.isWatchlisted == isWatchlisted));
}


@override
int get hashCode => Object.hash(runtimeType,isWatchlisted);

@override
String toString() {
  return 'CompanyProfileEvent.watchlistStatusChanged(isWatchlisted: $isWatchlisted)';
}


}

/// @nodoc
abstract mixin class _$WatchlistStatusChangedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory _$WatchlistStatusChangedCopyWith(_WatchlistStatusChanged value, $Res Function(_WatchlistStatusChanged) _then) = __$WatchlistStatusChangedCopyWithImpl;
@useResult
$Res call({
 bool isWatchlisted
});




}
/// @nodoc
class __$WatchlistStatusChangedCopyWithImpl<$Res>
    implements _$WatchlistStatusChangedCopyWith<$Res> {
  __$WatchlistStatusChangedCopyWithImpl(this._self, this._then);

  final _WatchlistStatusChanged _self;
  final $Res Function(_WatchlistStatusChanged) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isWatchlisted = null,}) {
  return _then(_WatchlistStatusChanged(
isWatchlisted: null == isWatchlisted ? _self.isWatchlisted : isWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _LifecycleChanged implements CompanyProfileEvent {
  const _LifecycleChanged({required this.state});
  

 final  BizzieLifecycleState state;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LifecycleChangedCopyWith<_LifecycleChanged> get copyWith => __$LifecycleChangedCopyWithImpl<_LifecycleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LifecycleChanged&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'CompanyProfileEvent.lifecycleChanged(state: $state)';
}


}

/// @nodoc
abstract mixin class _$LifecycleChangedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory _$LifecycleChangedCopyWith(_LifecycleChanged value, $Res Function(_LifecycleChanged) _then) = __$LifecycleChangedCopyWithImpl;
@useResult
$Res call({
 BizzieLifecycleState state
});




}
/// @nodoc
class __$LifecycleChangedCopyWithImpl<$Res>
    implements _$LifecycleChangedCopyWith<$Res> {
  __$LifecycleChangedCopyWithImpl(this._self, this._then);

  final _LifecycleChanged _self;
  final $Res Function(_LifecycleChanged) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = null,}) {
  return _then(_LifecycleChanged(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as BizzieLifecycleState,
  ));
}


}

/// @nodoc


class _MoreTabIndexChanged implements CompanyProfileEvent {
  const _MoreTabIndexChanged({required this.index});
  

 final  int index;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoreTabIndexChangedCopyWith<_MoreTabIndexChanged> get copyWith => __$MoreTabIndexChangedCopyWithImpl<_MoreTabIndexChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoreTabIndexChanged&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'CompanyProfileEvent.moreTabIndexChanged(index: $index)';
}


}

/// @nodoc
abstract mixin class _$MoreTabIndexChangedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory _$MoreTabIndexChangedCopyWith(_MoreTabIndexChanged value, $Res Function(_MoreTabIndexChanged) _then) = __$MoreTabIndexChangedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$MoreTabIndexChangedCopyWithImpl<$Res>
    implements _$MoreTabIndexChangedCopyWith<$Res> {
  __$MoreTabIndexChangedCopyWithImpl(this._self, this._then);

  final _MoreTabIndexChanged _self;
  final $Res Function(_MoreTabIndexChanged) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_MoreTabIndexChanged(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Closed implements CompanyProfileEvent {
  const _Closed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Closed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileEvent.closed()';
}


}




// dart format on
