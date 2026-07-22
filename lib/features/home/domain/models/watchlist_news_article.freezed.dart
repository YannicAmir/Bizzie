// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_news_article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistNewsArticle {

 String get id; String get symbol; String get title; String get site; String get url; DateTime get publishedAt; String? get image;
/// Create a copy of WatchlistNewsArticle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistNewsArticleCopyWith<WatchlistNewsArticle> get copyWith => _$WatchlistNewsArticleCopyWithImpl<WatchlistNewsArticle>(this as WatchlistNewsArticle, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistNewsArticle&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.title, title) || other.title == title)&&(identical(other.site, site) || other.site == site)&&(identical(other.url, url) || other.url == url)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,id,symbol,title,site,url,publishedAt,image);

@override
String toString() {
  return 'WatchlistNewsArticle(id: $id, symbol: $symbol, title: $title, site: $site, url: $url, publishedAt: $publishedAt, image: $image)';
}


}

/// @nodoc
abstract mixin class $WatchlistNewsArticleCopyWith<$Res>  {
  factory $WatchlistNewsArticleCopyWith(WatchlistNewsArticle value, $Res Function(WatchlistNewsArticle) _then) = _$WatchlistNewsArticleCopyWithImpl;
@useResult
$Res call({
 String id, String symbol, String title, String site, String url, DateTime publishedAt, String? image
});




}
/// @nodoc
class _$WatchlistNewsArticleCopyWithImpl<$Res>
    implements $WatchlistNewsArticleCopyWith<$Res> {
  _$WatchlistNewsArticleCopyWithImpl(this._self, this._then);

  final WatchlistNewsArticle _self;
  final $Res Function(WatchlistNewsArticle) _then;

/// Create a copy of WatchlistNewsArticle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? symbol = null,Object? title = null,Object? site = null,Object? url = null,Object? publishedAt = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistNewsArticle].
extension WatchlistNewsArticlePatterns on WatchlistNewsArticle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistNewsArticle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistNewsArticle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistNewsArticle value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistNewsArticle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistNewsArticle value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistNewsArticle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String symbol,  String title,  String site,  String url,  DateTime publishedAt,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistNewsArticle() when $default != null:
return $default(_that.id,_that.symbol,_that.title,_that.site,_that.url,_that.publishedAt,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String symbol,  String title,  String site,  String url,  DateTime publishedAt,  String? image)  $default,) {final _that = this;
switch (_that) {
case _WatchlistNewsArticle():
return $default(_that.id,_that.symbol,_that.title,_that.site,_that.url,_that.publishedAt,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String symbol,  String title,  String site,  String url,  DateTime publishedAt,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistNewsArticle() when $default != null:
return $default(_that.id,_that.symbol,_that.title,_that.site,_that.url,_that.publishedAt,_that.image);case _:
  return null;

}
}

}

/// @nodoc


class _WatchlistNewsArticle implements WatchlistNewsArticle {
  const _WatchlistNewsArticle({required this.id, required this.symbol, required this.title, required this.site, required this.url, required this.publishedAt, this.image});
  

@override final  String id;
@override final  String symbol;
@override final  String title;
@override final  String site;
@override final  String url;
@override final  DateTime publishedAt;
@override final  String? image;

/// Create a copy of WatchlistNewsArticle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistNewsArticleCopyWith<_WatchlistNewsArticle> get copyWith => __$WatchlistNewsArticleCopyWithImpl<_WatchlistNewsArticle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistNewsArticle&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.title, title) || other.title == title)&&(identical(other.site, site) || other.site == site)&&(identical(other.url, url) || other.url == url)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,id,symbol,title,site,url,publishedAt,image);

@override
String toString() {
  return 'WatchlistNewsArticle(id: $id, symbol: $symbol, title: $title, site: $site, url: $url, publishedAt: $publishedAt, image: $image)';
}


}

/// @nodoc
abstract mixin class _$WatchlistNewsArticleCopyWith<$Res> implements $WatchlistNewsArticleCopyWith<$Res> {
  factory _$WatchlistNewsArticleCopyWith(_WatchlistNewsArticle value, $Res Function(_WatchlistNewsArticle) _then) = __$WatchlistNewsArticleCopyWithImpl;
@override @useResult
$Res call({
 String id, String symbol, String title, String site, String url, DateTime publishedAt, String? image
});




}
/// @nodoc
class __$WatchlistNewsArticleCopyWithImpl<$Res>
    implements _$WatchlistNewsArticleCopyWith<$Res> {
  __$WatchlistNewsArticleCopyWithImpl(this._self, this._then);

  final _WatchlistNewsArticle _self;
  final $Res Function(_WatchlistNewsArticle) _then;

/// Create a copy of WatchlistNewsArticle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? symbol = null,Object? title = null,Object? site = null,Object? url = null,Object? publishedAt = null,Object? image = freezed,}) {
  return _then(_WatchlistNewsArticle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
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
