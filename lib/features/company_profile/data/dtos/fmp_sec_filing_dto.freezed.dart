// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fmp_sec_filing_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FmpSecFilingDto {

 String? get symbol; String? get filingDate; String? get acceptedDate; String? get period; String? get formType;// "DEF 14A", "10-K" etc
 String? get link; String? get finalLink;
/// Create a copy of FmpSecFilingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FmpSecFilingDtoCopyWith<FmpSecFilingDto> get copyWith => _$FmpSecFilingDtoCopyWithImpl<FmpSecFilingDto>(this as FmpSecFilingDto, _$identity);

  /// Serializes this FmpSecFilingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FmpSecFilingDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.acceptedDate, acceptedDate) || other.acceptedDate == acceptedDate)&&(identical(other.period, period) || other.period == period)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.link, link) || other.link == link)&&(identical(other.finalLink, finalLink) || other.finalLink == finalLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,filingDate,acceptedDate,period,formType,link,finalLink);

@override
String toString() {
  return 'FmpSecFilingDto(symbol: $symbol, filingDate: $filingDate, acceptedDate: $acceptedDate, period: $period, formType: $formType, link: $link, finalLink: $finalLink)';
}


}

/// @nodoc
abstract mixin class $FmpSecFilingDtoCopyWith<$Res>  {
  factory $FmpSecFilingDtoCopyWith(FmpSecFilingDto value, $Res Function(FmpSecFilingDto) _then) = _$FmpSecFilingDtoCopyWithImpl;
@useResult
$Res call({
 String? symbol, String? filingDate, String? acceptedDate, String? period, String? formType, String? link, String? finalLink
});




}
/// @nodoc
class _$FmpSecFilingDtoCopyWithImpl<$Res>
    implements $FmpSecFilingDtoCopyWith<$Res> {
  _$FmpSecFilingDtoCopyWithImpl(this._self, this._then);

  final FmpSecFilingDto _self;
  final $Res Function(FmpSecFilingDto) _then;

/// Create a copy of FmpSecFilingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = freezed,Object? filingDate = freezed,Object? acceptedDate = freezed,Object? period = freezed,Object? formType = freezed,Object? link = freezed,Object? finalLink = freezed,}) {
  return _then(_self.copyWith(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,filingDate: freezed == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as String?,acceptedDate: freezed == acceptedDate ? _self.acceptedDate : acceptedDate // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,finalLink: freezed == finalLink ? _self.finalLink : finalLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FmpSecFilingDto].
extension FmpSecFilingDtoPatterns on FmpSecFilingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FmpSecFilingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FmpSecFilingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FmpSecFilingDto value)  $default,){
final _that = this;
switch (_that) {
case _FmpSecFilingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FmpSecFilingDto value)?  $default,){
final _that = this;
switch (_that) {
case _FmpSecFilingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? symbol,  String? filingDate,  String? acceptedDate,  String? period,  String? formType,  String? link,  String? finalLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FmpSecFilingDto() when $default != null:
return $default(_that.symbol,_that.filingDate,_that.acceptedDate,_that.period,_that.formType,_that.link,_that.finalLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? symbol,  String? filingDate,  String? acceptedDate,  String? period,  String? formType,  String? link,  String? finalLink)  $default,) {final _that = this;
switch (_that) {
case _FmpSecFilingDto():
return $default(_that.symbol,_that.filingDate,_that.acceptedDate,_that.period,_that.formType,_that.link,_that.finalLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? symbol,  String? filingDate,  String? acceptedDate,  String? period,  String? formType,  String? link,  String? finalLink)?  $default,) {final _that = this;
switch (_that) {
case _FmpSecFilingDto() when $default != null:
return $default(_that.symbol,_that.filingDate,_that.acceptedDate,_that.period,_that.formType,_that.link,_that.finalLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FmpSecFilingDto implements FmpSecFilingDto {
  const _FmpSecFilingDto({this.symbol, this.filingDate, this.acceptedDate, this.period, this.formType, this.link, this.finalLink});
  factory _FmpSecFilingDto.fromJson(Map<String, dynamic> json) => _$FmpSecFilingDtoFromJson(json);

@override final  String? symbol;
@override final  String? filingDate;
@override final  String? acceptedDate;
@override final  String? period;
@override final  String? formType;
// "DEF 14A", "10-K" etc
@override final  String? link;
@override final  String? finalLink;

/// Create a copy of FmpSecFilingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FmpSecFilingDtoCopyWith<_FmpSecFilingDto> get copyWith => __$FmpSecFilingDtoCopyWithImpl<_FmpSecFilingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FmpSecFilingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FmpSecFilingDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.acceptedDate, acceptedDate) || other.acceptedDate == acceptedDate)&&(identical(other.period, period) || other.period == period)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.link, link) || other.link == link)&&(identical(other.finalLink, finalLink) || other.finalLink == finalLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,filingDate,acceptedDate,period,formType,link,finalLink);

@override
String toString() {
  return 'FmpSecFilingDto(symbol: $symbol, filingDate: $filingDate, acceptedDate: $acceptedDate, period: $period, formType: $formType, link: $link, finalLink: $finalLink)';
}


}

/// @nodoc
abstract mixin class _$FmpSecFilingDtoCopyWith<$Res> implements $FmpSecFilingDtoCopyWith<$Res> {
  factory _$FmpSecFilingDtoCopyWith(_FmpSecFilingDto value, $Res Function(_FmpSecFilingDto) _then) = __$FmpSecFilingDtoCopyWithImpl;
@override @useResult
$Res call({
 String? symbol, String? filingDate, String? acceptedDate, String? period, String? formType, String? link, String? finalLink
});




}
/// @nodoc
class __$FmpSecFilingDtoCopyWithImpl<$Res>
    implements _$FmpSecFilingDtoCopyWith<$Res> {
  __$FmpSecFilingDtoCopyWithImpl(this._self, this._then);

  final _FmpSecFilingDto _self;
  final $Res Function(_FmpSecFilingDto) _then;

/// Create a copy of FmpSecFilingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = freezed,Object? filingDate = freezed,Object? acceptedDate = freezed,Object? period = freezed,Object? formType = freezed,Object? link = freezed,Object? finalLink = freezed,}) {
  return _then(_FmpSecFilingDto(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,filingDate: freezed == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as String?,acceptedDate: freezed == acceptedDate ? _self.acceptedDate : acceptedDate // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,finalLink: freezed == finalLink ? _self.finalLink : finalLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
