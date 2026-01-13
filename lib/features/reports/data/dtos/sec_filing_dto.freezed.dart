// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sec_filing_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SecFilingDto {

@JsonKey(includeFromJson: false, includeToJson: false) String? get id; String get symbol; String get companyName; String get filingDate; String get formType; String get link; String get summary;@ForceDoubleNullable() double? get eps;@ForceDoubleNullable() double? get revenue; String? get sentiment; String? get topic; bool get isEarnings; Object? get createdAt; Object? get analyzedAt; String? get deepAnalysisId; String? get deepAnalysisStatus;
/// Create a copy of SecFilingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecFilingDtoCopyWith<SecFilingDto> get copyWith => _$SecFilingDtoCopyWithImpl<SecFilingDto>(this as SecFilingDto, _$identity);

  /// Serializes this SecFilingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecFilingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.link, link) || other.link == link)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.sentiment, sentiment) || other.sentiment == sentiment)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.isEarnings, isEarnings) || other.isEarnings == isEarnings)&&const DeepCollectionEquality().equals(other.createdAt, createdAt)&&const DeepCollectionEquality().equals(other.analyzedAt, analyzedAt)&&(identical(other.deepAnalysisId, deepAnalysisId) || other.deepAnalysisId == deepAnalysisId)&&(identical(other.deepAnalysisStatus, deepAnalysisStatus) || other.deepAnalysisStatus == deepAnalysisStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,symbol,companyName,filingDate,formType,link,summary,eps,revenue,sentiment,topic,isEarnings,const DeepCollectionEquality().hash(createdAt),const DeepCollectionEquality().hash(analyzedAt),deepAnalysisId,deepAnalysisStatus);

@override
String toString() {
  return 'SecFilingDto(id: $id, symbol: $symbol, companyName: $companyName, filingDate: $filingDate, formType: $formType, link: $link, summary: $summary, eps: $eps, revenue: $revenue, sentiment: $sentiment, topic: $topic, isEarnings: $isEarnings, createdAt: $createdAt, analyzedAt: $analyzedAt, deepAnalysisId: $deepAnalysisId, deepAnalysisStatus: $deepAnalysisStatus)';
}


}

/// @nodoc
abstract mixin class $SecFilingDtoCopyWith<$Res>  {
  factory $SecFilingDtoCopyWith(SecFilingDto value, $Res Function(SecFilingDto) _then) = _$SecFilingDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String symbol, String companyName, String filingDate, String formType, String link, String summary,@ForceDoubleNullable() double? eps,@ForceDoubleNullable() double? revenue, String? sentiment, String? topic, bool isEarnings, Object? createdAt, Object? analyzedAt, String? deepAnalysisId, String? deepAnalysisStatus
});




}
/// @nodoc
class _$SecFilingDtoCopyWithImpl<$Res>
    implements $SecFilingDtoCopyWith<$Res> {
  _$SecFilingDtoCopyWithImpl(this._self, this._then);

  final SecFilingDto _self;
  final $Res Function(SecFilingDto) _then;

/// Create a copy of SecFilingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? symbol = null,Object? companyName = null,Object? filingDate = null,Object? formType = null,Object? link = null,Object? summary = null,Object? eps = freezed,Object? revenue = freezed,Object? sentiment = freezed,Object? topic = freezed,Object? isEarnings = null,Object? createdAt = freezed,Object? analyzedAt = freezed,Object? deepAnalysisId = freezed,Object? deepAnalysisStatus = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,filingDate: null == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as String,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double?,sentiment: freezed == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as String?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,isEarnings: null == isEarnings ? _self.isEarnings : isEarnings // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt ,analyzedAt: freezed == analyzedAt ? _self.analyzedAt : analyzedAt ,deepAnalysisId: freezed == deepAnalysisId ? _self.deepAnalysisId : deepAnalysisId // ignore: cast_nullable_to_non_nullable
as String?,deepAnalysisStatus: freezed == deepAnalysisStatus ? _self.deepAnalysisStatus : deepAnalysisStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SecFilingDto].
extension SecFilingDtoPatterns on SecFilingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecFilingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecFilingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecFilingDto value)  $default,){
final _that = this;
switch (_that) {
case _SecFilingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecFilingDto value)?  $default,){
final _that = this;
switch (_that) {
case _SecFilingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String symbol,  String companyName,  String filingDate,  String formType,  String link,  String summary, @ForceDoubleNullable()  double? eps, @ForceDoubleNullable()  double? revenue,  String? sentiment,  String? topic,  bool isEarnings,  Object? createdAt,  Object? analyzedAt,  String? deepAnalysisId,  String? deepAnalysisStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecFilingDto() when $default != null:
return $default(_that.id,_that.symbol,_that.companyName,_that.filingDate,_that.formType,_that.link,_that.summary,_that.eps,_that.revenue,_that.sentiment,_that.topic,_that.isEarnings,_that.createdAt,_that.analyzedAt,_that.deepAnalysisId,_that.deepAnalysisStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String symbol,  String companyName,  String filingDate,  String formType,  String link,  String summary, @ForceDoubleNullable()  double? eps, @ForceDoubleNullable()  double? revenue,  String? sentiment,  String? topic,  bool isEarnings,  Object? createdAt,  Object? analyzedAt,  String? deepAnalysisId,  String? deepAnalysisStatus)  $default,) {final _that = this;
switch (_that) {
case _SecFilingDto():
return $default(_that.id,_that.symbol,_that.companyName,_that.filingDate,_that.formType,_that.link,_that.summary,_that.eps,_that.revenue,_that.sentiment,_that.topic,_that.isEarnings,_that.createdAt,_that.analyzedAt,_that.deepAnalysisId,_that.deepAnalysisStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String symbol,  String companyName,  String filingDate,  String formType,  String link,  String summary, @ForceDoubleNullable()  double? eps, @ForceDoubleNullable()  double? revenue,  String? sentiment,  String? topic,  bool isEarnings,  Object? createdAt,  Object? analyzedAt,  String? deepAnalysisId,  String? deepAnalysisStatus)?  $default,) {final _that = this;
switch (_that) {
case _SecFilingDto() when $default != null:
return $default(_that.id,_that.symbol,_that.companyName,_that.filingDate,_that.formType,_that.link,_that.summary,_that.eps,_that.revenue,_that.sentiment,_that.topic,_that.isEarnings,_that.createdAt,_that.analyzedAt,_that.deepAnalysisId,_that.deepAnalysisStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SecFilingDto extends SecFilingDto {
  const _SecFilingDto({@JsonKey(includeFromJson: false, includeToJson: false) this.id, required this.symbol, required this.companyName, required this.filingDate, required this.formType, required this.link, required this.summary, @ForceDoubleNullable() this.eps, @ForceDoubleNullable() this.revenue, this.sentiment, this.topic, this.isEarnings = false, this.createdAt, this.analyzedAt, this.deepAnalysisId, this.deepAnalysisStatus}): super._();
  factory _SecFilingDto.fromJson(Map<String, dynamic> json) => _$SecFilingDtoFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? id;
@override final  String symbol;
@override final  String companyName;
@override final  String filingDate;
@override final  String formType;
@override final  String link;
@override final  String summary;
@override@ForceDoubleNullable() final  double? eps;
@override@ForceDoubleNullable() final  double? revenue;
@override final  String? sentiment;
@override final  String? topic;
@override@JsonKey() final  bool isEarnings;
@override final  Object? createdAt;
@override final  Object? analyzedAt;
@override final  String? deepAnalysisId;
@override final  String? deepAnalysisStatus;

/// Create a copy of SecFilingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecFilingDtoCopyWith<_SecFilingDto> get copyWith => __$SecFilingDtoCopyWithImpl<_SecFilingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SecFilingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecFilingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.link, link) || other.link == link)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.sentiment, sentiment) || other.sentiment == sentiment)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.isEarnings, isEarnings) || other.isEarnings == isEarnings)&&const DeepCollectionEquality().equals(other.createdAt, createdAt)&&const DeepCollectionEquality().equals(other.analyzedAt, analyzedAt)&&(identical(other.deepAnalysisId, deepAnalysisId) || other.deepAnalysisId == deepAnalysisId)&&(identical(other.deepAnalysisStatus, deepAnalysisStatus) || other.deepAnalysisStatus == deepAnalysisStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,symbol,companyName,filingDate,formType,link,summary,eps,revenue,sentiment,topic,isEarnings,const DeepCollectionEquality().hash(createdAt),const DeepCollectionEquality().hash(analyzedAt),deepAnalysisId,deepAnalysisStatus);

@override
String toString() {
  return 'SecFilingDto(id: $id, symbol: $symbol, companyName: $companyName, filingDate: $filingDate, formType: $formType, link: $link, summary: $summary, eps: $eps, revenue: $revenue, sentiment: $sentiment, topic: $topic, isEarnings: $isEarnings, createdAt: $createdAt, analyzedAt: $analyzedAt, deepAnalysisId: $deepAnalysisId, deepAnalysisStatus: $deepAnalysisStatus)';
}


}

/// @nodoc
abstract mixin class _$SecFilingDtoCopyWith<$Res> implements $SecFilingDtoCopyWith<$Res> {
  factory _$SecFilingDtoCopyWith(_SecFilingDto value, $Res Function(_SecFilingDto) _then) = __$SecFilingDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String symbol, String companyName, String filingDate, String formType, String link, String summary,@ForceDoubleNullable() double? eps,@ForceDoubleNullable() double? revenue, String? sentiment, String? topic, bool isEarnings, Object? createdAt, Object? analyzedAt, String? deepAnalysisId, String? deepAnalysisStatus
});




}
/// @nodoc
class __$SecFilingDtoCopyWithImpl<$Res>
    implements _$SecFilingDtoCopyWith<$Res> {
  __$SecFilingDtoCopyWithImpl(this._self, this._then);

  final _SecFilingDto _self;
  final $Res Function(_SecFilingDto) _then;

/// Create a copy of SecFilingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? symbol = null,Object? companyName = null,Object? filingDate = null,Object? formType = null,Object? link = null,Object? summary = null,Object? eps = freezed,Object? revenue = freezed,Object? sentiment = freezed,Object? topic = freezed,Object? isEarnings = null,Object? createdAt = freezed,Object? analyzedAt = freezed,Object? deepAnalysisId = freezed,Object? deepAnalysisStatus = freezed,}) {
  return _then(_SecFilingDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,filingDate: null == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as String,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double?,sentiment: freezed == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as String?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,isEarnings: null == isEarnings ? _self.isEarnings : isEarnings // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt ,analyzedAt: freezed == analyzedAt ? _self.analyzedAt : analyzedAt ,deepAnalysisId: freezed == deepAnalysisId ? _self.deepAnalysisId : deepAnalysisId // ignore: cast_nullable_to_non_nullable
as String?,deepAnalysisStatus: freezed == deepAnalysisStatus ? _self.deepAnalysisStatus : deepAnalysisStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
