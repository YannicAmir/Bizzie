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

 String get id; String get symbol; String get companyName; DateTime? get filingDate; String get formType; String get link; String get summary; double? get eps; double? get revenue; String? get sentiment; String? get topic; bool get isEarnings; DateTime? get createdAt; DateTime? get analyzedAt; String? get deepAnalysisId; String? get deepAnalysisStatus;
/// Create a copy of SecFiling
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecFilingCopyWith<SecFiling> get copyWith => _$SecFilingCopyWithImpl<SecFiling>(this as SecFiling, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecFiling&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.link, link) || other.link == link)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.sentiment, sentiment) || other.sentiment == sentiment)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.isEarnings, isEarnings) || other.isEarnings == isEarnings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.analyzedAt, analyzedAt) || other.analyzedAt == analyzedAt)&&(identical(other.deepAnalysisId, deepAnalysisId) || other.deepAnalysisId == deepAnalysisId)&&(identical(other.deepAnalysisStatus, deepAnalysisStatus) || other.deepAnalysisStatus == deepAnalysisStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,symbol,companyName,filingDate,formType,link,summary,eps,revenue,sentiment,topic,isEarnings,createdAt,analyzedAt,deepAnalysisId,deepAnalysisStatus);

@override
String toString() {
  return 'SecFiling(id: $id, symbol: $symbol, companyName: $companyName, filingDate: $filingDate, formType: $formType, link: $link, summary: $summary, eps: $eps, revenue: $revenue, sentiment: $sentiment, topic: $topic, isEarnings: $isEarnings, createdAt: $createdAt, analyzedAt: $analyzedAt, deepAnalysisId: $deepAnalysisId, deepAnalysisStatus: $deepAnalysisStatus)';
}


}

/// @nodoc
abstract mixin class $SecFilingCopyWith<$Res>  {
  factory $SecFilingCopyWith(SecFiling value, $Res Function(SecFiling) _then) = _$SecFilingCopyWithImpl;
@useResult
$Res call({
 String id, String symbol, String companyName, DateTime? filingDate, String formType, String link, String summary, double? eps, double? revenue, String? sentiment, String? topic, bool isEarnings, DateTime? createdAt, DateTime? analyzedAt, String? deepAnalysisId, String? deepAnalysisStatus
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? symbol = null,Object? companyName = null,Object? filingDate = freezed,Object? formType = null,Object? link = null,Object? summary = null,Object? eps = freezed,Object? revenue = freezed,Object? sentiment = freezed,Object? topic = freezed,Object? isEarnings = null,Object? createdAt = freezed,Object? analyzedAt = freezed,Object? deepAnalysisId = freezed,Object? deepAnalysisStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,filingDate: freezed == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double?,sentiment: freezed == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as String?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,isEarnings: null == isEarnings ? _self.isEarnings : isEarnings // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,analyzedAt: freezed == analyzedAt ? _self.analyzedAt : analyzedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deepAnalysisId: freezed == deepAnalysisId ? _self.deepAnalysisId : deepAnalysisId // ignore: cast_nullable_to_non_nullable
as String?,deepAnalysisStatus: freezed == deepAnalysisStatus ? _self.deepAnalysisStatus : deepAnalysisStatus // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String symbol,  String companyName,  DateTime? filingDate,  String formType,  String link,  String summary,  double? eps,  double? revenue,  String? sentiment,  String? topic,  bool isEarnings,  DateTime? createdAt,  DateTime? analyzedAt,  String? deepAnalysisId,  String? deepAnalysisStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecFiling() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String symbol,  String companyName,  DateTime? filingDate,  String formType,  String link,  String summary,  double? eps,  double? revenue,  String? sentiment,  String? topic,  bool isEarnings,  DateTime? createdAt,  DateTime? analyzedAt,  String? deepAnalysisId,  String? deepAnalysisStatus)  $default,) {final _that = this;
switch (_that) {
case _SecFiling():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String symbol,  String companyName,  DateTime? filingDate,  String formType,  String link,  String summary,  double? eps,  double? revenue,  String? sentiment,  String? topic,  bool isEarnings,  DateTime? createdAt,  DateTime? analyzedAt,  String? deepAnalysisId,  String? deepAnalysisStatus)?  $default,) {final _that = this;
switch (_that) {
case _SecFiling() when $default != null:
return $default(_that.id,_that.symbol,_that.companyName,_that.filingDate,_that.formType,_that.link,_that.summary,_that.eps,_that.revenue,_that.sentiment,_that.topic,_that.isEarnings,_that.createdAt,_that.analyzedAt,_that.deepAnalysisId,_that.deepAnalysisStatus);case _:
  return null;

}
}

}

/// @nodoc


class _SecFiling implements SecFiling {
  const _SecFiling({required this.id, required this.symbol, required this.companyName, required this.filingDate, required this.formType, required this.link, required this.summary, this.eps, this.revenue, this.sentiment, this.topic, this.isEarnings = false, required this.createdAt, required this.analyzedAt, this.deepAnalysisId, this.deepAnalysisStatus});
  

@override final  String id;
@override final  String symbol;
@override final  String companyName;
@override final  DateTime? filingDate;
@override final  String formType;
@override final  String link;
@override final  String summary;
@override final  double? eps;
@override final  double? revenue;
@override final  String? sentiment;
@override final  String? topic;
@override@JsonKey() final  bool isEarnings;
@override final  DateTime? createdAt;
@override final  DateTime? analyzedAt;
@override final  String? deepAnalysisId;
@override final  String? deepAnalysisStatus;

/// Create a copy of SecFiling
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecFilingCopyWith<_SecFiling> get copyWith => __$SecFilingCopyWithImpl<_SecFiling>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecFiling&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.link, link) || other.link == link)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.sentiment, sentiment) || other.sentiment == sentiment)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.isEarnings, isEarnings) || other.isEarnings == isEarnings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.analyzedAt, analyzedAt) || other.analyzedAt == analyzedAt)&&(identical(other.deepAnalysisId, deepAnalysisId) || other.deepAnalysisId == deepAnalysisId)&&(identical(other.deepAnalysisStatus, deepAnalysisStatus) || other.deepAnalysisStatus == deepAnalysisStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,symbol,companyName,filingDate,formType,link,summary,eps,revenue,sentiment,topic,isEarnings,createdAt,analyzedAt,deepAnalysisId,deepAnalysisStatus);

@override
String toString() {
  return 'SecFiling(id: $id, symbol: $symbol, companyName: $companyName, filingDate: $filingDate, formType: $formType, link: $link, summary: $summary, eps: $eps, revenue: $revenue, sentiment: $sentiment, topic: $topic, isEarnings: $isEarnings, createdAt: $createdAt, analyzedAt: $analyzedAt, deepAnalysisId: $deepAnalysisId, deepAnalysisStatus: $deepAnalysisStatus)';
}


}

/// @nodoc
abstract mixin class _$SecFilingCopyWith<$Res> implements $SecFilingCopyWith<$Res> {
  factory _$SecFilingCopyWith(_SecFiling value, $Res Function(_SecFiling) _then) = __$SecFilingCopyWithImpl;
@override @useResult
$Res call({
 String id, String symbol, String companyName, DateTime? filingDate, String formType, String link, String summary, double? eps, double? revenue, String? sentiment, String? topic, bool isEarnings, DateTime? createdAt, DateTime? analyzedAt, String? deepAnalysisId, String? deepAnalysisStatus
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? symbol = null,Object? companyName = null,Object? filingDate = freezed,Object? formType = null,Object? link = null,Object? summary = null,Object? eps = freezed,Object? revenue = freezed,Object? sentiment = freezed,Object? topic = freezed,Object? isEarnings = null,Object? createdAt = freezed,Object? analyzedAt = freezed,Object? deepAnalysisId = freezed,Object? deepAnalysisStatus = freezed,}) {
  return _then(_SecFiling(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,filingDate: freezed == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double?,sentiment: freezed == sentiment ? _self.sentiment : sentiment // ignore: cast_nullable_to_non_nullable
as String?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,isEarnings: null == isEarnings ? _self.isEarnings : isEarnings // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,analyzedAt: freezed == analyzedAt ? _self.analyzedAt : analyzedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deepAnalysisId: freezed == deepAnalysisId ? _self.deepAnalysisId : deepAnalysisId // ignore: cast_nullable_to_non_nullable
as String?,deepAnalysisStatus: freezed == deepAnalysisStatus ? _self.deepAnalysisStatus : deepAnalysisStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
