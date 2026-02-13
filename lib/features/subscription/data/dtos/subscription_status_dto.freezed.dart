// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_status_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionStatusDto implements DiagnosticableTreeMixin {

 bool get isSubscribed; Set<String> get activeEntitlements; Set<String> get activeProductIds; DateTime? get expirationDate; DateTime? get latestPurchaseDate; String? get managementURL; String? get periodType; String? get activePlanId;
/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusDtoCopyWith<SubscriptionStatusDto> get copyWith => _$SubscriptionStatusDtoCopyWithImpl<SubscriptionStatusDto>(this as SubscriptionStatusDto, _$identity);

  /// Serializes this SubscriptionStatusDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SubscriptionStatusDto'))
    ..add(DiagnosticsProperty('isSubscribed', isSubscribed))..add(DiagnosticsProperty('activeEntitlements', activeEntitlements))..add(DiagnosticsProperty('activeProductIds', activeProductIds))..add(DiagnosticsProperty('expirationDate', expirationDate))..add(DiagnosticsProperty('latestPurchaseDate', latestPurchaseDate))..add(DiagnosticsProperty('managementURL', managementURL))..add(DiagnosticsProperty('periodType', periodType))..add(DiagnosticsProperty('activePlanId', activePlanId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusDto&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other.activeEntitlements, activeEntitlements)&&const DeepCollectionEquality().equals(other.activeProductIds, activeProductIds)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.latestPurchaseDate, latestPurchaseDate) || other.latestPurchaseDate == latestPurchaseDate)&&(identical(other.managementURL, managementURL) || other.managementURL == managementURL)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.activePlanId, activePlanId) || other.activePlanId == activePlanId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSubscribed,const DeepCollectionEquality().hash(activeEntitlements),const DeepCollectionEquality().hash(activeProductIds),expirationDate,latestPurchaseDate,managementURL,periodType,activePlanId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SubscriptionStatusDto(isSubscribed: $isSubscribed, activeEntitlements: $activeEntitlements, activeProductIds: $activeProductIds, expirationDate: $expirationDate, latestPurchaseDate: $latestPurchaseDate, managementURL: $managementURL, periodType: $periodType, activePlanId: $activePlanId)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusDtoCopyWith<$Res>  {
  factory $SubscriptionStatusDtoCopyWith(SubscriptionStatusDto value, $Res Function(SubscriptionStatusDto) _then) = _$SubscriptionStatusDtoCopyWithImpl;
@useResult
$Res call({
 bool isSubscribed, Set<String> activeEntitlements, Set<String> activeProductIds, DateTime? expirationDate, DateTime? latestPurchaseDate, String? managementURL, String? periodType, String? activePlanId
});




}
/// @nodoc
class _$SubscriptionStatusDtoCopyWithImpl<$Res>
    implements $SubscriptionStatusDtoCopyWith<$Res> {
  _$SubscriptionStatusDtoCopyWithImpl(this._self, this._then);

  final SubscriptionStatusDto _self;
  final $Res Function(SubscriptionStatusDto) _then;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSubscribed = null,Object? activeEntitlements = null,Object? activeProductIds = null,Object? expirationDate = freezed,Object? latestPurchaseDate = freezed,Object? managementURL = freezed,Object? periodType = freezed,Object? activePlanId = freezed,}) {
  return _then(_self.copyWith(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,activeEntitlements: null == activeEntitlements ? _self.activeEntitlements : activeEntitlements // ignore: cast_nullable_to_non_nullable
as Set<String>,activeProductIds: null == activeProductIds ? _self.activeProductIds : activeProductIds // ignore: cast_nullable_to_non_nullable
as Set<String>,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,latestPurchaseDate: freezed == latestPurchaseDate ? _self.latestPurchaseDate : latestPurchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,managementURL: freezed == managementURL ? _self.managementURL : managementURL // ignore: cast_nullable_to_non_nullable
as String?,periodType: freezed == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String?,activePlanId: freezed == activePlanId ? _self.activePlanId : activePlanId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionStatusDto].
extension SubscriptionStatusDtoPatterns on SubscriptionStatusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionStatusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionStatusDto value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionStatusDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSubscribed,  Set<String> activeEntitlements,  Set<String> activeProductIds,  DateTime? expirationDate,  DateTime? latestPurchaseDate,  String? managementURL,  String? periodType,  String? activePlanId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
return $default(_that.isSubscribed,_that.activeEntitlements,_that.activeProductIds,_that.expirationDate,_that.latestPurchaseDate,_that.managementURL,_that.periodType,_that.activePlanId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSubscribed,  Set<String> activeEntitlements,  Set<String> activeProductIds,  DateTime? expirationDate,  DateTime? latestPurchaseDate,  String? managementURL,  String? periodType,  String? activePlanId)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto():
return $default(_that.isSubscribed,_that.activeEntitlements,_that.activeProductIds,_that.expirationDate,_that.latestPurchaseDate,_that.managementURL,_that.periodType,_that.activePlanId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSubscribed,  Set<String> activeEntitlements,  Set<String> activeProductIds,  DateTime? expirationDate,  DateTime? latestPurchaseDate,  String? managementURL,  String? periodType,  String? activePlanId)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
return $default(_that.isSubscribed,_that.activeEntitlements,_that.activeProductIds,_that.expirationDate,_that.latestPurchaseDate,_that.managementURL,_that.periodType,_that.activePlanId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionStatusDto extends SubscriptionStatusDto with DiagnosticableTreeMixin {
  const _SubscriptionStatusDto({required this.isSubscribed, required final  Set<String> activeEntitlements, required final  Set<String> activeProductIds, this.expirationDate, this.latestPurchaseDate, this.managementURL, this.periodType, this.activePlanId}): _activeEntitlements = activeEntitlements,_activeProductIds = activeProductIds,super._();
  factory _SubscriptionStatusDto.fromJson(Map<String, dynamic> json) => _$SubscriptionStatusDtoFromJson(json);

@override final  bool isSubscribed;
 final  Set<String> _activeEntitlements;
@override Set<String> get activeEntitlements {
  if (_activeEntitlements is EqualUnmodifiableSetView) return _activeEntitlements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_activeEntitlements);
}

 final  Set<String> _activeProductIds;
@override Set<String> get activeProductIds {
  if (_activeProductIds is EqualUnmodifiableSetView) return _activeProductIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_activeProductIds);
}

@override final  DateTime? expirationDate;
@override final  DateTime? latestPurchaseDate;
@override final  String? managementURL;
@override final  String? periodType;
@override final  String? activePlanId;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStatusDtoCopyWith<_SubscriptionStatusDto> get copyWith => __$SubscriptionStatusDtoCopyWithImpl<_SubscriptionStatusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionStatusDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SubscriptionStatusDto'))
    ..add(DiagnosticsProperty('isSubscribed', isSubscribed))..add(DiagnosticsProperty('activeEntitlements', activeEntitlements))..add(DiagnosticsProperty('activeProductIds', activeProductIds))..add(DiagnosticsProperty('expirationDate', expirationDate))..add(DiagnosticsProperty('latestPurchaseDate', latestPurchaseDate))..add(DiagnosticsProperty('managementURL', managementURL))..add(DiagnosticsProperty('periodType', periodType))..add(DiagnosticsProperty('activePlanId', activePlanId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionStatusDto&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other._activeEntitlements, _activeEntitlements)&&const DeepCollectionEquality().equals(other._activeProductIds, _activeProductIds)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.latestPurchaseDate, latestPurchaseDate) || other.latestPurchaseDate == latestPurchaseDate)&&(identical(other.managementURL, managementURL) || other.managementURL == managementURL)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.activePlanId, activePlanId) || other.activePlanId == activePlanId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSubscribed,const DeepCollectionEquality().hash(_activeEntitlements),const DeepCollectionEquality().hash(_activeProductIds),expirationDate,latestPurchaseDate,managementURL,periodType,activePlanId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SubscriptionStatusDto(isSubscribed: $isSubscribed, activeEntitlements: $activeEntitlements, activeProductIds: $activeProductIds, expirationDate: $expirationDate, latestPurchaseDate: $latestPurchaseDate, managementURL: $managementURL, periodType: $periodType, activePlanId: $activePlanId)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStatusDtoCopyWith<$Res> implements $SubscriptionStatusDtoCopyWith<$Res> {
  factory _$SubscriptionStatusDtoCopyWith(_SubscriptionStatusDto value, $Res Function(_SubscriptionStatusDto) _then) = __$SubscriptionStatusDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isSubscribed, Set<String> activeEntitlements, Set<String> activeProductIds, DateTime? expirationDate, DateTime? latestPurchaseDate, String? managementURL, String? periodType, String? activePlanId
});




}
/// @nodoc
class __$SubscriptionStatusDtoCopyWithImpl<$Res>
    implements _$SubscriptionStatusDtoCopyWith<$Res> {
  __$SubscriptionStatusDtoCopyWithImpl(this._self, this._then);

  final _SubscriptionStatusDto _self;
  final $Res Function(_SubscriptionStatusDto) _then;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSubscribed = null,Object? activeEntitlements = null,Object? activeProductIds = null,Object? expirationDate = freezed,Object? latestPurchaseDate = freezed,Object? managementURL = freezed,Object? periodType = freezed,Object? activePlanId = freezed,}) {
  return _then(_SubscriptionStatusDto(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,activeEntitlements: null == activeEntitlements ? _self._activeEntitlements : activeEntitlements // ignore: cast_nullable_to_non_nullable
as Set<String>,activeProductIds: null == activeProductIds ? _self._activeProductIds : activeProductIds // ignore: cast_nullable_to_non_nullable
as Set<String>,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,latestPurchaseDate: freezed == latestPurchaseDate ? _self.latestPurchaseDate : latestPurchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,managementURL: freezed == managementURL ? _self.managementURL : managementURL // ignore: cast_nullable_to_non_nullable
as String?,periodType: freezed == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as String?,activePlanId: freezed == activePlanId ? _self.activePlanId : activePlanId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
