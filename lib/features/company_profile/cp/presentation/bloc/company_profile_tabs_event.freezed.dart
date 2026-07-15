// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_tabs_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyProfileTabsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileTabsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileTabsEvent()';
}


}

/// @nodoc
class $CompanyProfileTabsEventCopyWith<$Res>  {
$CompanyProfileTabsEventCopyWith(CompanyProfileTabsEvent _, $Res Function(CompanyProfileTabsEvent) __);
}


/// Adds pattern-matching-related methods to [CompanyProfileTabsEvent].
extension CompanyProfileTabsEventPatterns on CompanyProfileTabsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( TabActivated value)?  tabActivated,TResult Function( MoreTabIndexChanged value)?  moreTabIndexChanged,TResult Function( TabOrderChanged value)?  tabOrderChanged,TResult Function( Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case TabActivated() when tabActivated != null:
return tabActivated(_that);case MoreTabIndexChanged() when moreTabIndexChanged != null:
return moreTabIndexChanged(_that);case TabOrderChanged() when tabOrderChanged != null:
return tabOrderChanged(_that);case Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( TabActivated value)  tabActivated,required TResult Function( MoreTabIndexChanged value)  moreTabIndexChanged,required TResult Function( TabOrderChanged value)  tabOrderChanged,required TResult Function( Reset value)  reset,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case TabActivated():
return tabActivated(_that);case MoreTabIndexChanged():
return moreTabIndexChanged(_that);case TabOrderChanged():
return tabOrderChanged(_that);case Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( TabActivated value)?  tabActivated,TResult? Function( MoreTabIndexChanged value)?  moreTabIndexChanged,TResult? Function( TabOrderChanged value)?  tabOrderChanged,TResult? Function( Reset value)?  reset,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case TabActivated() when tabActivated != null:
return tabActivated(_that);case MoreTabIndexChanged() when moreTabIndexChanged != null:
return moreTabIndexChanged(_that);case TabOrderChanged() when tabOrderChanged != null:
return tabOrderChanged(_that);case Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( CompanyProfileTab tab,  String ticker)?  tabActivated,TResult Function( int index,  String ticker)?  moreTabIndexChanged,TResult Function()?  tabOrderChanged,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case TabActivated() when tabActivated != null:
return tabActivated(_that.tab,_that.ticker);case MoreTabIndexChanged() when moreTabIndexChanged != null:
return moreTabIndexChanged(_that.index,_that.ticker);case TabOrderChanged() when tabOrderChanged != null:
return tabOrderChanged();case Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( CompanyProfileTab tab,  String ticker)  tabActivated,required TResult Function( int index,  String ticker)  moreTabIndexChanged,required TResult Function()  tabOrderChanged,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case Started():
return started();case TabActivated():
return tabActivated(_that.tab,_that.ticker);case MoreTabIndexChanged():
return moreTabIndexChanged(_that.index,_that.ticker);case TabOrderChanged():
return tabOrderChanged();case Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( CompanyProfileTab tab,  String ticker)?  tabActivated,TResult? Function( int index,  String ticker)?  moreTabIndexChanged,TResult? Function()?  tabOrderChanged,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case TabActivated() when tabActivated != null:
return tabActivated(_that.tab,_that.ticker);case MoreTabIndexChanged() when moreTabIndexChanged != null:
return moreTabIndexChanged(_that.index,_that.ticker);case TabOrderChanged() when tabOrderChanged != null:
return tabOrderChanged();case Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class Started implements CompanyProfileTabsEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileTabsEvent.started()';
}


}




/// @nodoc


class TabActivated implements CompanyProfileTabsEvent {
  const TabActivated({required this.tab, required this.ticker});
  

 final  CompanyProfileTab tab;
 final  String ticker;

/// Create a copy of CompanyProfileTabsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabActivatedCopyWith<TabActivated> get copyWith => _$TabActivatedCopyWithImpl<TabActivated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabActivated&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,tab,ticker);

@override
String toString() {
  return 'CompanyProfileTabsEvent.tabActivated(tab: $tab, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $TabActivatedCopyWith<$Res> implements $CompanyProfileTabsEventCopyWith<$Res> {
  factory $TabActivatedCopyWith(TabActivated value, $Res Function(TabActivated) _then) = _$TabActivatedCopyWithImpl;
@useResult
$Res call({
 CompanyProfileTab tab, String ticker
});




}
/// @nodoc
class _$TabActivatedCopyWithImpl<$Res>
    implements $TabActivatedCopyWith<$Res> {
  _$TabActivatedCopyWithImpl(this._self, this._then);

  final TabActivated _self;
  final $Res Function(TabActivated) _then;

/// Create a copy of CompanyProfileTabsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tab = null,Object? ticker = null,}) {
  return _then(TabActivated(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as CompanyProfileTab,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MoreTabIndexChanged implements CompanyProfileTabsEvent {
  const MoreTabIndexChanged({required this.index, required this.ticker});
  

 final  int index;
 final  String ticker;

/// Create a copy of CompanyProfileTabsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoreTabIndexChangedCopyWith<MoreTabIndexChanged> get copyWith => _$MoreTabIndexChangedCopyWithImpl<MoreTabIndexChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoreTabIndexChanged&&(identical(other.index, index) || other.index == index)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,index,ticker);

@override
String toString() {
  return 'CompanyProfileTabsEvent.moreTabIndexChanged(index: $index, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $MoreTabIndexChangedCopyWith<$Res> implements $CompanyProfileTabsEventCopyWith<$Res> {
  factory $MoreTabIndexChangedCopyWith(MoreTabIndexChanged value, $Res Function(MoreTabIndexChanged) _then) = _$MoreTabIndexChangedCopyWithImpl;
@useResult
$Res call({
 int index, String ticker
});




}
/// @nodoc
class _$MoreTabIndexChangedCopyWithImpl<$Res>
    implements $MoreTabIndexChangedCopyWith<$Res> {
  _$MoreTabIndexChangedCopyWithImpl(this._self, this._then);

  final MoreTabIndexChanged _self;
  final $Res Function(MoreTabIndexChanged) _then;

/// Create a copy of CompanyProfileTabsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,Object? ticker = null,}) {
  return _then(MoreTabIndexChanged(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabOrderChanged implements CompanyProfileTabsEvent {
  const TabOrderChanged();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabOrderChanged);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileTabsEvent.tabOrderChanged()';
}


}




/// @nodoc


class Reset implements CompanyProfileTabsEvent {
  const Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileTabsEvent.reset()';
}


}




// dart format on
