// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewsDto {

 String get symbol; String get publishedDate; String get title; String? get image; String get site; String get url; String? get text;
/// Create a copy of NewsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsDtoCopyWith<NewsDto> get copyWith => _$NewsDtoCopyWithImpl<NewsDto>(this as NewsDto, _$identity);

  /// Serializes this NewsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.publishedDate, publishedDate) || other.publishedDate == publishedDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.image, image) || other.image == image)&&(identical(other.site, site) || other.site == site)&&(identical(other.url, url) || other.url == url)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,publishedDate,title,image,site,url,text);

@override
String toString() {
  return 'NewsDto(symbol: $symbol, publishedDate: $publishedDate, title: $title, image: $image, site: $site, url: $url, text: $text)';
}


}

/// @nodoc
abstract mixin class $NewsDtoCopyWith<$Res>  {
  factory $NewsDtoCopyWith(NewsDto value, $Res Function(NewsDto) _then) = _$NewsDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String publishedDate, String title, String? image, String site, String url, String? text
});




}
/// @nodoc
class _$NewsDtoCopyWithImpl<$Res>
    implements $NewsDtoCopyWith<$Res> {
  _$NewsDtoCopyWithImpl(this._self, this._then);

  final NewsDto _self;
  final $Res Function(NewsDto) _then;

/// Create a copy of NewsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? publishedDate = null,Object? title = null,Object? image = freezed,Object? site = null,Object? url = null,Object? text = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,publishedDate: null == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsDto].
extension NewsDtoPatterns on NewsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsDto value)  $default,){
final _that = this;
switch (_that) {
case _NewsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsDto value)?  $default,){
final _that = this;
switch (_that) {
case _NewsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String publishedDate,  String title,  String? image,  String site,  String url,  String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsDto() when $default != null:
return $default(_that.symbol,_that.publishedDate,_that.title,_that.image,_that.site,_that.url,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String publishedDate,  String title,  String? image,  String site,  String url,  String? text)  $default,) {final _that = this;
switch (_that) {
case _NewsDto():
return $default(_that.symbol,_that.publishedDate,_that.title,_that.image,_that.site,_that.url,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String publishedDate,  String title,  String? image,  String site,  String url,  String? text)?  $default,) {final _that = this;
switch (_that) {
case _NewsDto() when $default != null:
return $default(_that.symbol,_that.publishedDate,_that.title,_that.image,_that.site,_that.url,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsDto implements NewsDto {
  const _NewsDto({required this.symbol, required this.publishedDate, required this.title, this.image, required this.site, required this.url, this.text});
  factory _NewsDto.fromJson(Map<String, dynamic> json) => _$NewsDtoFromJson(json);

@override final  String symbol;
@override final  String publishedDate;
@override final  String title;
@override final  String? image;
@override final  String site;
@override final  String url;
@override final  String? text;

/// Create a copy of NewsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsDtoCopyWith<_NewsDto> get copyWith => __$NewsDtoCopyWithImpl<_NewsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.publishedDate, publishedDate) || other.publishedDate == publishedDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.image, image) || other.image == image)&&(identical(other.site, site) || other.site == site)&&(identical(other.url, url) || other.url == url)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,publishedDate,title,image,site,url,text);

@override
String toString() {
  return 'NewsDto(symbol: $symbol, publishedDate: $publishedDate, title: $title, image: $image, site: $site, url: $url, text: $text)';
}


}

/// @nodoc
abstract mixin class _$NewsDtoCopyWith<$Res> implements $NewsDtoCopyWith<$Res> {
  factory _$NewsDtoCopyWith(_NewsDto value, $Res Function(_NewsDto) _then) = __$NewsDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String publishedDate, String title, String? image, String site, String url, String? text
});




}
/// @nodoc
class __$NewsDtoCopyWithImpl<$Res>
    implements _$NewsDtoCopyWith<$Res> {
  __$NewsDtoCopyWithImpl(this._self, this._then);

  final _NewsDto _self;
  final $Res Function(_NewsDto) _then;

/// Create a copy of NewsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? publishedDate = null,Object? title = null,Object? image = freezed,Object? site = null,Object? url = null,Object? text = freezed,}) {
  return _then(_NewsDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,publishedDate: null == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
