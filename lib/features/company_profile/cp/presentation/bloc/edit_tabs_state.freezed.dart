// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_tabs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditTabsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsState()';
}


}

/// @nodoc
class $EditTabsStateCopyWith<$Res>  {
$EditTabsStateCopyWith(EditTabsState _, $Res Function(EditTabsState) __);
}


/// Adds pattern-matching-related methods to [EditTabsState].
extension EditTabsStatePatterns on EditTabsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( EditTabsEditing value)?  editing,TResult Function( EditTabsSaved value)?  saved,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case EditTabsEditing() when editing != null:
return editing(_that);case EditTabsSaved() when saved != null:
return saved(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( EditTabsEditing value)  editing,required TResult Function( EditTabsSaved value)  saved,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case EditTabsEditing():
return editing(_that);case EditTabsSaved():
return saved(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( EditTabsEditing value)?  editing,TResult? Function( EditTabsSaved value)?  saved,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case EditTabsEditing() when editing != null:
return editing(_that);case EditTabsSaved() when saved != null:
return saved(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<CompanyProfileTab> initialMainTabs,  List<CompanyProfileTab> initialMoreTabs,  List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  List<CompanyProfileTab> bizziePlusTabs,  bool isSubscribed,  bool isSaving,  EditTabsNotice? notice)?  editing,TResult Function( TabLayout layout)?  saved,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case EditTabsEditing() when editing != null:
return editing(_that.initialMainTabs,_that.initialMoreTabs,_that.mainTabs,_that.moreTabs,_that.bizziePlusTabs,_that.isSubscribed,_that.isSaving,_that.notice);case EditTabsSaved() when saved != null:
return saved(_that.layout);case _Failure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<CompanyProfileTab> initialMainTabs,  List<CompanyProfileTab> initialMoreTabs,  List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  List<CompanyProfileTab> bizziePlusTabs,  bool isSubscribed,  bool isSaving,  EditTabsNotice? notice)  editing,required TResult Function( TabLayout layout)  saved,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case EditTabsEditing():
return editing(_that.initialMainTabs,_that.initialMoreTabs,_that.mainTabs,_that.moreTabs,_that.bizziePlusTabs,_that.isSubscribed,_that.isSaving,_that.notice);case EditTabsSaved():
return saved(_that.layout);case _Failure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<CompanyProfileTab> initialMainTabs,  List<CompanyProfileTab> initialMoreTabs,  List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs,  List<CompanyProfileTab> bizziePlusTabs,  bool isSubscribed,  bool isSaving,  EditTabsNotice? notice)?  editing,TResult? Function( TabLayout layout)?  saved,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case EditTabsEditing() when editing != null:
return editing(_that.initialMainTabs,_that.initialMoreTabs,_that.mainTabs,_that.moreTabs,_that.bizziePlusTabs,_that.isSubscribed,_that.isSaving,_that.notice);case EditTabsSaved() when saved != null:
return saved(_that.layout);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements EditTabsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsState.initial()';
}


}




/// @nodoc


class EditTabsEditing implements EditTabsState {
  const EditTabsEditing({required final  List<CompanyProfileTab> initialMainTabs, required final  List<CompanyProfileTab> initialMoreTabs, required final  List<CompanyProfileTab> mainTabs, required final  List<CompanyProfileTab> moreTabs, required final  List<CompanyProfileTab> bizziePlusTabs, required this.isSubscribed, this.isSaving = false, this.notice}): _initialMainTabs = initialMainTabs,_initialMoreTabs = initialMoreTabs,_mainTabs = mainTabs,_moreTabs = moreTabs,_bizziePlusTabs = bizziePlusTabs;
  

 final  List<CompanyProfileTab> _initialMainTabs;
 List<CompanyProfileTab> get initialMainTabs {
  if (_initialMainTabs is EqualUnmodifiableListView) return _initialMainTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_initialMainTabs);
}

 final  List<CompanyProfileTab> _initialMoreTabs;
 List<CompanyProfileTab> get initialMoreTabs {
  if (_initialMoreTabs is EqualUnmodifiableListView) return _initialMoreTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_initialMoreTabs);
}

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

 final  List<CompanyProfileTab> _bizziePlusTabs;
 List<CompanyProfileTab> get bizziePlusTabs {
  if (_bizziePlusTabs is EqualUnmodifiableListView) return _bizziePlusTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bizziePlusTabs);
}

 final  bool isSubscribed;
@JsonKey() final  bool isSaving;
 final  EditTabsNotice? notice;

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsEditingCopyWith<EditTabsEditing> get copyWith => _$EditTabsEditingCopyWithImpl<EditTabsEditing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsEditing&&const DeepCollectionEquality().equals(other._initialMainTabs, _initialMainTabs)&&const DeepCollectionEquality().equals(other._initialMoreTabs, _initialMoreTabs)&&const DeepCollectionEquality().equals(other._mainTabs, _mainTabs)&&const DeepCollectionEquality().equals(other._moreTabs, _moreTabs)&&const DeepCollectionEquality().equals(other._bizziePlusTabs, _bizziePlusTabs)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.notice, notice) || other.notice == notice));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_initialMainTabs),const DeepCollectionEquality().hash(_initialMoreTabs),const DeepCollectionEquality().hash(_mainTabs),const DeepCollectionEquality().hash(_moreTabs),const DeepCollectionEquality().hash(_bizziePlusTabs),isSubscribed,isSaving,notice);

@override
String toString() {
  return 'EditTabsState.editing(initialMainTabs: $initialMainTabs, initialMoreTabs: $initialMoreTabs, mainTabs: $mainTabs, moreTabs: $moreTabs, bizziePlusTabs: $bizziePlusTabs, isSubscribed: $isSubscribed, isSaving: $isSaving, notice: $notice)';
}


}

/// @nodoc
abstract mixin class $EditTabsEditingCopyWith<$Res> implements $EditTabsStateCopyWith<$Res> {
  factory $EditTabsEditingCopyWith(EditTabsEditing value, $Res Function(EditTabsEditing) _then) = _$EditTabsEditingCopyWithImpl;
@useResult
$Res call({
 List<CompanyProfileTab> initialMainTabs, List<CompanyProfileTab> initialMoreTabs, List<CompanyProfileTab> mainTabs, List<CompanyProfileTab> moreTabs, List<CompanyProfileTab> bizziePlusTabs, bool isSubscribed, bool isSaving, EditTabsNotice? notice
});


$EditTabsNoticeCopyWith<$Res>? get notice;

}
/// @nodoc
class _$EditTabsEditingCopyWithImpl<$Res>
    implements $EditTabsEditingCopyWith<$Res> {
  _$EditTabsEditingCopyWithImpl(this._self, this._then);

  final EditTabsEditing _self;
  final $Res Function(EditTabsEditing) _then;

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? initialMainTabs = null,Object? initialMoreTabs = null,Object? mainTabs = null,Object? moreTabs = null,Object? bizziePlusTabs = null,Object? isSubscribed = null,Object? isSaving = null,Object? notice = freezed,}) {
  return _then(EditTabsEditing(
initialMainTabs: null == initialMainTabs ? _self._initialMainTabs : initialMainTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,initialMoreTabs: null == initialMoreTabs ? _self._initialMoreTabs : initialMoreTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,mainTabs: null == mainTabs ? _self._mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabs: null == moreTabs ? _self._moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,bizziePlusTabs: null == bizziePlusTabs ? _self._bizziePlusTabs : bizziePlusTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as EditTabsNotice?,
  ));
}

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EditTabsNoticeCopyWith<$Res>? get notice {
    if (_self.notice == null) {
    return null;
  }

  return $EditTabsNoticeCopyWith<$Res>(_self.notice!, (value) {
    return _then(_self.copyWith(notice: value));
  });
}
}

/// @nodoc


class EditTabsSaved implements EditTabsState {
  const EditTabsSaved(this.layout);
  

 final  TabLayout layout;

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsSavedCopyWith<EditTabsSaved> get copyWith => _$EditTabsSavedCopyWithImpl<EditTabsSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsSaved&&(identical(other.layout, layout) || other.layout == layout));
}


@override
int get hashCode => Object.hash(runtimeType,layout);

@override
String toString() {
  return 'EditTabsState.saved(layout: $layout)';
}


}

/// @nodoc
abstract mixin class $EditTabsSavedCopyWith<$Res> implements $EditTabsStateCopyWith<$Res> {
  factory $EditTabsSavedCopyWith(EditTabsSaved value, $Res Function(EditTabsSaved) _then) = _$EditTabsSavedCopyWithImpl;
@useResult
$Res call({
 TabLayout layout
});


$TabLayoutCopyWith<$Res> get layout;

}
/// @nodoc
class _$EditTabsSavedCopyWithImpl<$Res>
    implements $EditTabsSavedCopyWith<$Res> {
  _$EditTabsSavedCopyWithImpl(this._self, this._then);

  final EditTabsSaved _self;
  final $Res Function(EditTabsSaved) _then;

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? layout = null,}) {
  return _then(EditTabsSaved(
null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as TabLayout,
  ));
}

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TabLayoutCopyWith<$Res> get layout {
  
  return $TabLayoutCopyWith<$Res>(_self.layout, (value) {
    return _then(_self.copyWith(layout: value));
  });
}
}

/// @nodoc


class _Failure implements EditTabsState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'EditTabsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $EditTabsStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of EditTabsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
