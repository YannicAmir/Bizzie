// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PriceMovement {

 double? get startPrice; double? get endPrice; double? get priceChange; double? get priceChangePercent;
/// Create a copy of PriceMovement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceMovementCopyWith<PriceMovement> get copyWith => _$PriceMovementCopyWithImpl<PriceMovement>(this as PriceMovement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceMovement&&(identical(other.startPrice, startPrice) || other.startPrice == startPrice)&&(identical(other.endPrice, endPrice) || other.endPrice == endPrice)&&(identical(other.priceChange, priceChange) || other.priceChange == priceChange)&&(identical(other.priceChangePercent, priceChangePercent) || other.priceChangePercent == priceChangePercent));
}


@override
int get hashCode => Object.hash(runtimeType,startPrice,endPrice,priceChange,priceChangePercent);

@override
String toString() {
  return 'PriceMovement(startPrice: $startPrice, endPrice: $endPrice, priceChange: $priceChange, priceChangePercent: $priceChangePercent)';
}


}

/// @nodoc
abstract mixin class $PriceMovementCopyWith<$Res>  {
  factory $PriceMovementCopyWith(PriceMovement value, $Res Function(PriceMovement) _then) = _$PriceMovementCopyWithImpl;
@useResult
$Res call({
 double? startPrice, double? endPrice, double? priceChange, double? priceChangePercent
});




}
/// @nodoc
class _$PriceMovementCopyWithImpl<$Res>
    implements $PriceMovementCopyWith<$Res> {
  _$PriceMovementCopyWithImpl(this._self, this._then);

  final PriceMovement _self;
  final $Res Function(PriceMovement) _then;

/// Create a copy of PriceMovement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startPrice = freezed,Object? endPrice = freezed,Object? priceChange = freezed,Object? priceChangePercent = freezed,}) {
  return _then(_self.copyWith(
startPrice: freezed == startPrice ? _self.startPrice : startPrice // ignore: cast_nullable_to_non_nullable
as double?,endPrice: freezed == endPrice ? _self.endPrice : endPrice // ignore: cast_nullable_to_non_nullable
as double?,priceChange: freezed == priceChange ? _self.priceChange : priceChange // ignore: cast_nullable_to_non_nullable
as double?,priceChangePercent: freezed == priceChangePercent ? _self.priceChangePercent : priceChangePercent // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceMovement].
extension PriceMovementPatterns on PriceMovement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceMovement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceMovement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceMovement value)  $default,){
final _that = this;
switch (_that) {
case _PriceMovement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceMovement value)?  $default,){
final _that = this;
switch (_that) {
case _PriceMovement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? startPrice,  double? endPrice,  double? priceChange,  double? priceChangePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceMovement() when $default != null:
return $default(_that.startPrice,_that.endPrice,_that.priceChange,_that.priceChangePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? startPrice,  double? endPrice,  double? priceChange,  double? priceChangePercent)  $default,) {final _that = this;
switch (_that) {
case _PriceMovement():
return $default(_that.startPrice,_that.endPrice,_that.priceChange,_that.priceChangePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? startPrice,  double? endPrice,  double? priceChange,  double? priceChangePercent)?  $default,) {final _that = this;
switch (_that) {
case _PriceMovement() when $default != null:
return $default(_that.startPrice,_that.endPrice,_that.priceChange,_that.priceChangePercent);case _:
  return null;

}
}

}

/// @nodoc


class _PriceMovement implements PriceMovement {
  const _PriceMovement({this.startPrice, this.endPrice, this.priceChange, this.priceChangePercent});
  

@override final  double? startPrice;
@override final  double? endPrice;
@override final  double? priceChange;
@override final  double? priceChangePercent;

/// Create a copy of PriceMovement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceMovementCopyWith<_PriceMovement> get copyWith => __$PriceMovementCopyWithImpl<_PriceMovement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceMovement&&(identical(other.startPrice, startPrice) || other.startPrice == startPrice)&&(identical(other.endPrice, endPrice) || other.endPrice == endPrice)&&(identical(other.priceChange, priceChange) || other.priceChange == priceChange)&&(identical(other.priceChangePercent, priceChangePercent) || other.priceChangePercent == priceChangePercent));
}


@override
int get hashCode => Object.hash(runtimeType,startPrice,endPrice,priceChange,priceChangePercent);

@override
String toString() {
  return 'PriceMovement(startPrice: $startPrice, endPrice: $endPrice, priceChange: $priceChange, priceChangePercent: $priceChangePercent)';
}


}

/// @nodoc
abstract mixin class _$PriceMovementCopyWith<$Res> implements $PriceMovementCopyWith<$Res> {
  factory _$PriceMovementCopyWith(_PriceMovement value, $Res Function(_PriceMovement) _then) = __$PriceMovementCopyWithImpl;
@override @useResult
$Res call({
 double? startPrice, double? endPrice, double? priceChange, double? priceChangePercent
});




}
/// @nodoc
class __$PriceMovementCopyWithImpl<$Res>
    implements _$PriceMovementCopyWith<$Res> {
  __$PriceMovementCopyWithImpl(this._self, this._then);

  final _PriceMovement _self;
  final $Res Function(_PriceMovement) _then;

/// Create a copy of PriceMovement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startPrice = freezed,Object? endPrice = freezed,Object? priceChange = freezed,Object? priceChangePercent = freezed,}) {
  return _then(_PriceMovement(
startPrice: freezed == startPrice ? _self.startPrice : startPrice // ignore: cast_nullable_to_non_nullable
as double?,endPrice: freezed == endPrice ? _self.endPrice : endPrice // ignore: cast_nullable_to_non_nullable
as double?,priceChange: freezed == priceChange ? _self.priceChange : priceChange // ignore: cast_nullable_to_non_nullable
as double?,priceChangePercent: freezed == priceChangePercent ? _self.priceChangePercent : priceChangePercent // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$WeeklyReport {

 String? get id; String? get ticker; String? get companyName; String? get messageTitle; String? get messageShortSummary; String? get messageLongSummary; List<String>? get newsLinks; List<String>? get eightKLinks; PriceMovement? get priceMovement; DateTime? get createdAt;
/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyReportCopyWith<WeeklyReport> get copyWith => _$WeeklyReportCopyWithImpl<WeeklyReport>(this as WeeklyReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyReport&&(identical(other.id, id) || other.id == id)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.messageTitle, messageTitle) || other.messageTitle == messageTitle)&&(identical(other.messageShortSummary, messageShortSummary) || other.messageShortSummary == messageShortSummary)&&(identical(other.messageLongSummary, messageLongSummary) || other.messageLongSummary == messageLongSummary)&&const DeepCollectionEquality().equals(other.newsLinks, newsLinks)&&const DeepCollectionEquality().equals(other.eightKLinks, eightKLinks)&&(identical(other.priceMovement, priceMovement) || other.priceMovement == priceMovement)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,ticker,companyName,messageTitle,messageShortSummary,messageLongSummary,const DeepCollectionEquality().hash(newsLinks),const DeepCollectionEquality().hash(eightKLinks),priceMovement,createdAt);

@override
String toString() {
  return 'WeeklyReport(id: $id, ticker: $ticker, companyName: $companyName, messageTitle: $messageTitle, messageShortSummary: $messageShortSummary, messageLongSummary: $messageLongSummary, newsLinks: $newsLinks, eightKLinks: $eightKLinks, priceMovement: $priceMovement, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WeeklyReportCopyWith<$Res>  {
  factory $WeeklyReportCopyWith(WeeklyReport value, $Res Function(WeeklyReport) _then) = _$WeeklyReportCopyWithImpl;
@useResult
$Res call({
 String? id, String? ticker, String? companyName, String? messageTitle, String? messageShortSummary, String? messageLongSummary, List<String>? newsLinks, List<String>? eightKLinks, PriceMovement? priceMovement, DateTime? createdAt
});


$PriceMovementCopyWith<$Res>? get priceMovement;

}
/// @nodoc
class _$WeeklyReportCopyWithImpl<$Res>
    implements $WeeklyReportCopyWith<$Res> {
  _$WeeklyReportCopyWithImpl(this._self, this._then);

  final WeeklyReport _self;
  final $Res Function(WeeklyReport) _then;

/// Create a copy of WeeklyReport
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
as PriceMovement?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceMovementCopyWith<$Res>? get priceMovement {
    if (_self.priceMovement == null) {
    return null;
  }

  return $PriceMovementCopyWith<$Res>(_self.priceMovement!, (value) {
    return _then(_self.copyWith(priceMovement: value));
  });
}
}


/// Adds pattern-matching-related methods to [WeeklyReport].
extension WeeklyReportPatterns on WeeklyReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyReport value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyReport value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? ticker,  String? companyName,  String? messageTitle,  String? messageShortSummary,  String? messageLongSummary,  List<String>? newsLinks,  List<String>? eightKLinks,  PriceMovement? priceMovement,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? ticker,  String? companyName,  String? messageTitle,  String? messageShortSummary,  String? messageLongSummary,  List<String>? newsLinks,  List<String>? eightKLinks,  PriceMovement? priceMovement,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _WeeklyReport():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? ticker,  String? companyName,  String? messageTitle,  String? messageShortSummary,  String? messageLongSummary,  List<String>? newsLinks,  List<String>? eightKLinks,  PriceMovement? priceMovement,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyReport() when $default != null:
return $default(_that.id,_that.ticker,_that.companyName,_that.messageTitle,_that.messageShortSummary,_that.messageLongSummary,_that.newsLinks,_that.eightKLinks,_that.priceMovement,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _WeeklyReport extends WeeklyReport {
  const _WeeklyReport({this.id, this.ticker, this.companyName, this.messageTitle, this.messageShortSummary, this.messageLongSummary, final  List<String>? newsLinks, final  List<String>? eightKLinks, this.priceMovement, this.createdAt}): _newsLinks = newsLinks,_eightKLinks = eightKLinks,super._();
  

@override final  String? id;
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

@override final  PriceMovement? priceMovement;
@override final  DateTime? createdAt;

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyReportCopyWith<_WeeklyReport> get copyWith => __$WeeklyReportCopyWithImpl<_WeeklyReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyReport&&(identical(other.id, id) || other.id == id)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.messageTitle, messageTitle) || other.messageTitle == messageTitle)&&(identical(other.messageShortSummary, messageShortSummary) || other.messageShortSummary == messageShortSummary)&&(identical(other.messageLongSummary, messageLongSummary) || other.messageLongSummary == messageLongSummary)&&const DeepCollectionEquality().equals(other._newsLinks, _newsLinks)&&const DeepCollectionEquality().equals(other._eightKLinks, _eightKLinks)&&(identical(other.priceMovement, priceMovement) || other.priceMovement == priceMovement)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,ticker,companyName,messageTitle,messageShortSummary,messageLongSummary,const DeepCollectionEquality().hash(_newsLinks),const DeepCollectionEquality().hash(_eightKLinks),priceMovement,createdAt);

@override
String toString() {
  return 'WeeklyReport(id: $id, ticker: $ticker, companyName: $companyName, messageTitle: $messageTitle, messageShortSummary: $messageShortSummary, messageLongSummary: $messageLongSummary, newsLinks: $newsLinks, eightKLinks: $eightKLinks, priceMovement: $priceMovement, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WeeklyReportCopyWith<$Res> implements $WeeklyReportCopyWith<$Res> {
  factory _$WeeklyReportCopyWith(_WeeklyReport value, $Res Function(_WeeklyReport) _then) = __$WeeklyReportCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? ticker, String? companyName, String? messageTitle, String? messageShortSummary, String? messageLongSummary, List<String>? newsLinks, List<String>? eightKLinks, PriceMovement? priceMovement, DateTime? createdAt
});


@override $PriceMovementCopyWith<$Res>? get priceMovement;

}
/// @nodoc
class __$WeeklyReportCopyWithImpl<$Res>
    implements _$WeeklyReportCopyWith<$Res> {
  __$WeeklyReportCopyWithImpl(this._self, this._then);

  final _WeeklyReport _self;
  final $Res Function(_WeeklyReport) _then;

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? ticker = freezed,Object? companyName = freezed,Object? messageTitle = freezed,Object? messageShortSummary = freezed,Object? messageLongSummary = freezed,Object? newsLinks = freezed,Object? eightKLinks = freezed,Object? priceMovement = freezed,Object? createdAt = freezed,}) {
  return _then(_WeeklyReport(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,messageTitle: freezed == messageTitle ? _self.messageTitle : messageTitle // ignore: cast_nullable_to_non_nullable
as String?,messageShortSummary: freezed == messageShortSummary ? _self.messageShortSummary : messageShortSummary // ignore: cast_nullable_to_non_nullable
as String?,messageLongSummary: freezed == messageLongSummary ? _self.messageLongSummary : messageLongSummary // ignore: cast_nullable_to_non_nullable
as String?,newsLinks: freezed == newsLinks ? _self._newsLinks : newsLinks // ignore: cast_nullable_to_non_nullable
as List<String>?,eightKLinks: freezed == eightKLinks ? _self._eightKLinks : eightKLinks // ignore: cast_nullable_to_non_nullable
as List<String>?,priceMovement: freezed == priceMovement ? _self.priceMovement : priceMovement // ignore: cast_nullable_to_non_nullable
as PriceMovement?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of WeeklyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceMovementCopyWith<$Res>? get priceMovement {
    if (_self.priceMovement == null) {
    return null;
  }

  return $PriceMovementCopyWith<$Res>(_self.priceMovement!, (value) {
    return _then(_self.copyWith(priceMovement: value));
  });
}
}

// dart format on
