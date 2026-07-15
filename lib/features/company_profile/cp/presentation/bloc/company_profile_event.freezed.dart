// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_event.dart';

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Opened value)?  opened,TResult Function( TabViewed value)?  tabViewed,TResult Function( WatchlistStatusChanged value)?  watchlistStatusChanged,TResult Function( LifecycleChanged value)?  lifecycleChanged,TResult Function( EditTabsOpened value)?  editTabsOpened,TResult Function( TabOrderSaved value)?  tabOrderSaved,TResult Function( Closed value)?  closed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Opened() when opened != null:
return opened(_that);case TabViewed() when tabViewed != null:
return tabViewed(_that);case WatchlistStatusChanged() when watchlistStatusChanged != null:
return watchlistStatusChanged(_that);case LifecycleChanged() when lifecycleChanged != null:
return lifecycleChanged(_that);case EditTabsOpened() when editTabsOpened != null:
return editTabsOpened(_that);case TabOrderSaved() when tabOrderSaved != null:
return tabOrderSaved(_that);case Closed() when closed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Opened value)  opened,required TResult Function( TabViewed value)  tabViewed,required TResult Function( WatchlistStatusChanged value)  watchlistStatusChanged,required TResult Function( LifecycleChanged value)  lifecycleChanged,required TResult Function( EditTabsOpened value)  editTabsOpened,required TResult Function( TabOrderSaved value)  tabOrderSaved,required TResult Function( Closed value)  closed,}){
final _that = this;
switch (_that) {
case Opened():
return opened(_that);case TabViewed():
return tabViewed(_that);case WatchlistStatusChanged():
return watchlistStatusChanged(_that);case LifecycleChanged():
return lifecycleChanged(_that);case EditTabsOpened():
return editTabsOpened(_that);case TabOrderSaved():
return tabOrderSaved(_that);case Closed():
return closed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Opened value)?  opened,TResult? Function( TabViewed value)?  tabViewed,TResult? Function( WatchlistStatusChanged value)?  watchlistStatusChanged,TResult? Function( LifecycleChanged value)?  lifecycleChanged,TResult? Function( EditTabsOpened value)?  editTabsOpened,TResult? Function( TabOrderSaved value)?  tabOrderSaved,TResult? Function( Closed value)?  closed,}){
final _that = this;
switch (_that) {
case Opened() when opened != null:
return opened(_that);case TabViewed() when tabViewed != null:
return tabViewed(_that);case WatchlistStatusChanged() when watchlistStatusChanged != null:
return watchlistStatusChanged(_that);case LifecycleChanged() when lifecycleChanged != null:
return lifecycleChanged(_that);case EditTabsOpened() when editTabsOpened != null:
return editTabsOpened(_that);case TabOrderSaved() when tabOrderSaved != null:
return tabOrderSaved(_that);case Closed() when closed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  String companyName,  String? industry,  String? sector,  String initialTabName,  bool isWatchlisted,  bool isCompany,  bool isEtf,  bool isFund)?  opened,TResult Function( String tabName)?  tabViewed,TResult Function( bool isWatchlisted)?  watchlistStatusChanged,TResult Function( BizzieLifecycleState state)?  lifecycleChanged,TResult Function( bool isSubscribed)?  editTabsOpened,TResult Function( bool isSubscribed,  List<String> mainTabs,  List<String> moreTabs)?  tabOrderSaved,TResult Function()?  closed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Opened() when opened != null:
return opened(_that.ticker,_that.companyName,_that.industry,_that.sector,_that.initialTabName,_that.isWatchlisted,_that.isCompany,_that.isEtf,_that.isFund);case TabViewed() when tabViewed != null:
return tabViewed(_that.tabName);case WatchlistStatusChanged() when watchlistStatusChanged != null:
return watchlistStatusChanged(_that.isWatchlisted);case LifecycleChanged() when lifecycleChanged != null:
return lifecycleChanged(_that.state);case EditTabsOpened() when editTabsOpened != null:
return editTabsOpened(_that.isSubscribed);case TabOrderSaved() when tabOrderSaved != null:
return tabOrderSaved(_that.isSubscribed,_that.mainTabs,_that.moreTabs);case Closed() when closed != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  String companyName,  String? industry,  String? sector,  String initialTabName,  bool isWatchlisted,  bool isCompany,  bool isEtf,  bool isFund)  opened,required TResult Function( String tabName)  tabViewed,required TResult Function( bool isWatchlisted)  watchlistStatusChanged,required TResult Function( BizzieLifecycleState state)  lifecycleChanged,required TResult Function( bool isSubscribed)  editTabsOpened,required TResult Function( bool isSubscribed,  List<String> mainTabs,  List<String> moreTabs)  tabOrderSaved,required TResult Function()  closed,}) {final _that = this;
switch (_that) {
case Opened():
return opened(_that.ticker,_that.companyName,_that.industry,_that.sector,_that.initialTabName,_that.isWatchlisted,_that.isCompany,_that.isEtf,_that.isFund);case TabViewed():
return tabViewed(_that.tabName);case WatchlistStatusChanged():
return watchlistStatusChanged(_that.isWatchlisted);case LifecycleChanged():
return lifecycleChanged(_that.state);case EditTabsOpened():
return editTabsOpened(_that.isSubscribed);case TabOrderSaved():
return tabOrderSaved(_that.isSubscribed,_that.mainTabs,_that.moreTabs);case Closed():
return closed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  String companyName,  String? industry,  String? sector,  String initialTabName,  bool isWatchlisted,  bool isCompany,  bool isEtf,  bool isFund)?  opened,TResult? Function( String tabName)?  tabViewed,TResult? Function( bool isWatchlisted)?  watchlistStatusChanged,TResult? Function( BizzieLifecycleState state)?  lifecycleChanged,TResult? Function( bool isSubscribed)?  editTabsOpened,TResult? Function( bool isSubscribed,  List<String> mainTabs,  List<String> moreTabs)?  tabOrderSaved,TResult? Function()?  closed,}) {final _that = this;
switch (_that) {
case Opened() when opened != null:
return opened(_that.ticker,_that.companyName,_that.industry,_that.sector,_that.initialTabName,_that.isWatchlisted,_that.isCompany,_that.isEtf,_that.isFund);case TabViewed() when tabViewed != null:
return tabViewed(_that.tabName);case WatchlistStatusChanged() when watchlistStatusChanged != null:
return watchlistStatusChanged(_that.isWatchlisted);case LifecycleChanged() when lifecycleChanged != null:
return lifecycleChanged(_that.state);case EditTabsOpened() when editTabsOpened != null:
return editTabsOpened(_that.isSubscribed);case TabOrderSaved() when tabOrderSaved != null:
return tabOrderSaved(_that.isSubscribed,_that.mainTabs,_that.moreTabs);case Closed() when closed != null:
return closed();case _:
  return null;

}
}

}

/// @nodoc


class Opened implements CompanyProfileEvent {
  const Opened({required this.ticker, required this.companyName, required this.industry, required this.sector, required this.initialTabName, required this.isWatchlisted, required this.isCompany, required this.isEtf, required this.isFund});
  

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
$OpenedCopyWith<Opened> get copyWith => _$OpenedCopyWithImpl<Opened>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Opened&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.initialTabName, initialTabName) || other.initialTabName == initialTabName)&&(identical(other.isWatchlisted, isWatchlisted) || other.isWatchlisted == isWatchlisted)&&(identical(other.isCompany, isCompany) || other.isCompany == isCompany)&&(identical(other.isEtf, isEtf) || other.isEtf == isEtf)&&(identical(other.isFund, isFund) || other.isFund == isFund));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,industry,sector,initialTabName,isWatchlisted,isCompany,isEtf,isFund);

@override
String toString() {
  return 'CompanyProfileEvent.opened(ticker: $ticker, companyName: $companyName, industry: $industry, sector: $sector, initialTabName: $initialTabName, isWatchlisted: $isWatchlisted, isCompany: $isCompany, isEtf: $isEtf, isFund: $isFund)';
}


}

/// @nodoc
abstract mixin class $OpenedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory $OpenedCopyWith(Opened value, $Res Function(Opened) _then) = _$OpenedCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName, String? industry, String? sector, String initialTabName, bool isWatchlisted, bool isCompany, bool isEtf, bool isFund
});




}
/// @nodoc
class _$OpenedCopyWithImpl<$Res>
    implements $OpenedCopyWith<$Res> {
  _$OpenedCopyWithImpl(this._self, this._then);

  final Opened _self;
  final $Res Function(Opened) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? industry = freezed,Object? sector = freezed,Object? initialTabName = null,Object? isWatchlisted = null,Object? isCompany = null,Object? isEtf = null,Object? isFund = null,}) {
  return _then(Opened(
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


class TabViewed implements CompanyProfileEvent {
  const TabViewed({required this.tabName});
  

 final  String tabName;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabViewedCopyWith<TabViewed> get copyWith => _$TabViewedCopyWithImpl<TabViewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabViewed&&(identical(other.tabName, tabName) || other.tabName == tabName));
}


@override
int get hashCode => Object.hash(runtimeType,tabName);

@override
String toString() {
  return 'CompanyProfileEvent.tabViewed(tabName: $tabName)';
}


}

/// @nodoc
abstract mixin class $TabViewedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory $TabViewedCopyWith(TabViewed value, $Res Function(TabViewed) _then) = _$TabViewedCopyWithImpl;
@useResult
$Res call({
 String tabName
});




}
/// @nodoc
class _$TabViewedCopyWithImpl<$Res>
    implements $TabViewedCopyWith<$Res> {
  _$TabViewedCopyWithImpl(this._self, this._then);

  final TabViewed _self;
  final $Res Function(TabViewed) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tabName = null,}) {
  return _then(TabViewed(
tabName: null == tabName ? _self.tabName : tabName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class WatchlistStatusChanged implements CompanyProfileEvent {
  const WatchlistStatusChanged({required this.isWatchlisted});
  

 final  bool isWatchlisted;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistStatusChangedCopyWith<WatchlistStatusChanged> get copyWith => _$WatchlistStatusChangedCopyWithImpl<WatchlistStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistStatusChanged&&(identical(other.isWatchlisted, isWatchlisted) || other.isWatchlisted == isWatchlisted));
}


@override
int get hashCode => Object.hash(runtimeType,isWatchlisted);

@override
String toString() {
  return 'CompanyProfileEvent.watchlistStatusChanged(isWatchlisted: $isWatchlisted)';
}


}

/// @nodoc
abstract mixin class $WatchlistStatusChangedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory $WatchlistStatusChangedCopyWith(WatchlistStatusChanged value, $Res Function(WatchlistStatusChanged) _then) = _$WatchlistStatusChangedCopyWithImpl;
@useResult
$Res call({
 bool isWatchlisted
});




}
/// @nodoc
class _$WatchlistStatusChangedCopyWithImpl<$Res>
    implements $WatchlistStatusChangedCopyWith<$Res> {
  _$WatchlistStatusChangedCopyWithImpl(this._self, this._then);

  final WatchlistStatusChanged _self;
  final $Res Function(WatchlistStatusChanged) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isWatchlisted = null,}) {
  return _then(WatchlistStatusChanged(
isWatchlisted: null == isWatchlisted ? _self.isWatchlisted : isWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LifecycleChanged implements CompanyProfileEvent {
  const LifecycleChanged({required this.state});
  

 final  BizzieLifecycleState state;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LifecycleChangedCopyWith<LifecycleChanged> get copyWith => _$LifecycleChangedCopyWithImpl<LifecycleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LifecycleChanged&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'CompanyProfileEvent.lifecycleChanged(state: $state)';
}


}

/// @nodoc
abstract mixin class $LifecycleChangedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory $LifecycleChangedCopyWith(LifecycleChanged value, $Res Function(LifecycleChanged) _then) = _$LifecycleChangedCopyWithImpl;
@useResult
$Res call({
 BizzieLifecycleState state
});




}
/// @nodoc
class _$LifecycleChangedCopyWithImpl<$Res>
    implements $LifecycleChangedCopyWith<$Res> {
  _$LifecycleChangedCopyWithImpl(this._self, this._then);

  final LifecycleChanged _self;
  final $Res Function(LifecycleChanged) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = null,}) {
  return _then(LifecycleChanged(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as BizzieLifecycleState,
  ));
}


}

/// @nodoc


class EditTabsOpened implements CompanyProfileEvent {
  const EditTabsOpened({required this.isSubscribed});
  

 final  bool isSubscribed;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsOpenedCopyWith<EditTabsOpened> get copyWith => _$EditTabsOpenedCopyWithImpl<EditTabsOpened>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsOpened&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed));
}


@override
int get hashCode => Object.hash(runtimeType,isSubscribed);

@override
String toString() {
  return 'CompanyProfileEvent.editTabsOpened(isSubscribed: $isSubscribed)';
}


}

/// @nodoc
abstract mixin class $EditTabsOpenedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory $EditTabsOpenedCopyWith(EditTabsOpened value, $Res Function(EditTabsOpened) _then) = _$EditTabsOpenedCopyWithImpl;
@useResult
$Res call({
 bool isSubscribed
});




}
/// @nodoc
class _$EditTabsOpenedCopyWithImpl<$Res>
    implements $EditTabsOpenedCopyWith<$Res> {
  _$EditTabsOpenedCopyWithImpl(this._self, this._then);

  final EditTabsOpened _self;
  final $Res Function(EditTabsOpened) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isSubscribed = null,}) {
  return _then(EditTabsOpened(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class TabOrderSaved implements CompanyProfileEvent {
  const TabOrderSaved({required this.isSubscribed, required final  List<String> mainTabs, required final  List<String> moreTabs}): _mainTabs = mainTabs,_moreTabs = moreTabs;
  

 final  bool isSubscribed;
 final  List<String> _mainTabs;
 List<String> get mainTabs {
  if (_mainTabs is EqualUnmodifiableListView) return _mainTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mainTabs);
}

 final  List<String> _moreTabs;
 List<String> get moreTabs {
  if (_moreTabs is EqualUnmodifiableListView) return _moreTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moreTabs);
}


/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabOrderSavedCopyWith<TabOrderSaved> get copyWith => _$TabOrderSavedCopyWithImpl<TabOrderSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabOrderSaved&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other._mainTabs, _mainTabs)&&const DeepCollectionEquality().equals(other._moreTabs, _moreTabs));
}


@override
int get hashCode => Object.hash(runtimeType,isSubscribed,const DeepCollectionEquality().hash(_mainTabs),const DeepCollectionEquality().hash(_moreTabs));

@override
String toString() {
  return 'CompanyProfileEvent.tabOrderSaved(isSubscribed: $isSubscribed, mainTabs: $mainTabs, moreTabs: $moreTabs)';
}


}

/// @nodoc
abstract mixin class $TabOrderSavedCopyWith<$Res> implements $CompanyProfileEventCopyWith<$Res> {
  factory $TabOrderSavedCopyWith(TabOrderSaved value, $Res Function(TabOrderSaved) _then) = _$TabOrderSavedCopyWithImpl;
@useResult
$Res call({
 bool isSubscribed, List<String> mainTabs, List<String> moreTabs
});




}
/// @nodoc
class _$TabOrderSavedCopyWithImpl<$Res>
    implements $TabOrderSavedCopyWith<$Res> {
  _$TabOrderSavedCopyWithImpl(this._self, this._then);

  final TabOrderSaved _self;
  final $Res Function(TabOrderSaved) _then;

/// Create a copy of CompanyProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isSubscribed = null,Object? mainTabs = null,Object? moreTabs = null,}) {
  return _then(TabOrderSaved(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,mainTabs: null == mainTabs ? _self._mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<String>,moreTabs: null == moreTabs ? _self._moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class Closed implements CompanyProfileEvent {
  const Closed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Closed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileEvent.closed()';
}


}




// dart format on
