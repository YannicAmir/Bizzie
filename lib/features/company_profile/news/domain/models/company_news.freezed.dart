// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyNews {

 String get symbol; List<NewsArticle> get articles;
/// Create a copy of CompanyNews
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyNewsCopyWith<CompanyNews> get copyWith => _$CompanyNewsCopyWithImpl<CompanyNews>(this as CompanyNews, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyNews&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other.articles, articles));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,const DeepCollectionEquality().hash(articles));

@override
String toString() {
  return 'CompanyNews(symbol: $symbol, articles: $articles)';
}


}

/// @nodoc
abstract mixin class $CompanyNewsCopyWith<$Res>  {
  factory $CompanyNewsCopyWith(CompanyNews value, $Res Function(CompanyNews) _then) = _$CompanyNewsCopyWithImpl;
@useResult
$Res call({
 String symbol, List<NewsArticle> articles
});




}
/// @nodoc
class _$CompanyNewsCopyWithImpl<$Res>
    implements $CompanyNewsCopyWith<$Res> {
  _$CompanyNewsCopyWithImpl(this._self, this._then);

  final CompanyNews _self;
  final $Res Function(CompanyNews) _then;

/// Create a copy of CompanyNews
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? articles = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<NewsArticle>,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyNews].
extension CompanyNewsPatterns on CompanyNews {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyNews value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyNews() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyNews value)  $default,){
final _that = this;
switch (_that) {
case _CompanyNews():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyNews value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyNews() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  List<NewsArticle> articles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyNews() when $default != null:
return $default(_that.symbol,_that.articles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  List<NewsArticle> articles)  $default,) {final _that = this;
switch (_that) {
case _CompanyNews():
return $default(_that.symbol,_that.articles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  List<NewsArticle> articles)?  $default,) {final _that = this;
switch (_that) {
case _CompanyNews() when $default != null:
return $default(_that.symbol,_that.articles);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyNews implements CompanyNews {
  const _CompanyNews({required this.symbol, required final  List<NewsArticle> articles}): _articles = articles;
  

@override final  String symbol;
 final  List<NewsArticle> _articles;
@override List<NewsArticle> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}


/// Create a copy of CompanyNews
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyNewsCopyWith<_CompanyNews> get copyWith => __$CompanyNewsCopyWithImpl<_CompanyNews>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyNews&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other._articles, _articles));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'CompanyNews(symbol: $symbol, articles: $articles)';
}


}

/// @nodoc
abstract mixin class _$CompanyNewsCopyWith<$Res> implements $CompanyNewsCopyWith<$Res> {
  factory _$CompanyNewsCopyWith(_CompanyNews value, $Res Function(_CompanyNews) _then) = __$CompanyNewsCopyWithImpl;
@override @useResult
$Res call({
 String symbol, List<NewsArticle> articles
});




}
/// @nodoc
class __$CompanyNewsCopyWithImpl<$Res>
    implements _$CompanyNewsCopyWith<$Res> {
  __$CompanyNewsCopyWithImpl(this._self, this._then);

  final _CompanyNews _self;
  final $Res Function(_CompanyNews) _then;

/// Create a copy of CompanyNews
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? articles = null,}) {
  return _then(_CompanyNews(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<NewsArticle>,
  ));
}


}

// dart format on
