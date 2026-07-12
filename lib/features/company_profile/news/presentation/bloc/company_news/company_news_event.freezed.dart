// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_news_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyNewsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyNewsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyNewsEvent()';
}


}

/// @nodoc
class $CompanyNewsEventCopyWith<$Res>  {
$CompanyNewsEventCopyWith(CompanyNewsEvent _, $Res Function(CompanyNewsEvent) __);
}


/// Adds pattern-matching-related methods to [CompanyNewsEvent].
extension CompanyNewsEventPatterns on CompanyNewsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadRequested value)?  loadRequested,TResult Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult Function( TabShown value)?  tabShown,TResult Function( TabHidden value)?  tabHidden,TResult Function( AppBackgrounded value)?  appBackgrounded,TResult Function( AppForegrounded value)?  appForegrounded,TResult Function( ArticleTapped value)?  articleTapped,TResult Function( Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case ArticleTapped() when articleTapped != null:
return articleTapped(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadRequested value)  loadRequested,required TResult Function( StalenessCheckRequested value)  stalenessCheckRequested,required TResult Function( TabShown value)  tabShown,required TResult Function( TabHidden value)  tabHidden,required TResult Function( AppBackgrounded value)  appBackgrounded,required TResult Function( AppForegrounded value)  appForegrounded,required TResult Function( ArticleTapped value)  articleTapped,required TResult Function( Reset value)  reset,}){
final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that);case StalenessCheckRequested():
return stalenessCheckRequested(_that);case TabShown():
return tabShown(_that);case TabHidden():
return tabHidden(_that);case AppBackgrounded():
return appBackgrounded(_that);case AppForegrounded():
return appForegrounded(_that);case ArticleTapped():
return articleTapped(_that);case Reset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadRequested value)?  loadRequested,TResult? Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult? Function( TabShown value)?  tabShown,TResult? Function( TabHidden value)?  tabHidden,TResult? Function( AppBackgrounded value)?  appBackgrounded,TResult? Function( AppForegrounded value)?  appForegrounded,TResult? Function( ArticleTapped value)?  articleTapped,TResult? Function( Reset value)?  reset,}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case ArticleTapped() when articleTapped != null:
return articleTapped(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  bool forceRefresh)?  loadRequested,TResult Function( String ticker)?  stalenessCheckRequested,TResult Function( String ticker)?  tabShown,TResult Function()?  tabHidden,TResult Function()?  appBackgrounded,TResult Function()?  appForegrounded,TResult Function( NewsArticle article,  bool isFeatured)?  articleTapped,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case ArticleTapped() when articleTapped != null:
return articleTapped(_that.article,_that.isFeatured);case Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  bool forceRefresh)  loadRequested,required TResult Function( String ticker)  stalenessCheckRequested,required TResult Function( String ticker)  tabShown,required TResult Function()  tabHidden,required TResult Function()  appBackgrounded,required TResult Function()  appForegrounded,required TResult Function( NewsArticle article,  bool isFeatured)  articleTapped,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested():
return stalenessCheckRequested(_that.ticker);case TabShown():
return tabShown(_that.ticker);case TabHidden():
return tabHidden();case AppBackgrounded():
return appBackgrounded();case AppForegrounded():
return appForegrounded();case ArticleTapped():
return articleTapped(_that.article,_that.isFeatured);case Reset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  bool forceRefresh)?  loadRequested,TResult? Function( String ticker)?  stalenessCheckRequested,TResult? Function( String ticker)?  tabShown,TResult? Function()?  tabHidden,TResult? Function()?  appBackgrounded,TResult? Function()?  appForegrounded,TResult? Function( NewsArticle article,  bool isFeatured)?  articleTapped,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case ArticleTapped() when articleTapped != null:
return articleTapped(_that.article,_that.isFeatured);case Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class LoadRequested implements CompanyNewsEvent {
  const LoadRequested(this.ticker, {this.forceRefresh = false});
  

 final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadRequestedCopyWith<LoadRequested> get copyWith => _$LoadRequestedCopyWithImpl<LoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadRequested&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'CompanyNewsEvent.loadRequested(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadRequestedCopyWith<$Res> implements $CompanyNewsEventCopyWith<$Res> {
  factory $LoadRequestedCopyWith(LoadRequested value, $Res Function(LoadRequested) _then) = _$LoadRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$LoadRequestedCopyWithImpl<$Res>
    implements $LoadRequestedCopyWith<$Res> {
  _$LoadRequestedCopyWithImpl(this._self, this._then);

  final LoadRequested _self;
  final $Res Function(LoadRequested) _then;

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StalenessCheckRequested implements CompanyNewsEvent {
  const StalenessCheckRequested(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StalenessCheckRequestedCopyWith<StalenessCheckRequested> get copyWith => _$StalenessCheckRequestedCopyWithImpl<StalenessCheckRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StalenessCheckRequested&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'CompanyNewsEvent.stalenessCheckRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $StalenessCheckRequestedCopyWith<$Res> implements $CompanyNewsEventCopyWith<$Res> {
  factory $StalenessCheckRequestedCopyWith(StalenessCheckRequested value, $Res Function(StalenessCheckRequested) _then) = _$StalenessCheckRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$StalenessCheckRequestedCopyWithImpl<$Res>
    implements $StalenessCheckRequestedCopyWith<$Res> {
  _$StalenessCheckRequestedCopyWithImpl(this._self, this._then);

  final StalenessCheckRequested _self;
  final $Res Function(StalenessCheckRequested) _then;

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(StalenessCheckRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabShown implements CompanyNewsEvent {
  const TabShown(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabShownCopyWith<TabShown> get copyWith => _$TabShownCopyWithImpl<TabShown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabShown&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'CompanyNewsEvent.tabShown(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $TabShownCopyWith<$Res> implements $CompanyNewsEventCopyWith<$Res> {
  factory $TabShownCopyWith(TabShown value, $Res Function(TabShown) _then) = _$TabShownCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$TabShownCopyWithImpl<$Res>
    implements $TabShownCopyWith<$Res> {
  _$TabShownCopyWithImpl(this._self, this._then);

  final TabShown _self;
  final $Res Function(TabShown) _then;

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(TabShown(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabHidden implements CompanyNewsEvent {
  const TabHidden();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabHidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyNewsEvent.tabHidden()';
}


}




/// @nodoc


class AppBackgrounded implements CompanyNewsEvent {
  const AppBackgrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBackgrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyNewsEvent.appBackgrounded()';
}


}




/// @nodoc


class AppForegrounded implements CompanyNewsEvent {
  const AppForegrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppForegrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyNewsEvent.appForegrounded()';
}


}




/// @nodoc


class ArticleTapped implements CompanyNewsEvent {
  const ArticleTapped({required this.article, required this.isFeatured});
  

 final  NewsArticle article;
 final  bool isFeatured;

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleTappedCopyWith<ArticleTapped> get copyWith => _$ArticleTappedCopyWithImpl<ArticleTapped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleTapped&&(identical(other.article, article) || other.article == article)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}


@override
int get hashCode => Object.hash(runtimeType,article,isFeatured);

@override
String toString() {
  return 'CompanyNewsEvent.articleTapped(article: $article, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $ArticleTappedCopyWith<$Res> implements $CompanyNewsEventCopyWith<$Res> {
  factory $ArticleTappedCopyWith(ArticleTapped value, $Res Function(ArticleTapped) _then) = _$ArticleTappedCopyWithImpl;
@useResult
$Res call({
 NewsArticle article, bool isFeatured
});


$NewsArticleCopyWith<$Res> get article;

}
/// @nodoc
class _$ArticleTappedCopyWithImpl<$Res>
    implements $ArticleTappedCopyWith<$Res> {
  _$ArticleTappedCopyWithImpl(this._self, this._then);

  final ArticleTapped _self;
  final $Res Function(ArticleTapped) _then;

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? article = null,Object? isFeatured = null,}) {
  return _then(ArticleTapped(
article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as NewsArticle,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CompanyNewsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsArticleCopyWith<$Res> get article {
  
  return $NewsArticleCopyWith<$Res>(_self.article, (value) {
    return _then(_self.copyWith(article: value));
  });
}
}

/// @nodoc


class Reset implements CompanyNewsEvent {
  const Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyNewsEvent.reset()';
}


}




// dart format on
