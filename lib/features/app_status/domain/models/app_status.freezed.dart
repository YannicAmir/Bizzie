// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppStatus()';
}


}

/// @nodoc
class $AppStatusCopyWith<$Res>  {
$AppStatusCopyWith(AppStatus _, $Res Function(AppStatus) __);
}


/// Adds pattern-matching-related methods to [AppStatus].
extension AppStatusPatterns on AppStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Normal value)?  normal,TResult Function( _ForceUpgrade value)?  forceUpgrade,TResult Function( _NoInternet value)?  noInternet,TResult Function( _Maintenance value)?  maintenance,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Normal() when normal != null:
return normal(_that);case _ForceUpgrade() when forceUpgrade != null:
return forceUpgrade(_that);case _NoInternet() when noInternet != null:
return noInternet(_that);case _Maintenance() when maintenance != null:
return maintenance(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Normal value)  normal,required TResult Function( _ForceUpgrade value)  forceUpgrade,required TResult Function( _NoInternet value)  noInternet,required TResult Function( _Maintenance value)  maintenance,}){
final _that = this;
switch (_that) {
case _Normal():
return normal(_that);case _ForceUpgrade():
return forceUpgrade(_that);case _NoInternet():
return noInternet(_that);case _Maintenance():
return maintenance(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Normal value)?  normal,TResult? Function( _ForceUpgrade value)?  forceUpgrade,TResult? Function( _NoInternet value)?  noInternet,TResult? Function( _Maintenance value)?  maintenance,}){
final _that = this;
switch (_that) {
case _Normal() when normal != null:
return normal(_that);case _ForceUpgrade() when forceUpgrade != null:
return forceUpgrade(_that);case _NoInternet() when noInternet != null:
return noInternet(_that);case _Maintenance() when maintenance != null:
return maintenance(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  normal,TResult Function( String minVersion,  String storeUrl)?  forceUpgrade,TResult Function()?  noInternet,TResult Function()?  maintenance,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Normal() when normal != null:
return normal();case _ForceUpgrade() when forceUpgrade != null:
return forceUpgrade(_that.minVersion,_that.storeUrl);case _NoInternet() when noInternet != null:
return noInternet();case _Maintenance() when maintenance != null:
return maintenance();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  normal,required TResult Function( String minVersion,  String storeUrl)  forceUpgrade,required TResult Function()  noInternet,required TResult Function()  maintenance,}) {final _that = this;
switch (_that) {
case _Normal():
return normal();case _ForceUpgrade():
return forceUpgrade(_that.minVersion,_that.storeUrl);case _NoInternet():
return noInternet();case _Maintenance():
return maintenance();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  normal,TResult? Function( String minVersion,  String storeUrl)?  forceUpgrade,TResult? Function()?  noInternet,TResult? Function()?  maintenance,}) {final _that = this;
switch (_that) {
case _Normal() when normal != null:
return normal();case _ForceUpgrade() when forceUpgrade != null:
return forceUpgrade(_that.minVersion,_that.storeUrl);case _NoInternet() when noInternet != null:
return noInternet();case _Maintenance() when maintenance != null:
return maintenance();case _:
  return null;

}
}

}

/// @nodoc


class _Normal implements AppStatus {
  const _Normal();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Normal);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppStatus.normal()';
}


}




/// @nodoc


class _ForceUpgrade implements AppStatus {
  const _ForceUpgrade({required this.minVersion, required this.storeUrl});
  

 final  String minVersion;
 final  String storeUrl;

/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForceUpgradeCopyWith<_ForceUpgrade> get copyWith => __$ForceUpgradeCopyWithImpl<_ForceUpgrade>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForceUpgrade&&(identical(other.minVersion, minVersion) || other.minVersion == minVersion)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl));
}


@override
int get hashCode => Object.hash(runtimeType,minVersion,storeUrl);

@override
String toString() {
  return 'AppStatus.forceUpgrade(minVersion: $minVersion, storeUrl: $storeUrl)';
}


}

/// @nodoc
abstract mixin class _$ForceUpgradeCopyWith<$Res> implements $AppStatusCopyWith<$Res> {
  factory _$ForceUpgradeCopyWith(_ForceUpgrade value, $Res Function(_ForceUpgrade) _then) = __$ForceUpgradeCopyWithImpl;
@useResult
$Res call({
 String minVersion, String storeUrl
});




}
/// @nodoc
class __$ForceUpgradeCopyWithImpl<$Res>
    implements _$ForceUpgradeCopyWith<$Res> {
  __$ForceUpgradeCopyWithImpl(this._self, this._then);

  final _ForceUpgrade _self;
  final $Res Function(_ForceUpgrade) _then;

/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minVersion = null,Object? storeUrl = null,}) {
  return _then(_ForceUpgrade(
minVersion: null == minVersion ? _self.minVersion : minVersion // ignore: cast_nullable_to_non_nullable
as String,storeUrl: null == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NoInternet implements AppStatus {
  const _NoInternet();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoInternet);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppStatus.noInternet()';
}


}




/// @nodoc


class _Maintenance implements AppStatus {
  const _Maintenance();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Maintenance);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppStatus.maintenance()';
}


}




// dart format on
