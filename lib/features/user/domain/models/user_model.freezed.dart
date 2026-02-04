// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get uid; String get name; String get favoriteSector; List<Company> get watchlist; InvestingExperience get investingExperience;@TimestampConverter() DateTime get createdAt; bool get isSubscribed; Map<String, String> get fcmTokens;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&const DeepCollectionEquality().equals(other.watchlist, watchlist)&&(identical(other.investingExperience, investingExperience) || other.investingExperience == investingExperience)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other.fcmTokens, fcmTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,name,favoriteSector,const DeepCollectionEquality().hash(watchlist),investingExperience,createdAt,isSubscribed,const DeepCollectionEquality().hash(fcmTokens));

@override
String toString() {
  return 'UserModel(uid: $uid, name: $name, favoriteSector: $favoriteSector, watchlist: $watchlist, investingExperience: $investingExperience, createdAt: $createdAt, isSubscribed: $isSubscribed, fcmTokens: $fcmTokens)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String uid, String name, String favoriteSector, List<Company> watchlist, InvestingExperience investingExperience,@TimestampConverter() DateTime createdAt, bool isSubscribed, Map<String, String> fcmTokens
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? name = null,Object? favoriteSector = null,Object? watchlist = null,Object? investingExperience = null,Object? createdAt = null,Object? isSubscribed = null,Object? fcmTokens = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,favoriteSector: null == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String,watchlist: null == watchlist ? _self.watchlist : watchlist // ignore: cast_nullable_to_non_nullable
as List<Company>,investingExperience: null == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as InvestingExperience,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,fcmTokens: null == fcmTokens ? _self.fcmTokens : fcmTokens // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String name,  String favoriteSector,  List<Company> watchlist,  InvestingExperience investingExperience, @TimestampConverter()  DateTime createdAt,  bool isSubscribed,  Map<String, String> fcmTokens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.uid,_that.name,_that.favoriteSector,_that.watchlist,_that.investingExperience,_that.createdAt,_that.isSubscribed,_that.fcmTokens);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String name,  String favoriteSector,  List<Company> watchlist,  InvestingExperience investingExperience, @TimestampConverter()  DateTime createdAt,  bool isSubscribed,  Map<String, String> fcmTokens)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.uid,_that.name,_that.favoriteSector,_that.watchlist,_that.investingExperience,_that.createdAt,_that.isSubscribed,_that.fcmTokens);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String name,  String favoriteSector,  List<Company> watchlist,  InvestingExperience investingExperience, @TimestampConverter()  DateTime createdAt,  bool isSubscribed,  Map<String, String> fcmTokens)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.uid,_that.name,_that.favoriteSector,_that.watchlist,_that.investingExperience,_that.createdAt,_that.isSubscribed,_that.fcmTokens);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.uid, required this.name, required this.favoriteSector, final  List<Company> watchlist = const [], required this.investingExperience, @TimestampConverter() required this.createdAt, required this.isSubscribed, final  Map<String, String> fcmTokens = const {}}): _watchlist = watchlist,_fcmTokens = fcmTokens;
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String uid;
@override final  String name;
@override final  String favoriteSector;
 final  List<Company> _watchlist;
@override@JsonKey() List<Company> get watchlist {
  if (_watchlist is EqualUnmodifiableListView) return _watchlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchlist);
}

@override final  InvestingExperience investingExperience;
@override@TimestampConverter() final  DateTime createdAt;
@override final  bool isSubscribed;
 final  Map<String, String> _fcmTokens;
@override@JsonKey() Map<String, String> get fcmTokens {
  if (_fcmTokens is EqualUnmodifiableMapView) return _fcmTokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fcmTokens);
}


/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&const DeepCollectionEquality().equals(other._watchlist, _watchlist)&&(identical(other.investingExperience, investingExperience) || other.investingExperience == investingExperience)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other._fcmTokens, _fcmTokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,name,favoriteSector,const DeepCollectionEquality().hash(_watchlist),investingExperience,createdAt,isSubscribed,const DeepCollectionEquality().hash(_fcmTokens));

@override
String toString() {
  return 'UserModel(uid: $uid, name: $name, favoriteSector: $favoriteSector, watchlist: $watchlist, investingExperience: $investingExperience, createdAt: $createdAt, isSubscribed: $isSubscribed, fcmTokens: $fcmTokens)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String uid, String name, String favoriteSector, List<Company> watchlist, InvestingExperience investingExperience,@TimestampConverter() DateTime createdAt, bool isSubscribed, Map<String, String> fcmTokens
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? name = null,Object? favoriteSector = null,Object? watchlist = null,Object? investingExperience = null,Object? createdAt = null,Object? isSubscribed = null,Object? fcmTokens = null,}) {
  return _then(_UserModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,favoriteSector: null == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String,watchlist: null == watchlist ? _self._watchlist : watchlist // ignore: cast_nullable_to_non_nullable
as List<Company>,investingExperience: null == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as InvestingExperience,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,fcmTokens: null == fcmTokens ? _self._fcmTokens : fcmTokens // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
