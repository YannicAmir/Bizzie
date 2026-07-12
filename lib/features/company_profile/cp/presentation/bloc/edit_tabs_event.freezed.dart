// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_tabs_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditTabsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsEvent()';
}


}

/// @nodoc
class $EditTabsEventCopyWith<$Res>  {
$EditTabsEventCopyWith(EditTabsEvent _, $Res Function(EditTabsEvent) __);
}


/// Adds pattern-matching-related methods to [EditTabsEvent].
extension EditTabsEventPatterns on EditTabsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EditTabsStarted value)?  started,TResult Function( EditTabsTabReordered value)?  tabReordered,TResult Function( EditTabsSaveRequested value)?  saveRequested,TResult Function( EditTabsReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EditTabsStarted() when started != null:
return started(_that);case EditTabsTabReordered() when tabReordered != null:
return tabReordered(_that);case EditTabsSaveRequested() when saveRequested != null:
return saveRequested(_that);case EditTabsReset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EditTabsStarted value)  started,required TResult Function( EditTabsTabReordered value)  tabReordered,required TResult Function( EditTabsSaveRequested value)  saveRequested,required TResult Function( EditTabsReset value)  reset,}){
final _that = this;
switch (_that) {
case EditTabsStarted():
return started(_that);case EditTabsTabReordered():
return tabReordered(_that);case EditTabsSaveRequested():
return saveRequested(_that);case EditTabsReset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EditTabsStarted value)?  started,TResult? Function( EditTabsTabReordered value)?  tabReordered,TResult? Function( EditTabsSaveRequested value)?  saveRequested,TResult? Function( EditTabsReset value)?  reset,}){
final _that = this;
switch (_that) {
case EditTabsStarted() when started != null:
return started(_that);case EditTabsTabReordered() when tabReordered != null:
return tabReordered(_that);case EditTabsSaveRequested() when saveRequested != null:
return saveRequested(_that);case EditTabsReset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  bool isSubscribed)?  started,TResult Function( int oldIndex,  int newIndex)?  tabReordered,TResult Function()?  saveRequested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EditTabsStarted() when started != null:
return started(_that.mainTabs,_that.moreTabs,_that.isSubscribed);case EditTabsTabReordered() when tabReordered != null:
return tabReordered(_that.oldIndex,_that.newIndex);case EditTabsSaveRequested() when saveRequested != null:
return saveRequested();case EditTabsReset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  bool isSubscribed)  started,required TResult Function( int oldIndex,  int newIndex)  tabReordered,required TResult Function()  saveRequested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case EditTabsStarted():
return started(_that.mainTabs,_that.moreTabs,_that.isSubscribed);case EditTabsTabReordered():
return tabReordered(_that.oldIndex,_that.newIndex);case EditTabsSaveRequested():
return saveRequested();case EditTabsReset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  bool isSubscribed)?  started,TResult? Function( int oldIndex,  int newIndex)?  tabReordered,TResult? Function()?  saveRequested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case EditTabsStarted() when started != null:
return started(_that.mainTabs,_that.moreTabs,_that.isSubscribed);case EditTabsTabReordered() when tabReordered != null:
return tabReordered(_that.oldIndex,_that.newIndex);case EditTabsSaveRequested() when saveRequested != null:
return saveRequested();case EditTabsReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class EditTabsStarted implements EditTabsEvent {
  const EditTabsStarted({required final  List<CompanyProfileTab> mainTabs, required final  List<CompanyProfileTab> moreTabs, required this.isSubscribed}): _mainTabs = mainTabs,_moreTabs = moreTabs;
  

 final  List<CompanyProfileTab> _mainTabs;
 List<CompanyProfileTab> get mainTabs {
  if (_mainTabs is EqualUnmodifiableListView) return _mainTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mainTabs);
}

 final  List<CompanyProfileTab> _moreTabs;
 List<CompanyProfileTab> get moreTabs {
  if (_moreTabs is EqualUnmodifiableListView) return _moreTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moreTabs);
}

 final  bool isSubscribed;

/// Create a copy of EditTabsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsStartedCopyWith<EditTabsStarted> get copyWith => _$EditTabsStartedCopyWithImpl<EditTabsStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsStarted&&const DeepCollectionEquality().equals(other._mainTabs, _mainTabs)&&const DeepCollectionEquality().equals(other._moreTabs, _moreTabs)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_mainTabs),const DeepCollectionEquality().hash(_moreTabs),isSubscribed);

@override
String toString() {
  return 'EditTabsEvent.started(mainTabs: $mainTabs, moreTabs: $moreTabs, isSubscribed: $isSubscribed)';
}


}

/// @nodoc
abstract mixin class $EditTabsStartedCopyWith<$Res> implements $EditTabsEventCopyWith<$Res> {
  factory $EditTabsStartedCopyWith(EditTabsStarted value, $Res Function(EditTabsStarted) _then) = _$EditTabsStartedCopyWithImpl;
@useResult
$Res call({
 List<CompanyProfileTab> mainTabs, List<CompanyProfileTab> moreTabs, bool isSubscribed
});




}
/// @nodoc
class _$EditTabsStartedCopyWithImpl<$Res>
    implements $EditTabsStartedCopyWith<$Res> {
  _$EditTabsStartedCopyWithImpl(this._self, this._then);

  final EditTabsStarted _self;
  final $Res Function(EditTabsStarted) _then;

/// Create a copy of EditTabsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mainTabs = null,Object? moreTabs = null,Object? isSubscribed = null,}) {
  return _then(EditTabsStarted(
mainTabs: null == mainTabs ? _self._mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabs: null == moreTabs ? _self._moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class EditTabsTabReordered implements EditTabsEvent {
  const EditTabsTabReordered({required this.oldIndex, required this.newIndex});
  

 final  int oldIndex;
 final  int newIndex;

/// Create a copy of EditTabsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsTabReorderedCopyWith<EditTabsTabReordered> get copyWith => _$EditTabsTabReorderedCopyWithImpl<EditTabsTabReordered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsTabReordered&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode => Object.hash(runtimeType,oldIndex,newIndex);

@override
String toString() {
  return 'EditTabsEvent.tabReordered(oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class $EditTabsTabReorderedCopyWith<$Res> implements $EditTabsEventCopyWith<$Res> {
  factory $EditTabsTabReorderedCopyWith(EditTabsTabReordered value, $Res Function(EditTabsTabReordered) _then) = _$EditTabsTabReorderedCopyWithImpl;
@useResult
$Res call({
 int oldIndex, int newIndex
});




}
/// @nodoc
class _$EditTabsTabReorderedCopyWithImpl<$Res>
    implements $EditTabsTabReorderedCopyWith<$Res> {
  _$EditTabsTabReorderedCopyWithImpl(this._self, this._then);

  final EditTabsTabReordered _self;
  final $Res Function(EditTabsTabReordered) _then;

/// Create a copy of EditTabsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(EditTabsTabReordered(
oldIndex: null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,newIndex: null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class EditTabsSaveRequested implements EditTabsEvent {
  const EditTabsSaveRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsSaveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsEvent.saveRequested()';
}


}




/// @nodoc


class EditTabsReset implements EditTabsEvent {
  const EditTabsReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsEvent.reset()';
}


}




// dart format on
