// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sec_filing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecFiling {

 String get date; String get year; String get period; String get link;
/// Create a copy of SecFiling
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecFilingCopyWith<SecFiling> get copyWith => _$SecFilingCopyWithImpl<SecFiling>(this as SecFiling, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecFiling&&(identical(other.date, date) || other.date == date)&&(identical(other.year, year) || other.year == year)&&(identical(other.period, period) || other.period == period)&&(identical(other.link, link) || other.link == link));
}


@override
int get hashCode => Object.hash(runtimeType,date,year,period,link);

@override
String toString() {
  return 'SecFiling(date: $date, year: $year, period: $period, link: $link)';
}


}

/// @nodoc
abstract mixin class $SecFilingCopyWith<$Res>  {
  factory $SecFilingCopyWith(SecFiling value, $Res Function(SecFiling) _then) = _$SecFilingCopyWithImpl;
@useResult
$Res call({
 String date, String year, String period, String link
});




}
/// @nodoc
class _$SecFilingCopyWithImpl<$Res>
    implements $SecFilingCopyWith<$Res> {
  _$SecFilingCopyWithImpl(this._self, this._then);

  final SecFiling _self;
  final $Res Function(SecFiling) _then;

/// Create a copy of SecFiling
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? year = null,Object? period = null,Object? link = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SecFiling].
extension SecFilingPatterns on SecFiling {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecFiling value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecFiling() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecFiling value)  $default,){
final _that = this;
switch (_that) {
case _SecFiling():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecFiling value)?  $default,){
final _that = this;
switch (_that) {
case _SecFiling() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String year,  String period,  String link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecFiling() when $default != null:
return $default(_that.date,_that.year,_that.period,_that.link);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String year,  String period,  String link)  $default,) {final _that = this;
switch (_that) {
case _SecFiling():
return $default(_that.date,_that.year,_that.period,_that.link);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String year,  String period,  String link)?  $default,) {final _that = this;
switch (_that) {
case _SecFiling() when $default != null:
return $default(_that.date,_that.year,_that.period,_that.link);case _:
  return null;

}
}

}

/// @nodoc


class _SecFiling implements SecFiling {
  const _SecFiling({required this.date, required this.year, required this.period, required this.link});
  

@override final  String date;
@override final  String year;
@override final  String period;
@override final  String link;

/// Create a copy of SecFiling
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecFilingCopyWith<_SecFiling> get copyWith => __$SecFilingCopyWithImpl<_SecFiling>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecFiling&&(identical(other.date, date) || other.date == date)&&(identical(other.year, year) || other.year == year)&&(identical(other.period, period) || other.period == period)&&(identical(other.link, link) || other.link == link));
}


@override
int get hashCode => Object.hash(runtimeType,date,year,period,link);

@override
String toString() {
  return 'SecFiling(date: $date, year: $year, period: $period, link: $link)';
}


}

/// @nodoc
abstract mixin class _$SecFilingCopyWith<$Res> implements $SecFilingCopyWith<$Res> {
  factory _$SecFilingCopyWith(_SecFiling value, $Res Function(_SecFiling) _then) = __$SecFilingCopyWithImpl;
@override @useResult
$Res call({
 String date, String year, String period, String link
});




}
/// @nodoc
class __$SecFilingCopyWithImpl<$Res>
    implements _$SecFilingCopyWith<$Res> {
  __$SecFilingCopyWithImpl(this._self, this._then);

  final _SecFiling _self;
  final $Res Function(_SecFiling) _then;

/// Create a copy of SecFiling
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? year = null,Object? period = null,Object? link = null,}) {
  return _then(_SecFiling(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
