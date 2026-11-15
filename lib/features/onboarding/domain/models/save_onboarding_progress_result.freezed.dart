// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_onboarding_progress_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaveOnboardingProgressResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveOnboardingProgressResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SaveOnboardingProgressResult()';
}


}

/// @nodoc
class $SaveOnboardingProgressResultCopyWith<$Res>  {
$SaveOnboardingProgressResultCopyWith(SaveOnboardingProgressResult _, $Res Function(SaveOnboardingProgressResult) __);
}


/// Adds pattern-matching-related methods to [SaveOnboardingProgressResult].
extension SaveOnboardingProgressResultPatterns on SaveOnboardingProgressResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SaveOnboardingProgressSaved value)?  saved,TResult Function( SaveOnboardingProgressExistingProfile value)?  existingProfile,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SaveOnboardingProgressSaved() when saved != null:
return saved(_that);case SaveOnboardingProgressExistingProfile() when existingProfile != null:
return existingProfile(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SaveOnboardingProgressSaved value)  saved,required TResult Function( SaveOnboardingProgressExistingProfile value)  existingProfile,}){
final _that = this;
switch (_that) {
case SaveOnboardingProgressSaved():
return saved(_that);case SaveOnboardingProgressExistingProfile():
return existingProfile(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SaveOnboardingProgressSaved value)?  saved,TResult? Function( SaveOnboardingProgressExistingProfile value)?  existingProfile,}){
final _that = this;
switch (_that) {
case SaveOnboardingProgressSaved() when saved != null:
return saved(_that);case SaveOnboardingProgressExistingProfile() when existingProfile != null:
return existingProfile(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String uid)?  saved,TResult Function()?  existingProfile,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SaveOnboardingProgressSaved() when saved != null:
return saved(_that.uid);case SaveOnboardingProgressExistingProfile() when existingProfile != null:
return existingProfile();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String uid)  saved,required TResult Function()  existingProfile,}) {final _that = this;
switch (_that) {
case SaveOnboardingProgressSaved():
return saved(_that.uid);case SaveOnboardingProgressExistingProfile():
return existingProfile();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String uid)?  saved,TResult? Function()?  existingProfile,}) {final _that = this;
switch (_that) {
case SaveOnboardingProgressSaved() when saved != null:
return saved(_that.uid);case SaveOnboardingProgressExistingProfile() when existingProfile != null:
return existingProfile();case _:
  return null;

}
}

}

/// @nodoc


class SaveOnboardingProgressSaved implements SaveOnboardingProgressResult {
  const SaveOnboardingProgressSaved({required this.uid});
  

 final  String uid;

/// Create a copy of SaveOnboardingProgressResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveOnboardingProgressSavedCopyWith<SaveOnboardingProgressSaved> get copyWith => _$SaveOnboardingProgressSavedCopyWithImpl<SaveOnboardingProgressSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveOnboardingProgressSaved&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,uid);

@override
String toString() {
  return 'SaveOnboardingProgressResult.saved(uid: $uid)';
}


}

/// @nodoc
abstract mixin class $SaveOnboardingProgressSavedCopyWith<$Res> implements $SaveOnboardingProgressResultCopyWith<$Res> {
  factory $SaveOnboardingProgressSavedCopyWith(SaveOnboardingProgressSaved value, $Res Function(SaveOnboardingProgressSaved) _then) = _$SaveOnboardingProgressSavedCopyWithImpl;
@useResult
$Res call({
 String uid
});




}
/// @nodoc
class _$SaveOnboardingProgressSavedCopyWithImpl<$Res>
    implements $SaveOnboardingProgressSavedCopyWith<$Res> {
  _$SaveOnboardingProgressSavedCopyWithImpl(this._self, this._then);

  final SaveOnboardingProgressSaved _self;
  final $Res Function(SaveOnboardingProgressSaved) _then;

/// Create a copy of SaveOnboardingProgressResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uid = null,}) {
  return _then(SaveOnboardingProgressSaved(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SaveOnboardingProgressExistingProfile implements SaveOnboardingProgressResult {
  const SaveOnboardingProgressExistingProfile();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveOnboardingProgressExistingProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SaveOnboardingProgressResult.existingProfile()';
}


}




// dart format on
