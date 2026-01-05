// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDto {

 String get uid; String get name; String get favoriteSector;// ignore: invalid_annotation_target
@JsonKey(name: 'favoriteSectorDisplay') String? get favoriteSectorDisplay; List<Map<String, dynamic>> get watchlist; String get investingExperience;@TimestampConverter() DateTime get createdAt; bool get isSubscribed; Map<String, String> get fcmTokens;
/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDtoCopyWith<UserDto> get copyWith => _$UserDtoCopyWithImpl<UserDto>(this as UserDto, _$identity);

  /// Serializes this UserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDto&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&(identical(other.favoriteSectorDisplay, favoriteSectorDisplay) || other.favoriteSectorDisplay == favoriteSectorDisplay)&&const DeepCollectionEquality().equals(other.watchlist, watchlist)&&(identical(other.investingExperience, investingExperience) || other.investingExperience == investingExperience)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other.fcmTokens, fcmTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,name,favoriteSector,favoriteSectorDisplay,const DeepCollectionEquality().hash(watchlist),investingExperience,createdAt,isSubscribed,const DeepCollectionEquality().hash(fcmTokens));

@override
String toString() {
  return 'UserDto(uid: $uid, name: $name, favoriteSector: $favoriteSector, favoriteSectorDisplay: $favoriteSectorDisplay, watchlist: $watchlist, investingExperience: $investingExperience, createdAt: $createdAt, isSubscribed: $isSubscribed, fcmTokens: $fcmTokens)';
}


}

/// @nodoc
abstract mixin class $UserDtoCopyWith<$Res>  {
  factory $UserDtoCopyWith(UserDto value, $Res Function(UserDto) _then) = _$UserDtoCopyWithImpl;
@useResult
$Res call({
 String uid, String name, String favoriteSector,@JsonKey(name: 'favoriteSectorDisplay') String? favoriteSectorDisplay, List<Map<String, dynamic>> watchlist, String investingExperience,@TimestampConverter() DateTime createdAt, bool isSubscribed, Map<String, String> fcmTokens
});




}
/// @nodoc
class _$UserDtoCopyWithImpl<$Res>
    implements $UserDtoCopyWith<$Res> {
  _$UserDtoCopyWithImpl(this._self, this._then);

  final UserDto _self;
  final $Res Function(UserDto) _then;

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? name = null,Object? favoriteSector = null,Object? favoriteSectorDisplay = freezed,Object? watchlist = null,Object? investingExperience = null,Object? createdAt = null,Object? isSubscribed = null,Object? fcmTokens = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,favoriteSector: null == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String,favoriteSectorDisplay: freezed == favoriteSectorDisplay ? _self.favoriteSectorDisplay : favoriteSectorDisplay // ignore: cast_nullable_to_non_nullable
as String?,watchlist: null == watchlist ? _self.watchlist : watchlist // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,investingExperience: null == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,fcmTokens: null == fcmTokens ? _self.fcmTokens : fcmTokens // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserDto].
extension UserDtoPatterns on UserDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDto value)  $default,){
final _that = this;
switch (_that) {
case _UserDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String name,  String favoriteSector, @JsonKey(name: 'favoriteSectorDisplay')  String? favoriteSectorDisplay,  List<Map<String, dynamic>> watchlist,  String investingExperience, @TimestampConverter()  DateTime createdAt,  bool isSubscribed,  Map<String, String> fcmTokens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDto() when $default != null:
return $default(_that.uid,_that.name,_that.favoriteSector,_that.favoriteSectorDisplay,_that.watchlist,_that.investingExperience,_that.createdAt,_that.isSubscribed,_that.fcmTokens);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String name,  String favoriteSector, @JsonKey(name: 'favoriteSectorDisplay')  String? favoriteSectorDisplay,  List<Map<String, dynamic>> watchlist,  String investingExperience, @TimestampConverter()  DateTime createdAt,  bool isSubscribed,  Map<String, String> fcmTokens)  $default,) {final _that = this;
switch (_that) {
case _UserDto():
return $default(_that.uid,_that.name,_that.favoriteSector,_that.favoriteSectorDisplay,_that.watchlist,_that.investingExperience,_that.createdAt,_that.isSubscribed,_that.fcmTokens);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String name,  String favoriteSector, @JsonKey(name: 'favoriteSectorDisplay')  String? favoriteSectorDisplay,  List<Map<String, dynamic>> watchlist,  String investingExperience, @TimestampConverter()  DateTime createdAt,  bool isSubscribed,  Map<String, String> fcmTokens)?  $default,) {final _that = this;
switch (_that) {
case _UserDto() when $default != null:
return $default(_that.uid,_that.name,_that.favoriteSector,_that.favoriteSectorDisplay,_that.watchlist,_that.investingExperience,_that.createdAt,_that.isSubscribed,_that.fcmTokens);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserDto extends UserDto {
  const _UserDto({required this.uid, required this.name, required this.favoriteSector, @JsonKey(name: 'favoriteSectorDisplay') this.favoriteSectorDisplay, required final  List<Map<String, dynamic>> watchlist, required this.investingExperience, @TimestampConverter() required this.createdAt, this.isSubscribed = false, required final  Map<String, String> fcmTokens}): _watchlist = watchlist,_fcmTokens = fcmTokens,super._();
  factory _UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

@override final  String uid;
@override final  String name;
@override final  String favoriteSector;
// ignore: invalid_annotation_target
@override@JsonKey(name: 'favoriteSectorDisplay') final  String? favoriteSectorDisplay;
 final  List<Map<String, dynamic>> _watchlist;
@override List<Map<String, dynamic>> get watchlist {
  if (_watchlist is EqualUnmodifiableListView) return _watchlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchlist);
}

@override final  String investingExperience;
@override@TimestampConverter() final  DateTime createdAt;
@override@JsonKey() final  bool isSubscribed;
 final  Map<String, String> _fcmTokens;
@override Map<String, String> get fcmTokens {
  if (_fcmTokens is EqualUnmodifiableMapView) return _fcmTokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fcmTokens);
}


/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDtoCopyWith<_UserDto> get copyWith => __$UserDtoCopyWithImpl<_UserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDto&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&(identical(other.favoriteSectorDisplay, favoriteSectorDisplay) || other.favoriteSectorDisplay == favoriteSectorDisplay)&&const DeepCollectionEquality().equals(other._watchlist, _watchlist)&&(identical(other.investingExperience, investingExperience) || other.investingExperience == investingExperience)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other._fcmTokens, _fcmTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,name,favoriteSector,favoriteSectorDisplay,const DeepCollectionEquality().hash(_watchlist),investingExperience,createdAt,isSubscribed,const DeepCollectionEquality().hash(_fcmTokens));

@override
String toString() {
  return 'UserDto(uid: $uid, name: $name, favoriteSector: $favoriteSector, favoriteSectorDisplay: $favoriteSectorDisplay, watchlist: $watchlist, investingExperience: $investingExperience, createdAt: $createdAt, isSubscribed: $isSubscribed, fcmTokens: $fcmTokens)';
}


}

/// @nodoc
abstract mixin class _$UserDtoCopyWith<$Res> implements $UserDtoCopyWith<$Res> {
  factory _$UserDtoCopyWith(_UserDto value, $Res Function(_UserDto) _then) = __$UserDtoCopyWithImpl;
@override @useResult
$Res call({
 String uid, String name, String favoriteSector,@JsonKey(name: 'favoriteSectorDisplay') String? favoriteSectorDisplay, List<Map<String, dynamic>> watchlist, String investingExperience,@TimestampConverter() DateTime createdAt, bool isSubscribed, Map<String, String> fcmTokens
});




}
/// @nodoc
class __$UserDtoCopyWithImpl<$Res>
    implements _$UserDtoCopyWith<$Res> {
  __$UserDtoCopyWithImpl(this._self, this._then);

  final _UserDto _self;
  final $Res Function(_UserDto) _then;

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? name = null,Object? favoriteSector = null,Object? favoriteSectorDisplay = freezed,Object? watchlist = null,Object? investingExperience = null,Object? createdAt = null,Object? isSubscribed = null,Object? fcmTokens = null,}) {
  return _then(_UserDto(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,favoriteSector: null == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String,favoriteSectorDisplay: freezed == favoriteSectorDisplay ? _self.favoriteSectorDisplay : favoriteSectorDisplay // ignore: cast_nullable_to_non_nullable
as String?,watchlist: null == watchlist ? _self._watchlist : watchlist // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,investingExperience: null == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,fcmTokens: null == fcmTokens ? _self._fcmTokens : fcmTokens // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
