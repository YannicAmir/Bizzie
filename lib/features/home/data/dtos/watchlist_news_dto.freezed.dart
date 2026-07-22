// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_news_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WatchlistNewsDto {

 String get symbol; String get title; String get site; String get url;@TimestampConverter() DateTime get publishedAt; String? get image;
/// Create a copy of WatchlistNewsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistNewsDtoCopyWith<WatchlistNewsDto> get copyWith => _$WatchlistNewsDtoCopyWithImpl<WatchlistNewsDto>(this as WatchlistNewsDto, _$identity);

  /// Serializes this WatchlistNewsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistNewsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.title, title) || other.title == title)&&(identical(other.site, site) || other.site == site)&&(identical(other.url, url) || other.url == url)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,title,site,url,publishedAt,image);

@override
String toString() {
  return 'WatchlistNewsDto(symbol: $symbol, title: $title, site: $site, url: $url, publishedAt: $publishedAt, image: $image)';
}


}

/// @nodoc
abstract mixin class $WatchlistNewsDtoCopyWith<$Res>  {
  factory $WatchlistNewsDtoCopyWith(WatchlistNewsDto value, $Res Function(WatchlistNewsDto) _then) = _$WatchlistNewsDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String title, String site, String url,@TimestampConverter() DateTime publishedAt, String? image
});




}
/// @nodoc
class _$WatchlistNewsDtoCopyWithImpl<$Res>
    implements $WatchlistNewsDtoCopyWith<$Res> {
  _$WatchlistNewsDtoCopyWithImpl(this._self, this._then);

  final WatchlistNewsDto _self;
  final $Res Function(WatchlistNewsDto) _then;

/// Create a copy of WatchlistNewsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? title = null,Object? site = null,Object? url = null,Object? publishedAt = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistNewsDto].
extension WatchlistNewsDtoPatterns on WatchlistNewsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistNewsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistNewsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistNewsDto value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistNewsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistNewsDto value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistNewsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String title,  String site,  String url, @TimestampConverter()  DateTime publishedAt,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistNewsDto() when $default != null:
return $default(_that.symbol,_that.title,_that.site,_that.url,_that.publishedAt,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String title,  String site,  String url, @TimestampConverter()  DateTime publishedAt,  String? image)  $default,) {final _that = this;
switch (_that) {
case _WatchlistNewsDto():
return $default(_that.symbol,_that.title,_that.site,_that.url,_that.publishedAt,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String title,  String site,  String url, @TimestampConverter()  DateTime publishedAt,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistNewsDto() when $default != null:
return $default(_that.symbol,_that.title,_that.site,_that.url,_that.publishedAt,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WatchlistNewsDto extends WatchlistNewsDto {
  const _WatchlistNewsDto({required this.symbol, required this.title, required this.site, required this.url, @TimestampConverter() required this.publishedAt, this.image}): super._();
  factory _WatchlistNewsDto.fromJson(Map<String, dynamic> json) => _$WatchlistNewsDtoFromJson(json);

@override final  String symbol;
@override final  String title;
@override final  String site;
@override final  String url;
@override@TimestampConverter() final  DateTime publishedAt;
@override final  String? image;

/// Create a copy of WatchlistNewsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistNewsDtoCopyWith<_WatchlistNewsDto> get copyWith => __$WatchlistNewsDtoCopyWithImpl<_WatchlistNewsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatchlistNewsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistNewsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.title, title) || other.title == title)&&(identical(other.site, site) || other.site == site)&&(identical(other.url, url) || other.url == url)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,title,site,url,publishedAt,image);

@override
String toString() {
  return 'WatchlistNewsDto(symbol: $symbol, title: $title, site: $site, url: $url, publishedAt: $publishedAt, image: $image)';
}


}

/// @nodoc
abstract mixin class _$WatchlistNewsDtoCopyWith<$Res> implements $WatchlistNewsDtoCopyWith<$Res> {
  factory _$WatchlistNewsDtoCopyWith(_WatchlistNewsDto value, $Res Function(_WatchlistNewsDto) _then) = __$WatchlistNewsDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String title, String site, String url,@TimestampConverter() DateTime publishedAt, String? image
});




}
/// @nodoc
class __$WatchlistNewsDtoCopyWithImpl<$Res>
    implements _$WatchlistNewsDtoCopyWith<$Res> {
  __$WatchlistNewsDtoCopyWithImpl(this._self, this._then);

  final _WatchlistNewsDto _self;
  final $Res Function(_WatchlistNewsDto) _then;

/// Create a copy of WatchlistNewsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? title = null,Object? site = null,Object? url = null,Object? publishedAt = null,Object? image = freezed,}) {
  return _then(_WatchlistNewsDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
