// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_offering_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionOfferingDto {

 String get identifier; String get serverDescription; List<SubscriptionPackageDto> get availablePackages;
/// Create a copy of SubscriptionOfferingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionOfferingDtoCopyWith<SubscriptionOfferingDto> get copyWith => _$SubscriptionOfferingDtoCopyWithImpl<SubscriptionOfferingDto>(this as SubscriptionOfferingDto, _$identity);

  /// Serializes this SubscriptionOfferingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionOfferingDto&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.serverDescription, serverDescription) || other.serverDescription == serverDescription)&&const DeepCollectionEquality().equals(other.availablePackages, availablePackages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier,serverDescription,const DeepCollectionEquality().hash(availablePackages));

@override
String toString() {
  return 'SubscriptionOfferingDto(identifier: $identifier, serverDescription: $serverDescription, availablePackages: $availablePackages)';
}


}

/// @nodoc
abstract mixin class $SubscriptionOfferingDtoCopyWith<$Res>  {
  factory $SubscriptionOfferingDtoCopyWith(SubscriptionOfferingDto value, $Res Function(SubscriptionOfferingDto) _then) = _$SubscriptionOfferingDtoCopyWithImpl;
@useResult
$Res call({
 String identifier, String serverDescription, List<SubscriptionPackageDto> availablePackages
});




}
/// @nodoc
class _$SubscriptionOfferingDtoCopyWithImpl<$Res>
    implements $SubscriptionOfferingDtoCopyWith<$Res> {
  _$SubscriptionOfferingDtoCopyWithImpl(this._self, this._then);

  final SubscriptionOfferingDto _self;
  final $Res Function(SubscriptionOfferingDto) _then;

/// Create a copy of SubscriptionOfferingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? serverDescription = null,Object? availablePackages = null,}) {
  return _then(_self.copyWith(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,serverDescription: null == serverDescription ? _self.serverDescription : serverDescription // ignore: cast_nullable_to_non_nullable
as String,availablePackages: null == availablePackages ? _self.availablePackages : availablePackages // ignore: cast_nullable_to_non_nullable
as List<SubscriptionPackageDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionOfferingDto].
extension SubscriptionOfferingDtoPatterns on SubscriptionOfferingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionOfferingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionOfferingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionOfferingDto value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionOfferingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionOfferingDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionOfferingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier,  String serverDescription,  List<SubscriptionPackageDto> availablePackages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionOfferingDto() when $default != null:
return $default(_that.identifier,_that.serverDescription,_that.availablePackages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier,  String serverDescription,  List<SubscriptionPackageDto> availablePackages)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionOfferingDto():
return $default(_that.identifier,_that.serverDescription,_that.availablePackages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier,  String serverDescription,  List<SubscriptionPackageDto> availablePackages)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionOfferingDto() when $default != null:
return $default(_that.identifier,_that.serverDescription,_that.availablePackages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionOfferingDto extends SubscriptionOfferingDto {
  const _SubscriptionOfferingDto({required this.identifier, required this.serverDescription, required final  List<SubscriptionPackageDto> availablePackages}): _availablePackages = availablePackages,super._();
  factory _SubscriptionOfferingDto.fromJson(Map<String, dynamic> json) => _$SubscriptionOfferingDtoFromJson(json);

@override final  String identifier;
@override final  String serverDescription;
 final  List<SubscriptionPackageDto> _availablePackages;
@override List<SubscriptionPackageDto> get availablePackages {
  if (_availablePackages is EqualUnmodifiableListView) return _availablePackages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePackages);
}


/// Create a copy of SubscriptionOfferingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionOfferingDtoCopyWith<_SubscriptionOfferingDto> get copyWith => __$SubscriptionOfferingDtoCopyWithImpl<_SubscriptionOfferingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionOfferingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionOfferingDto&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.serverDescription, serverDescription) || other.serverDescription == serverDescription)&&const DeepCollectionEquality().equals(other._availablePackages, _availablePackages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identifier,serverDescription,const DeepCollectionEquality().hash(_availablePackages));

@override
String toString() {
  return 'SubscriptionOfferingDto(identifier: $identifier, serverDescription: $serverDescription, availablePackages: $availablePackages)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionOfferingDtoCopyWith<$Res> implements $SubscriptionOfferingDtoCopyWith<$Res> {
  factory _$SubscriptionOfferingDtoCopyWith(_SubscriptionOfferingDto value, $Res Function(_SubscriptionOfferingDto) _then) = __$SubscriptionOfferingDtoCopyWithImpl;
@override @useResult
$Res call({
 String identifier, String serverDescription, List<SubscriptionPackageDto> availablePackages
});




}
/// @nodoc
class __$SubscriptionOfferingDtoCopyWithImpl<$Res>
    implements _$SubscriptionOfferingDtoCopyWith<$Res> {
  __$SubscriptionOfferingDtoCopyWithImpl(this._self, this._then);

  final _SubscriptionOfferingDto _self;
  final $Res Function(_SubscriptionOfferingDto) _then;

/// Create a copy of SubscriptionOfferingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? serverDescription = null,Object? availablePackages = null,}) {
  return _then(_SubscriptionOfferingDto(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,serverDescription: null == serverDescription ? _self.serverDescription : serverDescription // ignore: cast_nullable_to_non_nullable
as String,availablePackages: null == availablePackages ? _self._availablePackages : availablePackages // ignore: cast_nullable_to_non_nullable
as List<SubscriptionPackageDto>,
  ));
}


}

// dart format on
