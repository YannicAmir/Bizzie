// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_tabs_notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditTabsNotice {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsNotice);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsNotice()';
}


}

/// @nodoc
class $EditTabsNoticeCopyWith<$Res>  {
$EditTabsNoticeCopyWith(EditTabsNotice _, $Res Function(EditTabsNotice) __);
}


/// Adds pattern-matching-related methods to [EditTabsNotice].
extension EditTabsNoticePatterns on EditTabsNotice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EditTabsTooManyMainTabs value)?  tooManyMainTabs,TResult Function( EditTabsTooFewMainTabs value)?  tooFewMainTabs,TResult Function( EditTabsTooFewMoreTabs value)?  tooFewMoreTabs,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EditTabsTooManyMainTabs() when tooManyMainTabs != null:
return tooManyMainTabs(_that);case EditTabsTooFewMainTabs() when tooFewMainTabs != null:
return tooFewMainTabs(_that);case EditTabsTooFewMoreTabs() when tooFewMoreTabs != null:
return tooFewMoreTabs(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EditTabsTooManyMainTabs value)  tooManyMainTabs,required TResult Function( EditTabsTooFewMainTabs value)  tooFewMainTabs,required TResult Function( EditTabsTooFewMoreTabs value)  tooFewMoreTabs,}){
final _that = this;
switch (_that) {
case EditTabsTooManyMainTabs():
return tooManyMainTabs(_that);case EditTabsTooFewMainTabs():
return tooFewMainTabs(_that);case EditTabsTooFewMoreTabs():
return tooFewMoreTabs(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EditTabsTooManyMainTabs value)?  tooManyMainTabs,TResult? Function( EditTabsTooFewMainTabs value)?  tooFewMainTabs,TResult? Function( EditTabsTooFewMoreTabs value)?  tooFewMoreTabs,}){
final _that = this;
switch (_that) {
case EditTabsTooManyMainTabs() when tooManyMainTabs != null:
return tooManyMainTabs(_that);case EditTabsTooFewMainTabs() when tooFewMainTabs != null:
return tooFewMainTabs(_that);case EditTabsTooFewMoreTabs() when tooFewMoreTabs != null:
return tooFewMoreTabs(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int maxTabs)?  tooManyMainTabs,TResult Function( int minTabs)?  tooFewMainTabs,TResult Function( int minTabs)?  tooFewMoreTabs,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EditTabsTooManyMainTabs() when tooManyMainTabs != null:
return tooManyMainTabs(_that.maxTabs);case EditTabsTooFewMainTabs() when tooFewMainTabs != null:
return tooFewMainTabs(_that.minTabs);case EditTabsTooFewMoreTabs() when tooFewMoreTabs != null:
return tooFewMoreTabs(_that.minTabs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int maxTabs)  tooManyMainTabs,required TResult Function( int minTabs)  tooFewMainTabs,required TResult Function( int minTabs)  tooFewMoreTabs,}) {final _that = this;
switch (_that) {
case EditTabsTooManyMainTabs():
return tooManyMainTabs(_that.maxTabs);case EditTabsTooFewMainTabs():
return tooFewMainTabs(_that.minTabs);case EditTabsTooFewMoreTabs():
return tooFewMoreTabs(_that.minTabs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int maxTabs)?  tooManyMainTabs,TResult? Function( int minTabs)?  tooFewMainTabs,TResult? Function( int minTabs)?  tooFewMoreTabs,}) {final _that = this;
switch (_that) {
case EditTabsTooManyMainTabs() when tooManyMainTabs != null:
return tooManyMainTabs(_that.maxTabs);case EditTabsTooFewMainTabs() when tooFewMainTabs != null:
return tooFewMainTabs(_that.minTabs);case EditTabsTooFewMoreTabs() when tooFewMoreTabs != null:
return tooFewMoreTabs(_that.minTabs);case _:
  return null;

}
}

}

/// @nodoc


class EditTabsTooManyMainTabs implements EditTabsNotice {
  const EditTabsTooManyMainTabs(this.maxTabs);
  

 final  int maxTabs;

/// Create a copy of EditTabsNotice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsTooManyMainTabsCopyWith<EditTabsTooManyMainTabs> get copyWith => _$EditTabsTooManyMainTabsCopyWithImpl<EditTabsTooManyMainTabs>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsTooManyMainTabs&&(identical(other.maxTabs, maxTabs) || other.maxTabs == maxTabs));
}


@override
int get hashCode => Object.hash(runtimeType,maxTabs);

@override
String toString() {
  return 'EditTabsNotice.tooManyMainTabs(maxTabs: $maxTabs)';
}


}

/// @nodoc
abstract mixin class $EditTabsTooManyMainTabsCopyWith<$Res> implements $EditTabsNoticeCopyWith<$Res> {
  factory $EditTabsTooManyMainTabsCopyWith(EditTabsTooManyMainTabs value, $Res Function(EditTabsTooManyMainTabs) _then) = _$EditTabsTooManyMainTabsCopyWithImpl;
@useResult
$Res call({
 int maxTabs
});




}
/// @nodoc
class _$EditTabsTooManyMainTabsCopyWithImpl<$Res>
    implements $EditTabsTooManyMainTabsCopyWith<$Res> {
  _$EditTabsTooManyMainTabsCopyWithImpl(this._self, this._then);

  final EditTabsTooManyMainTabs _self;
  final $Res Function(EditTabsTooManyMainTabs) _then;

/// Create a copy of EditTabsNotice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? maxTabs = null,}) {
  return _then(EditTabsTooManyMainTabs(
null == maxTabs ? _self.maxTabs : maxTabs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class EditTabsTooFewMainTabs implements EditTabsNotice {
  const EditTabsTooFewMainTabs(this.minTabs);
  

 final  int minTabs;

/// Create a copy of EditTabsNotice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsTooFewMainTabsCopyWith<EditTabsTooFewMainTabs> get copyWith => _$EditTabsTooFewMainTabsCopyWithImpl<EditTabsTooFewMainTabs>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsTooFewMainTabs&&(identical(other.minTabs, minTabs) || other.minTabs == minTabs));
}


@override
int get hashCode => Object.hash(runtimeType,minTabs);

@override
String toString() {
  return 'EditTabsNotice.tooFewMainTabs(minTabs: $minTabs)';
}


}

/// @nodoc
abstract mixin class $EditTabsTooFewMainTabsCopyWith<$Res> implements $EditTabsNoticeCopyWith<$Res> {
  factory $EditTabsTooFewMainTabsCopyWith(EditTabsTooFewMainTabs value, $Res Function(EditTabsTooFewMainTabs) _then) = _$EditTabsTooFewMainTabsCopyWithImpl;
@useResult
$Res call({
 int minTabs
});




}
/// @nodoc
class _$EditTabsTooFewMainTabsCopyWithImpl<$Res>
    implements $EditTabsTooFewMainTabsCopyWith<$Res> {
  _$EditTabsTooFewMainTabsCopyWithImpl(this._self, this._then);

  final EditTabsTooFewMainTabs _self;
  final $Res Function(EditTabsTooFewMainTabs) _then;

/// Create a copy of EditTabsNotice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minTabs = null,}) {
  return _then(EditTabsTooFewMainTabs(
null == minTabs ? _self.minTabs : minTabs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class EditTabsTooFewMoreTabs implements EditTabsNotice {
  const EditTabsTooFewMoreTabs(this.minTabs);
  

 final  int minTabs;

/// Create a copy of EditTabsNotice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsTooFewMoreTabsCopyWith<EditTabsTooFewMoreTabs> get copyWith => _$EditTabsTooFewMoreTabsCopyWithImpl<EditTabsTooFewMoreTabs>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsTooFewMoreTabs&&(identical(other.minTabs, minTabs) || other.minTabs == minTabs));
}


@override
int get hashCode => Object.hash(runtimeType,minTabs);

@override
String toString() {
  return 'EditTabsNotice.tooFewMoreTabs(minTabs: $minTabs)';
}


}

/// @nodoc
abstract mixin class $EditTabsTooFewMoreTabsCopyWith<$Res> implements $EditTabsNoticeCopyWith<$Res> {
  factory $EditTabsTooFewMoreTabsCopyWith(EditTabsTooFewMoreTabs value, $Res Function(EditTabsTooFewMoreTabs) _then) = _$EditTabsTooFewMoreTabsCopyWithImpl;
@useResult
$Res call({
 int minTabs
});




}
/// @nodoc
class _$EditTabsTooFewMoreTabsCopyWithImpl<$Res>
    implements $EditTabsTooFewMoreTabsCopyWith<$Res> {
  _$EditTabsTooFewMoreTabsCopyWithImpl(this._self, this._then);

  final EditTabsTooFewMoreTabs _self;
  final $Res Function(EditTabsTooFewMoreTabs) _then;

/// Create a copy of EditTabsNotice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minTabs = null,}) {
  return _then(EditTabsTooFewMoreTabs(
null == minTabs ? _self.minTabs : minTabs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
