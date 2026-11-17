// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skip_onboarding_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SkipOnboardingResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipOnboardingResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SkipOnboardingResult()';
}


}

/// @nodoc
class $SkipOnboardingResultCopyWith<$Res>  {
$SkipOnboardingResultCopyWith(SkipOnboardingResult _, $Res Function(SkipOnboardingResult) __);
}


/// Adds pattern-matching-related methods to [SkipOnboardingResult].
extension SkipOnboardingResultPatterns on SkipOnboardingResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SkipOnboardingCompleted value)?  completed,TResult Function( SkipOnboardingExistingProfile value)?  existingProfile,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SkipOnboardingCompleted() when completed != null:
return completed(_that);case SkipOnboardingExistingProfile() when existingProfile != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SkipOnboardingCompleted value)  completed,required TResult Function( SkipOnboardingExistingProfile value)  existingProfile,}){
final _that = this;
switch (_that) {
case SkipOnboardingCompleted():
return completed(_that);case SkipOnboardingExistingProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SkipOnboardingCompleted value)?  completed,TResult? Function( SkipOnboardingExistingProfile value)?  existingProfile,}){
final _that = this;
switch (_that) {
case SkipOnboardingCompleted() when completed != null:
return completed(_that);case SkipOnboardingExistingProfile() when existingProfile != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PostOnboardingDestination destination,  OnboardingFieldSources fieldSources)?  completed,TResult Function()?  existingProfile,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SkipOnboardingCompleted() when completed != null:
return completed(_that.destination,_that.fieldSources);case SkipOnboardingExistingProfile() when existingProfile != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PostOnboardingDestination destination,  OnboardingFieldSources fieldSources)  completed,required TResult Function()  existingProfile,}) {final _that = this;
switch (_that) {
case SkipOnboardingCompleted():
return completed(_that.destination,_that.fieldSources);case SkipOnboardingExistingProfile():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PostOnboardingDestination destination,  OnboardingFieldSources fieldSources)?  completed,TResult? Function()?  existingProfile,}) {final _that = this;
switch (_that) {
case SkipOnboardingCompleted() when completed != null:
return completed(_that.destination,_that.fieldSources);case SkipOnboardingExistingProfile() when existingProfile != null:
return existingProfile();case _:
  return null;

}
}

}

/// @nodoc


class SkipOnboardingCompleted implements SkipOnboardingResult {
  const SkipOnboardingCompleted({required this.destination, required this.fieldSources});
  

 final  PostOnboardingDestination destination;
 final  OnboardingFieldSources fieldSources;

/// Create a copy of SkipOnboardingResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkipOnboardingCompletedCopyWith<SkipOnboardingCompleted> get copyWith => _$SkipOnboardingCompletedCopyWithImpl<SkipOnboardingCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipOnboardingCompleted&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.fieldSources, fieldSources) || other.fieldSources == fieldSources));
}


@override
int get hashCode => Object.hash(runtimeType,destination,fieldSources);

@override
String toString() {
  return 'SkipOnboardingResult.completed(destination: $destination, fieldSources: $fieldSources)';
}


}

/// @nodoc
abstract mixin class $SkipOnboardingCompletedCopyWith<$Res> implements $SkipOnboardingResultCopyWith<$Res> {
  factory $SkipOnboardingCompletedCopyWith(SkipOnboardingCompleted value, $Res Function(SkipOnboardingCompleted) _then) = _$SkipOnboardingCompletedCopyWithImpl;
@useResult
$Res call({
 PostOnboardingDestination destination, OnboardingFieldSources fieldSources
});


$PostOnboardingDestinationCopyWith<$Res> get destination;$OnboardingFieldSourcesCopyWith<$Res> get fieldSources;

}
/// @nodoc
class _$SkipOnboardingCompletedCopyWithImpl<$Res>
    implements $SkipOnboardingCompletedCopyWith<$Res> {
  _$SkipOnboardingCompletedCopyWithImpl(this._self, this._then);

  final SkipOnboardingCompleted _self;
  final $Res Function(SkipOnboardingCompleted) _then;

/// Create a copy of SkipOnboardingResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? destination = null,Object? fieldSources = null,}) {
  return _then(SkipOnboardingCompleted(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as PostOnboardingDestination,fieldSources: null == fieldSources ? _self.fieldSources : fieldSources // ignore: cast_nullable_to_non_nullable
as OnboardingFieldSources,
  ));
}

/// Create a copy of SkipOnboardingResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostOnboardingDestinationCopyWith<$Res> get destination {
  
  return $PostOnboardingDestinationCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}/// Create a copy of SkipOnboardingResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingFieldSourcesCopyWith<$Res> get fieldSources {
  
  return $OnboardingFieldSourcesCopyWith<$Res>(_self.fieldSources, (value) {
    return _then(_self.copyWith(fieldSources: value));
  });
}
}

/// @nodoc


class SkipOnboardingExistingProfile implements SkipOnboardingResult {
  const SkipOnboardingExistingProfile();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipOnboardingExistingProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SkipOnboardingResult.existingProfile()';
}


}




// dart format on
