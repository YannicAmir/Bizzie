// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_tabs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyProfileTabsState {

 List<CompanyProfileTab> get mainTabs; List<CompanyProfileTab> get moreTabs; int get moreTabIndex; bool get isBizzieChatEnabled;
/// Create a copy of CompanyProfileTabsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyProfileTabsStateCopyWith<CompanyProfileTabsState> get copyWith => _$CompanyProfileTabsStateCopyWithImpl<CompanyProfileTabsState>(this as CompanyProfileTabsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileTabsState&&const DeepCollectionEquality().equals(other.mainTabs, mainTabs)&&const DeepCollectionEquality().equals(other.moreTabs, moreTabs)&&(identical(other.moreTabIndex, moreTabIndex) || other.moreTabIndex == moreTabIndex)&&(identical(other.isBizzieChatEnabled, isBizzieChatEnabled) || other.isBizzieChatEnabled == isBizzieChatEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(mainTabs),const DeepCollectionEquality().hash(moreTabs),moreTabIndex,isBizzieChatEnabled);

@override
String toString() {
  return 'CompanyProfileTabsState(mainTabs: $mainTabs, moreTabs: $moreTabs, moreTabIndex: $moreTabIndex, isBizzieChatEnabled: $isBizzieChatEnabled)';
}


}

/// @nodoc
abstract mixin class $CompanyProfileTabsStateCopyWith<$Res>  {
  factory $CompanyProfileTabsStateCopyWith(CompanyProfileTabsState value, $Res Function(CompanyProfileTabsState) _then) = _$CompanyProfileTabsStateCopyWithImpl;
@useResult
$Res call({
 List<CompanyProfileTab> mainTabs, List<CompanyProfileTab> moreTabs, int moreTabIndex, bool isBizzieChatEnabled
});




}
/// @nodoc
class _$CompanyProfileTabsStateCopyWithImpl<$Res>
    implements $CompanyProfileTabsStateCopyWith<$Res> {
  _$CompanyProfileTabsStateCopyWithImpl(this._self, this._then);

  final CompanyProfileTabsState _self;
  final $Res Function(CompanyProfileTabsState) _then;

/// Create a copy of CompanyProfileTabsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainTabs = null,Object? moreTabs = null,Object? moreTabIndex = null,Object? isBizzieChatEnabled = null,}) {
  return _then(_self.copyWith(
mainTabs: null == mainTabs ? _self.mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabs: null == moreTabs ? _self.moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabIndex: null == moreTabIndex ? _self.moreTabIndex : moreTabIndex // ignore: cast_nullable_to_non_nullable
as int,isBizzieChatEnabled: null == isBizzieChatEnabled ? _self.isBizzieChatEnabled : isBizzieChatEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyProfileTabsState].
extension CompanyProfileTabsStatePatterns on CompanyProfileTabsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( CompanyProfileTabsLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CompanyProfileTabsLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( CompanyProfileTabsLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case CompanyProfileTabsLoaded():
return loaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( CompanyProfileTabsLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CompanyProfileTabsLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  int moreTabIndex,  bool isBizzieChatEnabled)?  initial,TResult Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  int moreTabIndex,  bool isBizzieChatEnabled)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.mainTabs,_that.moreTabs,_that.moreTabIndex,_that.isBizzieChatEnabled);case CompanyProfileTabsLoaded() when loaded != null:
return loaded(_that.mainTabs,_that.moreTabs,_that.moreTabIndex,_that.isBizzieChatEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  int moreTabIndex,  bool isBizzieChatEnabled)  initial,required TResult Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  int moreTabIndex,  bool isBizzieChatEnabled)  loaded,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.mainTabs,_that.moreTabs,_that.moreTabIndex,_that.isBizzieChatEnabled);case CompanyProfileTabsLoaded():
return loaded(_that.mainTabs,_that.moreTabs,_that.moreTabIndex,_that.isBizzieChatEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  int moreTabIndex,  bool isBizzieChatEnabled)?  initial,TResult? Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  int moreTabIndex,  bool isBizzieChatEnabled)?  loaded,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.mainTabs,_that.moreTabs,_that.moreTabIndex,_that.isBizzieChatEnabled);case CompanyProfileTabsLoaded() when loaded != null:
return loaded(_that.mainTabs,_that.moreTabs,_that.moreTabIndex,_that.isBizzieChatEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _Initial extends CompanyProfileTabsState {
  const _Initial({final  List<CompanyProfileTab> mainTabs = TabLayout.defaultMainTabs, final  List<CompanyProfileTab> moreTabs = TabLayout.defaultMoreTabs, this.moreTabIndex = 0, this.isBizzieChatEnabled = false}): _mainTabs = mainTabs,_moreTabs = moreTabs,super._();
  

 final  List<CompanyProfileTab> _mainTabs;
@override@JsonKey() List<CompanyProfileTab> get mainTabs {
  if (_mainTabs is EqualUnmodifiableListView) return _mainTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mainTabs);
}

 final  List<CompanyProfileTab> _moreTabs;
@override@JsonKey() List<CompanyProfileTab> get moreTabs {
  if (_moreTabs is EqualUnmodifiableListView) return _moreTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moreTabs);
}

@override@JsonKey() final  int moreTabIndex;
@override@JsonKey() final  bool isBizzieChatEnabled;

/// Create a copy of CompanyProfileTabsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&const DeepCollectionEquality().equals(other._mainTabs, _mainTabs)&&const DeepCollectionEquality().equals(other._moreTabs, _moreTabs)&&(identical(other.moreTabIndex, moreTabIndex) || other.moreTabIndex == moreTabIndex)&&(identical(other.isBizzieChatEnabled, isBizzieChatEnabled) || other.isBizzieChatEnabled == isBizzieChatEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_mainTabs),const DeepCollectionEquality().hash(_moreTabs),moreTabIndex,isBizzieChatEnabled);

@override
String toString() {
  return 'CompanyProfileTabsState.initial(mainTabs: $mainTabs, moreTabs: $moreTabs, moreTabIndex: $moreTabIndex, isBizzieChatEnabled: $isBizzieChatEnabled)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $CompanyProfileTabsStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 List<CompanyProfileTab> mainTabs, List<CompanyProfileTab> moreTabs, int moreTabIndex, bool isBizzieChatEnabled
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of CompanyProfileTabsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainTabs = null,Object? moreTabs = null,Object? moreTabIndex = null,Object? isBizzieChatEnabled = null,}) {
  return _then(_Initial(
mainTabs: null == mainTabs ? _self._mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabs: null == moreTabs ? _self._moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabIndex: null == moreTabIndex ? _self.moreTabIndex : moreTabIndex // ignore: cast_nullable_to_non_nullable
as int,isBizzieChatEnabled: null == isBizzieChatEnabled ? _self.isBizzieChatEnabled : isBizzieChatEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CompanyProfileTabsLoaded extends CompanyProfileTabsState {
  const CompanyProfileTabsLoaded({required final  List<CompanyProfileTab> mainTabs, required final  List<CompanyProfileTab> moreTabs, this.moreTabIndex = 0, required this.isBizzieChatEnabled}): _mainTabs = mainTabs,_moreTabs = moreTabs,super._();
  

 final  List<CompanyProfileTab> _mainTabs;
@override List<CompanyProfileTab> get mainTabs {
  if (_mainTabs is EqualUnmodifiableListView) return _mainTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mainTabs);
}

 final  List<CompanyProfileTab> _moreTabs;
@override List<CompanyProfileTab> get moreTabs {
  if (_moreTabs is EqualUnmodifiableListView) return _moreTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moreTabs);
}

@override@JsonKey() final  int moreTabIndex;
@override final  bool isBizzieChatEnabled;

/// Create a copy of CompanyProfileTabsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyProfileTabsLoadedCopyWith<CompanyProfileTabsLoaded> get copyWith => _$CompanyProfileTabsLoadedCopyWithImpl<CompanyProfileTabsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileTabsLoaded&&const DeepCollectionEquality().equals(other._mainTabs, _mainTabs)&&const DeepCollectionEquality().equals(other._moreTabs, _moreTabs)&&(identical(other.moreTabIndex, moreTabIndex) || other.moreTabIndex == moreTabIndex)&&(identical(other.isBizzieChatEnabled, isBizzieChatEnabled) || other.isBizzieChatEnabled == isBizzieChatEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_mainTabs),const DeepCollectionEquality().hash(_moreTabs),moreTabIndex,isBizzieChatEnabled);

@override
String toString() {
  return 'CompanyProfileTabsState.loaded(mainTabs: $mainTabs, moreTabs: $moreTabs, moreTabIndex: $moreTabIndex, isBizzieChatEnabled: $isBizzieChatEnabled)';
}


}

/// @nodoc
abstract mixin class $CompanyProfileTabsLoadedCopyWith<$Res> implements $CompanyProfileTabsStateCopyWith<$Res> {
  factory $CompanyProfileTabsLoadedCopyWith(CompanyProfileTabsLoaded value, $Res Function(CompanyProfileTabsLoaded) _then) = _$CompanyProfileTabsLoadedCopyWithImpl;
@override @useResult
$Res call({
 List<CompanyProfileTab> mainTabs, List<CompanyProfileTab> moreTabs, int moreTabIndex, bool isBizzieChatEnabled
});




}
/// @nodoc
class _$CompanyProfileTabsLoadedCopyWithImpl<$Res>
    implements $CompanyProfileTabsLoadedCopyWith<$Res> {
  _$CompanyProfileTabsLoadedCopyWithImpl(this._self, this._then);

  final CompanyProfileTabsLoaded _self;
  final $Res Function(CompanyProfileTabsLoaded) _then;

/// Create a copy of CompanyProfileTabsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainTabs = null,Object? moreTabs = null,Object? moreTabIndex = null,Object? isBizzieChatEnabled = null,}) {
  return _then(CompanyProfileTabsLoaded(
mainTabs: null == mainTabs ? _self._mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabs: null == moreTabs ? _self._moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabIndex: null == moreTabIndex ? _self.moreTabIndex : moreTabIndex // ignore: cast_nullable_to_non_nullable
as int,isBizzieChatEnabled: null == isBizzieChatEnabled ? _self.isBizzieChatEnabled : isBizzieChatEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
