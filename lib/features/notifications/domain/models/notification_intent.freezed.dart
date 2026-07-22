// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_intent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationIntent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationIntent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationIntent()';
}


}

/// @nodoc
class $NotificationIntentCopyWith<$Res>  {
$NotificationIntentCopyWith(NotificationIntent _, $Res Function(NotificationIntent) __);
}


/// Adds pattern-matching-related methods to [NotificationIntent].
extension NotificationIntentPatterns on NotificationIntent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CompanyProfile value)?  companyProfile,TResult Function( _Reports value)?  reports,TResult Function( _Paywall value)?  paywall,TResult Function( _StockNews value)?  stockNews,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyProfile() when companyProfile != null:
return companyProfile(_that);case _Reports() when reports != null:
return reports(_that);case _Paywall() when paywall != null:
return paywall(_that);case _StockNews() when stockNews != null:
return stockNews(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CompanyProfile value)  companyProfile,required TResult Function( _Reports value)  reports,required TResult Function( _Paywall value)  paywall,required TResult Function( _StockNews value)  stockNews,}){
final _that = this;
switch (_that) {
case _CompanyProfile():
return companyProfile(_that);case _Reports():
return reports(_that);case _Paywall():
return paywall(_that);case _StockNews():
return stockNews(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CompanyProfile value)?  companyProfile,TResult? Function( _Reports value)?  reports,TResult? Function( _Paywall value)?  paywall,TResult? Function( _StockNews value)?  stockNews,}){
final _that = this;
switch (_that) {
case _CompanyProfile() when companyProfile != null:
return companyProfile(_that);case _Reports() when reports != null:
return reports(_that);case _Paywall() when paywall != null:
return paywall(_that);case _StockNews() when stockNews != null:
return stockNews(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker)?  companyProfile,TResult Function( ReportsEntrySource source,  ReportsNotificationType notificationType)?  reports,TResult Function( PaywallSource source)?  paywall,TResult Function( String ticker,  String newsId)?  stockNews,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyProfile() when companyProfile != null:
return companyProfile(_that.ticker);case _Reports() when reports != null:
return reports(_that.source,_that.notificationType);case _Paywall() when paywall != null:
return paywall(_that.source);case _StockNews() when stockNews != null:
return stockNews(_that.ticker,_that.newsId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker)  companyProfile,required TResult Function( ReportsEntrySource source,  ReportsNotificationType notificationType)  reports,required TResult Function( PaywallSource source)  paywall,required TResult Function( String ticker,  String newsId)  stockNews,}) {final _that = this;
switch (_that) {
case _CompanyProfile():
return companyProfile(_that.ticker);case _Reports():
return reports(_that.source,_that.notificationType);case _Paywall():
return paywall(_that.source);case _StockNews():
return stockNews(_that.ticker,_that.newsId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker)?  companyProfile,TResult? Function( ReportsEntrySource source,  ReportsNotificationType notificationType)?  reports,TResult? Function( PaywallSource source)?  paywall,TResult? Function( String ticker,  String newsId)?  stockNews,}) {final _that = this;
switch (_that) {
case _CompanyProfile() when companyProfile != null:
return companyProfile(_that.ticker);case _Reports() when reports != null:
return reports(_that.source,_that.notificationType);case _Paywall() when paywall != null:
return paywall(_that.source);case _StockNews() when stockNews != null:
return stockNews(_that.ticker,_that.newsId);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyProfile implements NotificationIntent {
  const _CompanyProfile(this.ticker);
  

 final  String ticker;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyProfileCopyWith<_CompanyProfile> get copyWith => __$CompanyProfileCopyWithImpl<_CompanyProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyProfile&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'NotificationIntent.companyProfile(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class _$CompanyProfileCopyWith<$Res> implements $NotificationIntentCopyWith<$Res> {
  factory _$CompanyProfileCopyWith(_CompanyProfile value, $Res Function(_CompanyProfile) _then) = __$CompanyProfileCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class __$CompanyProfileCopyWithImpl<$Res>
    implements _$CompanyProfileCopyWith<$Res> {
  __$CompanyProfileCopyWithImpl(this._self, this._then);

  final _CompanyProfile _self;
  final $Res Function(_CompanyProfile) _then;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(_CompanyProfile(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Reports implements NotificationIntent {
  const _Reports({required this.source, required this.notificationType});
  

 final  ReportsEntrySource source;
 final  ReportsNotificationType notificationType;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsCopyWith<_Reports> get copyWith => __$ReportsCopyWithImpl<_Reports>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reports&&(identical(other.source, source) || other.source == source)&&(identical(other.notificationType, notificationType) || other.notificationType == notificationType));
}


@override
int get hashCode => Object.hash(runtimeType,source,notificationType);

@override
String toString() {
  return 'NotificationIntent.reports(source: $source, notificationType: $notificationType)';
}


}

/// @nodoc
abstract mixin class _$ReportsCopyWith<$Res> implements $NotificationIntentCopyWith<$Res> {
  factory _$ReportsCopyWith(_Reports value, $Res Function(_Reports) _then) = __$ReportsCopyWithImpl;
@useResult
$Res call({
 ReportsEntrySource source, ReportsNotificationType notificationType
});




}
/// @nodoc
class __$ReportsCopyWithImpl<$Res>
    implements _$ReportsCopyWith<$Res> {
  __$ReportsCopyWithImpl(this._self, this._then);

  final _Reports _self;
  final $Res Function(_Reports) _then;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,Object? notificationType = null,}) {
  return _then(_Reports(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ReportsEntrySource,notificationType: null == notificationType ? _self.notificationType : notificationType // ignore: cast_nullable_to_non_nullable
as ReportsNotificationType,
  ));
}


}

/// @nodoc


class _Paywall implements NotificationIntent {
  const _Paywall(this.source);
  

 final  PaywallSource source;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaywallCopyWith<_Paywall> get copyWith => __$PaywallCopyWithImpl<_Paywall>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Paywall&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,source);

@override
String toString() {
  return 'NotificationIntent.paywall(source: $source)';
}


}

/// @nodoc
abstract mixin class _$PaywallCopyWith<$Res> implements $NotificationIntentCopyWith<$Res> {
  factory _$PaywallCopyWith(_Paywall value, $Res Function(_Paywall) _then) = __$PaywallCopyWithImpl;
@useResult
$Res call({
 PaywallSource source
});




}
/// @nodoc
class __$PaywallCopyWithImpl<$Res>
    implements _$PaywallCopyWith<$Res> {
  __$PaywallCopyWithImpl(this._self, this._then);

  final _Paywall _self;
  final $Res Function(_Paywall) _then;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(_Paywall(
null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PaywallSource,
  ));
}


}

/// @nodoc


class _StockNews implements NotificationIntent {
  const _StockNews({required this.ticker, required this.newsId});
  

 final  String ticker;
 final  String newsId;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockNewsCopyWith<_StockNews> get copyWith => __$StockNewsCopyWithImpl<_StockNews>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockNews&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.newsId, newsId) || other.newsId == newsId));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,newsId);

@override
String toString() {
  return 'NotificationIntent.stockNews(ticker: $ticker, newsId: $newsId)';
}


}

/// @nodoc
abstract mixin class _$StockNewsCopyWith<$Res> implements $NotificationIntentCopyWith<$Res> {
  factory _$StockNewsCopyWith(_StockNews value, $Res Function(_StockNews) _then) = __$StockNewsCopyWithImpl;
@useResult
$Res call({
 String ticker, String newsId
});




}
/// @nodoc
class __$StockNewsCopyWithImpl<$Res>
    implements _$StockNewsCopyWith<$Res> {
  __$StockNewsCopyWithImpl(this._self, this._then);

  final _StockNews _self;
  final $Res Function(_StockNews) _then;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? newsId = null,}) {
  return _then(_StockNews(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,newsId: null == newsId ? _self.newsId : newsId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
