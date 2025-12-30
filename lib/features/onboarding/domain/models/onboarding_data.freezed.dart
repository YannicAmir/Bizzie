// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingData {

 String get firstName; String get selectedSector; String get rawBrandsText; List<Company> get detectedCompanies; InvestingExperience get investingExperience;
/// Create a copy of OnboardingData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<OnboardingData> get copyWith => _$OnboardingDataCopyWithImpl<OnboardingData>(this as OnboardingData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingData&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.selectedSector, selectedSector) || other.selectedSector == selectedSector)&&(identical(other.rawBrandsText, rawBrandsText) || other.rawBrandsText == rawBrandsText)&&const DeepCollectionEquality().equals(other.detectedCompanies, detectedCompanies)&&(identical(other.investingExperience, investingExperience) || other.investingExperience == investingExperience));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,selectedSector,rawBrandsText,const DeepCollectionEquality().hash(detectedCompanies),investingExperience);

@override
String toString() {
  return 'OnboardingData(firstName: $firstName, selectedSector: $selectedSector, rawBrandsText: $rawBrandsText, detectedCompanies: $detectedCompanies, investingExperience: $investingExperience)';
}


}

/// @nodoc
abstract mixin class $OnboardingDataCopyWith<$Res>  {
  factory $OnboardingDataCopyWith(OnboardingData value, $Res Function(OnboardingData) _then) = _$OnboardingDataCopyWithImpl;
@useResult
$Res call({
 String firstName, String selectedSector, String rawBrandsText, List<Company> detectedCompanies, InvestingExperience investingExperience
});




}
/// @nodoc
class _$OnboardingDataCopyWithImpl<$Res>
    implements $OnboardingDataCopyWith<$Res> {
  _$OnboardingDataCopyWithImpl(this._self, this._then);

  final OnboardingData _self;
  final $Res Function(OnboardingData) _then;

/// Create a copy of OnboardingData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? selectedSector = null,Object? rawBrandsText = null,Object? detectedCompanies = null,Object? investingExperience = null,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,selectedSector: null == selectedSector ? _self.selectedSector : selectedSector // ignore: cast_nullable_to_non_nullable
as String,rawBrandsText: null == rawBrandsText ? _self.rawBrandsText : rawBrandsText // ignore: cast_nullable_to_non_nullable
as String,detectedCompanies: null == detectedCompanies ? _self.detectedCompanies : detectedCompanies // ignore: cast_nullable_to_non_nullable
as List<Company>,investingExperience: null == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as InvestingExperience,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingData].
extension OnboardingDataPatterns on OnboardingData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingData value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingData():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingData value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String selectedSector,  String rawBrandsText,  List<Company> detectedCompanies,  InvestingExperience investingExperience)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingData() when $default != null:
return $default(_that.firstName,_that.selectedSector,_that.rawBrandsText,_that.detectedCompanies,_that.investingExperience);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String selectedSector,  String rawBrandsText,  List<Company> detectedCompanies,  InvestingExperience investingExperience)  $default,) {final _that = this;
switch (_that) {
case _OnboardingData():
return $default(_that.firstName,_that.selectedSector,_that.rawBrandsText,_that.detectedCompanies,_that.investingExperience);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String selectedSector,  String rawBrandsText,  List<Company> detectedCompanies,  InvestingExperience investingExperience)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingData() when $default != null:
return $default(_that.firstName,_that.selectedSector,_that.rawBrandsText,_that.detectedCompanies,_that.investingExperience);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingData implements OnboardingData {
  const _OnboardingData({this.firstName = '', this.selectedSector = '', this.rawBrandsText = '', final  List<Company> detectedCompanies = const [], this.investingExperience = InvestingExperience.beginner}): _detectedCompanies = detectedCompanies;
  

@override@JsonKey() final  String firstName;
@override@JsonKey() final  String selectedSector;
@override@JsonKey() final  String rawBrandsText;
 final  List<Company> _detectedCompanies;
@override@JsonKey() List<Company> get detectedCompanies {
  if (_detectedCompanies is EqualUnmodifiableListView) return _detectedCompanies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_detectedCompanies);
}

@override@JsonKey() final  InvestingExperience investingExperience;

/// Create a copy of OnboardingData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingDataCopyWith<_OnboardingData> get copyWith => __$OnboardingDataCopyWithImpl<_OnboardingData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingData&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.selectedSector, selectedSector) || other.selectedSector == selectedSector)&&(identical(other.rawBrandsText, rawBrandsText) || other.rawBrandsText == rawBrandsText)&&const DeepCollectionEquality().equals(other._detectedCompanies, _detectedCompanies)&&(identical(other.investingExperience, investingExperience) || other.investingExperience == investingExperience));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,selectedSector,rawBrandsText,const DeepCollectionEquality().hash(_detectedCompanies),investingExperience);

@override
String toString() {
  return 'OnboardingData(firstName: $firstName, selectedSector: $selectedSector, rawBrandsText: $rawBrandsText, detectedCompanies: $detectedCompanies, investingExperience: $investingExperience)';
}


}

/// @nodoc
abstract mixin class _$OnboardingDataCopyWith<$Res> implements $OnboardingDataCopyWith<$Res> {
  factory _$OnboardingDataCopyWith(_OnboardingData value, $Res Function(_OnboardingData) _then) = __$OnboardingDataCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String selectedSector, String rawBrandsText, List<Company> detectedCompanies, InvestingExperience investingExperience
});




}
/// @nodoc
class __$OnboardingDataCopyWithImpl<$Res>
    implements _$OnboardingDataCopyWith<$Res> {
  __$OnboardingDataCopyWithImpl(this._self, this._then);

  final _OnboardingData _self;
  final $Res Function(_OnboardingData) _then;

/// Create a copy of OnboardingData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? selectedSector = null,Object? rawBrandsText = null,Object? detectedCompanies = null,Object? investingExperience = null,}) {
  return _then(_OnboardingData(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,selectedSector: null == selectedSector ? _self.selectedSector : selectedSector // ignore: cast_nullable_to_non_nullable
as String,rawBrandsText: null == rawBrandsText ? _self.rawBrandsText : rawBrandsText // ignore: cast_nullable_to_non_nullable
as String,detectedCompanies: null == detectedCompanies ? _self._detectedCompanies : detectedCompanies // ignore: cast_nullable_to_non_nullable
as List<Company>,investingExperience: null == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as InvestingExperience,
  ));
}


}

// dart format on
