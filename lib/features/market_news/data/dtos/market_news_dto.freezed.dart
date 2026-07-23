// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_news_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarketNewsDto {

@JsonKey(name: 'newsId') String get id; String get title; String get site; String get publisher; String get url;@TimestampConverter() DateTime get publishedAt; String? get image;
/// Create a copy of MarketNewsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketNewsDtoCopyWith<MarketNewsDto> get copyWith => _$MarketNewsDtoCopyWithImpl<MarketNewsDto>(this as MarketNewsDto, _$identity);

  /// Serializes this MarketNewsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketNewsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.site, site) || other.site == site)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.url, url) || other.url == url)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,site,publisher,url,publishedAt,image);

@override
String toString() {
  return 'MarketNewsDto(id: $id, title: $title, site: $site, publisher: $publisher, url: $url, publishedAt: $publishedAt, image: $image)';
}


}

/// @nodoc
abstract mixin class $MarketNewsDtoCopyWith<$Res>  {
  factory $MarketNewsDtoCopyWith(MarketNewsDto value, $Res Function(MarketNewsDto) _then) = _$MarketNewsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'newsId') String id, String title, String site, String publisher, String url,@TimestampConverter() DateTime publishedAt, String? image
});




}
/// @nodoc
class _$MarketNewsDtoCopyWithImpl<$Res>
    implements $MarketNewsDtoCopyWith<$Res> {
  _$MarketNewsDtoCopyWithImpl(this._self, this._then);

  final MarketNewsDto _self;
  final $Res Function(MarketNewsDto) _then;

/// Create a copy of MarketNewsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? site = null,Object? publisher = null,Object? url = null,Object? publishedAt = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketNewsDto].
extension MarketNewsDtoPatterns on MarketNewsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketNewsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketNewsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketNewsDto value)  $default,){
final _that = this;
switch (_that) {
case _MarketNewsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketNewsDto value)?  $default,){
final _that = this;
switch (_that) {
case _MarketNewsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'newsId')  String id,  String title,  String site,  String publisher,  String url, @TimestampConverter()  DateTime publishedAt,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketNewsDto() when $default != null:
return $default(_that.id,_that.title,_that.site,_that.publisher,_that.url,_that.publishedAt,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'newsId')  String id,  String title,  String site,  String publisher,  String url, @TimestampConverter()  DateTime publishedAt,  String? image)  $default,) {final _that = this;
switch (_that) {
case _MarketNewsDto():
return $default(_that.id,_that.title,_that.site,_that.publisher,_that.url,_that.publishedAt,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'newsId')  String id,  String title,  String site,  String publisher,  String url, @TimestampConverter()  DateTime publishedAt,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _MarketNewsDto() when $default != null:
return $default(_that.id,_that.title,_that.site,_that.publisher,_that.url,_that.publishedAt,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketNewsDto extends MarketNewsDto {
  const _MarketNewsDto({@JsonKey(name: 'newsId') required this.id, required this.title, required this.site, required this.publisher, required this.url, @TimestampConverter() required this.publishedAt, this.image}): super._();
  factory _MarketNewsDto.fromJson(Map<String, dynamic> json) => _$MarketNewsDtoFromJson(json);

@override@JsonKey(name: 'newsId') final  String id;
@override final  String title;
@override final  String site;
@override final  String publisher;
@override final  String url;
@override@TimestampConverter() final  DateTime publishedAt;
@override final  String? image;

/// Create a copy of MarketNewsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketNewsDtoCopyWith<_MarketNewsDto> get copyWith => __$MarketNewsDtoCopyWithImpl<_MarketNewsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketNewsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketNewsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.site, site) || other.site == site)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.url, url) || other.url == url)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,site,publisher,url,publishedAt,image);

@override
String toString() {
  return 'MarketNewsDto(id: $id, title: $title, site: $site, publisher: $publisher, url: $url, publishedAt: $publishedAt, image: $image)';
}


}

/// @nodoc
abstract mixin class _$MarketNewsDtoCopyWith<$Res> implements $MarketNewsDtoCopyWith<$Res> {
  factory _$MarketNewsDtoCopyWith(_MarketNewsDto value, $Res Function(_MarketNewsDto) _then) = __$MarketNewsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'newsId') String id, String title, String site, String publisher, String url,@TimestampConverter() DateTime publishedAt, String? image
});




}
/// @nodoc
class __$MarketNewsDtoCopyWithImpl<$Res>
    implements _$MarketNewsDtoCopyWith<$Res> {
  __$MarketNewsDtoCopyWithImpl(this._self, this._then);

  final _MarketNewsDto _self;
  final $Res Function(_MarketNewsDto) _then;

/// Create a copy of MarketNewsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? site = null,Object? publisher = null,Object? url = null,Object? publishedAt = null,Object? image = freezed,}) {
  return _then(_MarketNewsDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
