// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_offering.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionOffering {

 String get identifier; String get serverDescription; List<SubscriptionPackage> get availablePackages;
/// Create a copy of SubscriptionOffering
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionOfferingCopyWith<SubscriptionOffering> get copyWith => _$SubscriptionOfferingCopyWithImpl<SubscriptionOffering>(this as SubscriptionOffering, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionOffering&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.serverDescription, serverDescription) || other.serverDescription == serverDescription)&&const DeepCollectionEquality().equals(other.availablePackages, availablePackages));
}


@override
int get hashCode => Object.hash(runtimeType,identifier,serverDescription,const DeepCollectionEquality().hash(availablePackages));

@override
String toString() {
  return 'SubscriptionOffering(identifier: $identifier, serverDescription: $serverDescription, availablePackages: $availablePackages)';
}


}

/// @nodoc
abstract mixin class $SubscriptionOfferingCopyWith<$Res>  {
  factory $SubscriptionOfferingCopyWith(SubscriptionOffering value, $Res Function(SubscriptionOffering) _then) = _$SubscriptionOfferingCopyWithImpl;
@useResult
$Res call({
 String identifier, String serverDescription, List<SubscriptionPackage> availablePackages
});




}
/// @nodoc
class _$SubscriptionOfferingCopyWithImpl<$Res>
    implements $SubscriptionOfferingCopyWith<$Res> {
  _$SubscriptionOfferingCopyWithImpl(this._self, this._then);

  final SubscriptionOffering _self;
  final $Res Function(SubscriptionOffering) _then;

/// Create a copy of SubscriptionOffering
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? serverDescription = null,Object? availablePackages = null,}) {
  return _then(_self.copyWith(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,serverDescription: null == serverDescription ? _self.serverDescription : serverDescription // ignore: cast_nullable_to_non_nullable
as String,availablePackages: null == availablePackages ? _self.availablePackages : availablePackages // ignore: cast_nullable_to_non_nullable
as List<SubscriptionPackage>,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionOffering].
extension SubscriptionOfferingPatterns on SubscriptionOffering {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionOffering value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionOffering() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionOffering value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionOffering():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionOffering value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionOffering() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identifier,  String serverDescription,  List<SubscriptionPackage> availablePackages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionOffering() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identifier,  String serverDescription,  List<SubscriptionPackage> availablePackages)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionOffering():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identifier,  String serverDescription,  List<SubscriptionPackage> availablePackages)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionOffering() when $default != null:
return $default(_that.identifier,_that.serverDescription,_that.availablePackages);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionOffering extends SubscriptionOffering {
  const _SubscriptionOffering({required this.identifier, required this.serverDescription, required final  List<SubscriptionPackage> availablePackages}): _availablePackages = availablePackages,super._();
  

@override final  String identifier;
@override final  String serverDescription;
 final  List<SubscriptionPackage> _availablePackages;
@override List<SubscriptionPackage> get availablePackages {
  if (_availablePackages is EqualUnmodifiableListView) return _availablePackages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePackages);
}


/// Create a copy of SubscriptionOffering
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionOfferingCopyWith<_SubscriptionOffering> get copyWith => __$SubscriptionOfferingCopyWithImpl<_SubscriptionOffering>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionOffering&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.serverDescription, serverDescription) || other.serverDescription == serverDescription)&&const DeepCollectionEquality().equals(other._availablePackages, _availablePackages));
}


@override
int get hashCode => Object.hash(runtimeType,identifier,serverDescription,const DeepCollectionEquality().hash(_availablePackages));

@override
String toString() {
  return 'SubscriptionOffering(identifier: $identifier, serverDescription: $serverDescription, availablePackages: $availablePackages)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionOfferingCopyWith<$Res> implements $SubscriptionOfferingCopyWith<$Res> {
  factory _$SubscriptionOfferingCopyWith(_SubscriptionOffering value, $Res Function(_SubscriptionOffering) _then) = __$SubscriptionOfferingCopyWithImpl;
@override @useResult
$Res call({
 String identifier, String serverDescription, List<SubscriptionPackage> availablePackages
});




}
/// @nodoc
class __$SubscriptionOfferingCopyWithImpl<$Res>
    implements _$SubscriptionOfferingCopyWith<$Res> {
  __$SubscriptionOfferingCopyWithImpl(this._self, this._then);

  final _SubscriptionOffering _self;
  final $Res Function(_SubscriptionOffering) _then;

/// Create a copy of SubscriptionOffering
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? serverDescription = null,Object? availablePackages = null,}) {
  return _then(_SubscriptionOffering(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,serverDescription: null == serverDescription ? _self.serverDescription : serverDescription // ignore: cast_nullable_to_non_nullable
as String,availablePackages: null == availablePackages ? _self._availablePackages : availablePackages // ignore: cast_nullable_to_non_nullable
as List<SubscriptionPackage>,
  ));
}


}

// dart format on
