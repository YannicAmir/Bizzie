// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_executive.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyExecutive {

 String get name; String get title; String? get gender; double? get totalPay; String? get currencyPay; int? get yearBorn;
/// Create a copy of CompanyExecutive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyExecutiveCopyWith<CompanyExecutive> get copyWith => _$CompanyExecutiveCopyWithImpl<CompanyExecutive>(this as CompanyExecutive, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyExecutive&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.totalPay, totalPay) || other.totalPay == totalPay)&&(identical(other.currencyPay, currencyPay) || other.currencyPay == currencyPay)&&(identical(other.yearBorn, yearBorn) || other.yearBorn == yearBorn));
}


@override
int get hashCode => Object.hash(runtimeType,name,title,gender,totalPay,currencyPay,yearBorn);

@override
String toString() {
  return 'CompanyExecutive(name: $name, title: $title, gender: $gender, totalPay: $totalPay, currencyPay: $currencyPay, yearBorn: $yearBorn)';
}


}

/// @nodoc
abstract mixin class $CompanyExecutiveCopyWith<$Res>  {
  factory $CompanyExecutiveCopyWith(CompanyExecutive value, $Res Function(CompanyExecutive) _then) = _$CompanyExecutiveCopyWithImpl;
@useResult
$Res call({
 String name, String title, String? gender, double? totalPay, String? currencyPay, int? yearBorn
});




}
/// @nodoc
class _$CompanyExecutiveCopyWithImpl<$Res>
    implements $CompanyExecutiveCopyWith<$Res> {
  _$CompanyExecutiveCopyWithImpl(this._self, this._then);

  final CompanyExecutive _self;
  final $Res Function(CompanyExecutive) _then;

/// Create a copy of CompanyExecutive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? title = null,Object? gender = freezed,Object? totalPay = freezed,Object? currencyPay = freezed,Object? yearBorn = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,totalPay: freezed == totalPay ? _self.totalPay : totalPay // ignore: cast_nullable_to_non_nullable
as double?,currencyPay: freezed == currencyPay ? _self.currencyPay : currencyPay // ignore: cast_nullable_to_non_nullable
as String?,yearBorn: freezed == yearBorn ? _self.yearBorn : yearBorn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyExecutive].
extension CompanyExecutivePatterns on CompanyExecutive {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyExecutive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyExecutive() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyExecutive value)  $default,){
final _that = this;
switch (_that) {
case _CompanyExecutive():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyExecutive value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyExecutive() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String title,  String? gender,  double? totalPay,  String? currencyPay,  int? yearBorn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyExecutive() when $default != null:
return $default(_that.name,_that.title,_that.gender,_that.totalPay,_that.currencyPay,_that.yearBorn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String title,  String? gender,  double? totalPay,  String? currencyPay,  int? yearBorn)  $default,) {final _that = this;
switch (_that) {
case _CompanyExecutive():
return $default(_that.name,_that.title,_that.gender,_that.totalPay,_that.currencyPay,_that.yearBorn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String title,  String? gender,  double? totalPay,  String? currencyPay,  int? yearBorn)?  $default,) {final _that = this;
switch (_that) {
case _CompanyExecutive() when $default != null:
return $default(_that.name,_that.title,_that.gender,_that.totalPay,_that.currencyPay,_that.yearBorn);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyExecutive implements CompanyExecutive {
  const _CompanyExecutive({required this.name, required this.title, this.gender, this.totalPay, this.currencyPay, this.yearBorn});
  

@override final  String name;
@override final  String title;
@override final  String? gender;
@override final  double? totalPay;
@override final  String? currencyPay;
@override final  int? yearBorn;

/// Create a copy of CompanyExecutive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyExecutiveCopyWith<_CompanyExecutive> get copyWith => __$CompanyExecutiveCopyWithImpl<_CompanyExecutive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyExecutive&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.totalPay, totalPay) || other.totalPay == totalPay)&&(identical(other.currencyPay, currencyPay) || other.currencyPay == currencyPay)&&(identical(other.yearBorn, yearBorn) || other.yearBorn == yearBorn));
}


@override
int get hashCode => Object.hash(runtimeType,name,title,gender,totalPay,currencyPay,yearBorn);

@override
String toString() {
  return 'CompanyExecutive(name: $name, title: $title, gender: $gender, totalPay: $totalPay, currencyPay: $currencyPay, yearBorn: $yearBorn)';
}


}

/// @nodoc
abstract mixin class _$CompanyExecutiveCopyWith<$Res> implements $CompanyExecutiveCopyWith<$Res> {
  factory _$CompanyExecutiveCopyWith(_CompanyExecutive value, $Res Function(_CompanyExecutive) _then) = __$CompanyExecutiveCopyWithImpl;
@override @useResult
$Res call({
 String name, String title, String? gender, double? totalPay, String? currencyPay, int? yearBorn
});




}
/// @nodoc
class __$CompanyExecutiveCopyWithImpl<$Res>
    implements _$CompanyExecutiveCopyWith<$Res> {
  __$CompanyExecutiveCopyWithImpl(this._self, this._then);

  final _CompanyExecutive _self;
  final $Res Function(_CompanyExecutive) _then;

/// Create a copy of CompanyExecutive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? title = null,Object? gender = freezed,Object? totalPay = freezed,Object? currencyPay = freezed,Object? yearBorn = freezed,}) {
  return _then(_CompanyExecutive(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,totalPay: freezed == totalPay ? _self.totalPay : totalPay // ignore: cast_nullable_to_non_nullable
as double?,currencyPay: freezed == currencyPay ? _self.currencyPay : currencyPay // ignore: cast_nullable_to_non_nullable
as String?,yearBorn: freezed == yearBorn ? _self.yearBorn : yearBorn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
