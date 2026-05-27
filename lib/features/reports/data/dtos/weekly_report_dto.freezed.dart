// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_report_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyReportDto {

@JsonKey(includeToJson: false) String? get id; String? get ticker; String? get companyName; String? get messageTitle; String? get messageShortSummary; String? get messageLongSummary; List<String>? get newsLinks; List<String>? get eightKLinks; Map<String, dynamic>? get priceMovement;@TimestampConverter() DateTime? get createdAt;
/// Create a copy of WeeklyReportDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyReportDtoCopyWith<WeeklyReportDto> get copyWith => _$WeeklyReportDtoCopyWithImpl<WeeklyReportDto>(this as WeeklyReportDto, _$identity);

  /// Serializes this WeeklyReportDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyReportDto&&(identical(other.id, id) || other.id == id)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.messageTitle, messageTitle) || other.messageTitle == messageTitle)&&(identical(other.messageShortSummary, messageShortSummary) || other.messageShortSummary == messageShortSummary)&&(identical(other.messageLongSummary, messageLongSummary) || other.messageLongSummary == messageLongSummary)&&const DeepCollectionEquality().equals(other.newsLinks, newsLinks)&&const DeepCollectionEquality().equals(other.eightKLinks, eightKLinks)&&const DeepCollectionEquality().equals(other.priceMovement, priceMovement)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticker,companyName,messageTitle,messageShortSummary,messageLongSummary,const DeepCollectionEquality().hash(newsLinks),const DeepCollectionEquality().hash(eightKLinks),const DeepCollectionEquality().hash(priceMovement),createdAt);

@override
String toString() {
  return 'WeeklyReportDto(id: $id, ticker: $ticker, companyName: $companyName, messageTitle: $messageTitle, messageShortSummary: $messageShortSummary, messageLongSummary: $messageLongSummary, newsLinks: $newsLinks, eightKLinks: $eightKLinks, priceMovement: $priceMovement, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WeeklyReportDtoCopyWith<$Res>  {
  factory $WeeklyReportDtoCopyWith(WeeklyReportDto value, $Res Function(WeeklyReportDto) _then) = _$WeeklyReportDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String? id, String? ticker, String? companyName, String? messageTitle, String? messageShortSummary, String? messageLongSummary, List<String>? newsLinks, List<String>? eightKLinks, Map<String, dynamic>? priceMovement,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class _$WeeklyReportDtoCopyWithImpl<$Res>
    implements $WeeklyReportDtoCopyWith<$Res> {
  _$WeeklyReportDtoCopyWithImpl(this._self, this._then);

  final WeeklyReportDto _self;
  final $Res Function(WeeklyReportDto) _then;

/// Create a copy of WeeklyReportDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? ticker = freezed,Object? companyName = freezed,Object? messageTitle = freezed,Object? messageShortSummary = freezed,Object? messageLongSummary = freezed,Object? newsLinks = freezed,Object? eightKLinks = freezed,Object? priceMovement = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,messageTitle: freezed == messageTitle ? _self.messageTitle : messageTitle // ignore: cast_nullable_to_non_nullable
as String?,messageShortSummary: freezed == messageShortSummary ? _self.messageShortSummary : messageShortSummary // ignore: cast_nullable_to_non_nullable
as String?,messageLongSummary: freezed == messageLongSummary ? _self.messageLongSummary : messageLongSummary // ignore: cast_nullable_to_non_nullable
as String?,newsLinks: freezed == newsLinks ? _self.newsLinks : newsLinks // ignore: cast_nullable_to_non_nullable
as List<String>?,eightKLinks: freezed == eightKLinks ? _self.eightKLinks : eightKLinks // ignore: cast_nullable_to_non_nullable
as List<String>?,priceMovement: freezed == priceMovement ? _self.priceMovement : priceMovement // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyReportDto].
extension WeeklyReportDtoPatterns on WeeklyReportDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyReportDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyReportDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyReportDto value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyReportDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyReportDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyReportDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String? id,  String? ticker,  String? companyName,  String? messageTitle,  String? messageShortSummary,  String? messageLongSummary,  List<String>? newsLinks,  List<String>? eightKLinks,  Map<String, dynamic>? priceMovement, @TimestampConverter()  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyReportDto() when $default != null:
return $default(_that.id,_that.ticker,_that.companyName,_that.messageTitle,_that.messageShortSummary,_that.messageLongSummary,_that.newsLinks,_that.eightKLinks,_that.priceMovement,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String? id,  String? ticker,  String? companyName,  String? messageTitle,  String? messageShortSummary,  String? messageLongSummary,  List<String>? newsLinks,  List<String>? eightKLinks,  Map<String, dynamic>? priceMovement, @TimestampConverter()  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _WeeklyReportDto():
return $default(_that.id,_that.ticker,_that.companyName,_that.messageTitle,_that.messageShortSummary,_that.messageLongSummary,_that.newsLinks,_that.eightKLinks,_that.priceMovement,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String? id,  String? ticker,  String? companyName,  String? messageTitle,  String? messageShortSummary,  String? messageLongSummary,  List<String>? newsLinks,  List<String>? eightKLinks,  Map<String, dynamic>? priceMovement, @TimestampConverter()  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyReportDto() when $default != null:
return $default(_that.id,_that.ticker,_that.companyName,_that.messageTitle,_that.messageShortSummary,_that.messageLongSummary,_that.newsLinks,_that.eightKLinks,_that.priceMovement,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WeeklyReportDto extends WeeklyReportDto {
  const _WeeklyReportDto({@JsonKey(includeToJson: false) this.id, this.ticker, this.companyName, this.messageTitle, this.messageShortSummary, this.messageLongSummary, final  List<String>? newsLinks, final  List<String>? eightKLinks, final  Map<String, dynamic>? priceMovement, @TimestampConverter() this.createdAt}): _newsLinks = newsLinks,_eightKLinks = eightKLinks,_priceMovement = priceMovement,super._();
  factory _WeeklyReportDto.fromJson(Map<String, dynamic> json) => _$WeeklyReportDtoFromJson(json);

@override@JsonKey(includeToJson: false) final  String? id;
@override final  String? ticker;
@override final  String? companyName;
@override final  String? messageTitle;
@override final  String? messageShortSummary;
@override final  String? messageLongSummary;
 final  List<String>? _newsLinks;
@override List<String>? get newsLinks {
  final value = _newsLinks;
  if (value == null) return null;
  if (_newsLinks is EqualUnmodifiableListView) return _newsLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _eightKLinks;
@override List<String>? get eightKLinks {
  final value = _eightKLinks;
  if (value == null) return null;
  if (_eightKLinks is EqualUnmodifiableListView) return _eightKLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _priceMovement;
@override Map<String, dynamic>? get priceMovement {
  final value = _priceMovement;
  if (value == null) return null;
  if (_priceMovement is EqualUnmodifiableMapView) return _priceMovement;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@TimestampConverter() final  DateTime? createdAt;

/// Create a copy of WeeklyReportDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyReportDtoCopyWith<_WeeklyReportDto> get copyWith => __$WeeklyReportDtoCopyWithImpl<_WeeklyReportDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyReportDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyReportDto&&(identical(other.id, id) || other.id == id)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.messageTitle, messageTitle) || other.messageTitle == messageTitle)&&(identical(other.messageShortSummary, messageShortSummary) || other.messageShortSummary == messageShortSummary)&&(identical(other.messageLongSummary, messageLongSummary) || other.messageLongSummary == messageLongSummary)&&const DeepCollectionEquality().equals(other._newsLinks, _newsLinks)&&const DeepCollectionEquality().equals(other._eightKLinks, _eightKLinks)&&const DeepCollectionEquality().equals(other._priceMovement, _priceMovement)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticker,companyName,messageTitle,messageShortSummary,messageLongSummary,const DeepCollectionEquality().hash(_newsLinks),const DeepCollectionEquality().hash(_eightKLinks),const DeepCollectionEquality().hash(_priceMovement),createdAt);

@override
String toString() {
  return 'WeeklyReportDto(id: $id, ticker: $ticker, companyName: $companyName, messageTitle: $messageTitle, messageShortSummary: $messageShortSummary, messageLongSummary: $messageLongSummary, newsLinks: $newsLinks, eightKLinks: $eightKLinks, priceMovement: $priceMovement, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WeeklyReportDtoCopyWith<$Res> implements $WeeklyReportDtoCopyWith<$Res> {
  factory _$WeeklyReportDtoCopyWith(_WeeklyReportDto value, $Res Function(_WeeklyReportDto) _then) = __$WeeklyReportDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String? id, String? ticker, String? companyName, String? messageTitle, String? messageShortSummary, String? messageLongSummary, List<String>? newsLinks, List<String>? eightKLinks, Map<String, dynamic>? priceMovement,@TimestampConverter() DateTime? createdAt
});




}
/// @nodoc
class __$WeeklyReportDtoCopyWithImpl<$Res>
    implements _$WeeklyReportDtoCopyWith<$Res> {
  __$WeeklyReportDtoCopyWithImpl(this._self, this._then);

  final _WeeklyReportDto _self;
  final $Res Function(_WeeklyReportDto) _then;

/// Create a copy of WeeklyReportDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? ticker = freezed,Object? companyName = freezed,Object? messageTitle = freezed,Object? messageShortSummary = freezed,Object? messageLongSummary = freezed,Object? newsLinks = freezed,Object? eightKLinks = freezed,Object? priceMovement = freezed,Object? createdAt = freezed,}) {
  return _then(_WeeklyReportDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,messageTitle: freezed == messageTitle ? _self.messageTitle : messageTitle // ignore: cast_nullable_to_non_nullable
as String?,messageShortSummary: freezed == messageShortSummary ? _self.messageShortSummary : messageShortSummary // ignore: cast_nullable_to_non_nullable
as String?,messageLongSummary: freezed == messageLongSummary ? _self.messageLongSummary : messageLongSummary // ignore: cast_nullable_to_non_nullable
as String?,newsLinks: freezed == newsLinks ? _self._newsLinks : newsLinks // ignore: cast_nullable_to_non_nullable
as List<String>?,eightKLinks: freezed == eightKLinks ? _self._eightKLinks : eightKLinks // ignore: cast_nullable_to_non_nullable
as List<String>?,priceMovement: freezed == priceMovement ? _self._priceMovement : priceMovement // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
