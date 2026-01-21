// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_more_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyMoreEvent {

 String get ticker;
/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyMoreEventCopyWith<CompanyMoreEvent> get copyWith => _$CompanyMoreEventCopyWithImpl<CompanyMoreEvent>(this as CompanyMoreEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyMoreEvent&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'CompanyMoreEvent(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $CompanyMoreEventCopyWith<$Res>  {
  factory $CompanyMoreEventCopyWith(CompanyMoreEvent value, $Res Function(CompanyMoreEvent) _then) = _$CompanyMoreEventCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$CompanyMoreEventCopyWithImpl<$Res>
    implements $CompanyMoreEventCopyWith<$Res> {
  _$CompanyMoreEventCopyWithImpl(this._self, this._then);

  final CompanyMoreEvent _self;
  final $Res Function(CompanyMoreEvent) _then;

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyMoreEvent].
extension CompanyMoreEventPatterns on CompanyMoreEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadRatios value)?  loadRatios,TResult Function( LoadKeyMetrics value)?  loadKeyMetrics,TResult Function( LoadAll value)?  loadAll,TResult Function( StalenessCheckRequested value)?  stalenessCheckRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadRatios() when loadRatios != null:
return loadRatios(_that);case LoadKeyMetrics() when loadKeyMetrics != null:
return loadKeyMetrics(_that);case LoadAll() when loadAll != null:
return loadAll(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadRatios value)  loadRatios,required TResult Function( LoadKeyMetrics value)  loadKeyMetrics,required TResult Function( LoadAll value)  loadAll,required TResult Function( StalenessCheckRequested value)  stalenessCheckRequested,}){
final _that = this;
switch (_that) {
case LoadRatios():
return loadRatios(_that);case LoadKeyMetrics():
return loadKeyMetrics(_that);case LoadAll():
return loadAll(_that);case StalenessCheckRequested():
return stalenessCheckRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadRatios value)?  loadRatios,TResult? Function( LoadKeyMetrics value)?  loadKeyMetrics,TResult? Function( LoadAll value)?  loadAll,TResult? Function( StalenessCheckRequested value)?  stalenessCheckRequested,}){
final _that = this;
switch (_that) {
case LoadRatios() when loadRatios != null:
return loadRatios(_that);case LoadKeyMetrics() when loadKeyMetrics != null:
return loadKeyMetrics(_that);case LoadAll() when loadAll != null:
return loadAll(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  bool forceRefresh)?  loadRatios,TResult Function( String ticker,  bool forceRefresh)?  loadKeyMetrics,TResult Function( String ticker,  bool forceRefresh)?  loadAll,TResult Function( String ticker)?  stalenessCheckRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadRatios() when loadRatios != null:
return loadRatios(_that.ticker,_that.forceRefresh);case LoadKeyMetrics() when loadKeyMetrics != null:
return loadKeyMetrics(_that.ticker,_that.forceRefresh);case LoadAll() when loadAll != null:
return loadAll(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  bool forceRefresh)  loadRatios,required TResult Function( String ticker,  bool forceRefresh)  loadKeyMetrics,required TResult Function( String ticker,  bool forceRefresh)  loadAll,required TResult Function( String ticker)  stalenessCheckRequested,}) {final _that = this;
switch (_that) {
case LoadRatios():
return loadRatios(_that.ticker,_that.forceRefresh);case LoadKeyMetrics():
return loadKeyMetrics(_that.ticker,_that.forceRefresh);case LoadAll():
return loadAll(_that.ticker,_that.forceRefresh);case StalenessCheckRequested():
return stalenessCheckRequested(_that.ticker);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  bool forceRefresh)?  loadRatios,TResult? Function( String ticker,  bool forceRefresh)?  loadKeyMetrics,TResult? Function( String ticker,  bool forceRefresh)?  loadAll,TResult? Function( String ticker)?  stalenessCheckRequested,}) {final _that = this;
switch (_that) {
case LoadRatios() when loadRatios != null:
return loadRatios(_that.ticker,_that.forceRefresh);case LoadKeyMetrics() when loadKeyMetrics != null:
return loadKeyMetrics(_that.ticker,_that.forceRefresh);case LoadAll() when loadAll != null:
return loadAll(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker);case _:
  return null;

}
}

}

/// @nodoc


class LoadRatios implements CompanyMoreEvent {
  const LoadRatios(this.ticker, {this.forceRefresh = false});
  

@override final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadRatiosCopyWith<LoadRatios> get copyWith => _$LoadRatiosCopyWithImpl<LoadRatios>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadRatios&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'CompanyMoreEvent.loadRatios(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadRatiosCopyWith<$Res> implements $CompanyMoreEventCopyWith<$Res> {
  factory $LoadRatiosCopyWith(LoadRatios value, $Res Function(LoadRatios) _then) = _$LoadRatiosCopyWithImpl;
@override @useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$LoadRatiosCopyWithImpl<$Res>
    implements $LoadRatiosCopyWith<$Res> {
  _$LoadRatiosCopyWithImpl(this._self, this._then);

  final LoadRatios _self;
  final $Res Function(LoadRatios) _then;

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadRatios(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LoadKeyMetrics implements CompanyMoreEvent {
  const LoadKeyMetrics(this.ticker, {this.forceRefresh = false});
  

@override final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadKeyMetricsCopyWith<LoadKeyMetrics> get copyWith => _$LoadKeyMetricsCopyWithImpl<LoadKeyMetrics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadKeyMetrics&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'CompanyMoreEvent.loadKeyMetrics(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadKeyMetricsCopyWith<$Res> implements $CompanyMoreEventCopyWith<$Res> {
  factory $LoadKeyMetricsCopyWith(LoadKeyMetrics value, $Res Function(LoadKeyMetrics) _then) = _$LoadKeyMetricsCopyWithImpl;
@override @useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$LoadKeyMetricsCopyWithImpl<$Res>
    implements $LoadKeyMetricsCopyWith<$Res> {
  _$LoadKeyMetricsCopyWithImpl(this._self, this._then);

  final LoadKeyMetrics _self;
  final $Res Function(LoadKeyMetrics) _then;

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadKeyMetrics(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LoadAll implements CompanyMoreEvent {
  const LoadAll(this.ticker, {this.forceRefresh = false});
  

@override final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadAllCopyWith<LoadAll> get copyWith => _$LoadAllCopyWithImpl<LoadAll>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadAll&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'CompanyMoreEvent.loadAll(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadAllCopyWith<$Res> implements $CompanyMoreEventCopyWith<$Res> {
  factory $LoadAllCopyWith(LoadAll value, $Res Function(LoadAll) _then) = _$LoadAllCopyWithImpl;
@override @useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$LoadAllCopyWithImpl<$Res>
    implements $LoadAllCopyWith<$Res> {
  _$LoadAllCopyWithImpl(this._self, this._then);

  final LoadAll _self;
  final $Res Function(LoadAll) _then;

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadAll(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StalenessCheckRequested implements CompanyMoreEvent {
  const StalenessCheckRequested(this.ticker);
  

@override final  String ticker;

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
  return 'CompanyMoreEvent.stalenessCheckRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $StalenessCheckRequestedCopyWith<$Res> implements $CompanyMoreEventCopyWith<$Res> {
  factory $StalenessCheckRequestedCopyWith(StalenessCheckRequested value, $Res Function(StalenessCheckRequested) _then) = _$StalenessCheckRequestedCopyWithImpl;
@override @useResult
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

/// Create a copy of CompanyMoreEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(StalenessCheckRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
