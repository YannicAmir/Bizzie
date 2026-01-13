// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsFeed {

 List<FinancialReport> get currentReports; List<FinancialReport> get pastReports; List<SecFiling> get filings; List<UpcomingEarnings> get upcomingEarnings;
/// Create a copy of ReportsFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsFeedCopyWith<ReportsFeed> get copyWith => _$ReportsFeedCopyWithImpl<ReportsFeed>(this as ReportsFeed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsFeed&&const DeepCollectionEquality().equals(other.currentReports, currentReports)&&const DeepCollectionEquality().equals(other.pastReports, pastReports)&&const DeepCollectionEquality().equals(other.filings, filings)&&const DeepCollectionEquality().equals(other.upcomingEarnings, upcomingEarnings));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(currentReports),const DeepCollectionEquality().hash(pastReports),const DeepCollectionEquality().hash(filings),const DeepCollectionEquality().hash(upcomingEarnings));

@override
String toString() {
  return 'ReportsFeed(currentReports: $currentReports, pastReports: $pastReports, filings: $filings, upcomingEarnings: $upcomingEarnings)';
}


}

/// @nodoc
abstract mixin class $ReportsFeedCopyWith<$Res>  {
  factory $ReportsFeedCopyWith(ReportsFeed value, $Res Function(ReportsFeed) _then) = _$ReportsFeedCopyWithImpl;
@useResult
$Res call({
 List<FinancialReport> currentReports, List<FinancialReport> pastReports, List<SecFiling> filings, List<UpcomingEarnings> upcomingEarnings
});




}
/// @nodoc
class _$ReportsFeedCopyWithImpl<$Res>
    implements $ReportsFeedCopyWith<$Res> {
  _$ReportsFeedCopyWithImpl(this._self, this._then);

  final ReportsFeed _self;
  final $Res Function(ReportsFeed) _then;

/// Create a copy of ReportsFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentReports = null,Object? pastReports = null,Object? filings = null,Object? upcomingEarnings = null,}) {
  return _then(_self.copyWith(
currentReports: null == currentReports ? _self.currentReports : currentReports // ignore: cast_nullable_to_non_nullable
as List<FinancialReport>,pastReports: null == pastReports ? _self.pastReports : pastReports // ignore: cast_nullable_to_non_nullable
as List<FinancialReport>,filings: null == filings ? _self.filings : filings // ignore: cast_nullable_to_non_nullable
as List<SecFiling>,upcomingEarnings: null == upcomingEarnings ? _self.upcomingEarnings : upcomingEarnings // ignore: cast_nullable_to_non_nullable
as List<UpcomingEarnings>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportsFeed].
extension ReportsFeedPatterns on ReportsFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportsFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportsFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportsFeed value)  $default,){
final _that = this;
switch (_that) {
case _ReportsFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportsFeed value)?  $default,){
final _that = this;
switch (_that) {
case _ReportsFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FinancialReport> currentReports,  List<FinancialReport> pastReports,  List<SecFiling> filings,  List<UpcomingEarnings> upcomingEarnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportsFeed() when $default != null:
return $default(_that.currentReports,_that.pastReports,_that.filings,_that.upcomingEarnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FinancialReport> currentReports,  List<FinancialReport> pastReports,  List<SecFiling> filings,  List<UpcomingEarnings> upcomingEarnings)  $default,) {final _that = this;
switch (_that) {
case _ReportsFeed():
return $default(_that.currentReports,_that.pastReports,_that.filings,_that.upcomingEarnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FinancialReport> currentReports,  List<FinancialReport> pastReports,  List<SecFiling> filings,  List<UpcomingEarnings> upcomingEarnings)?  $default,) {final _that = this;
switch (_that) {
case _ReportsFeed() when $default != null:
return $default(_that.currentReports,_that.pastReports,_that.filings,_that.upcomingEarnings);case _:
  return null;

}
}

}

/// @nodoc


class _ReportsFeed implements ReportsFeed {
  const _ReportsFeed({final  List<FinancialReport> currentReports = const [], final  List<FinancialReport> pastReports = const [], final  List<SecFiling> filings = const [], final  List<UpcomingEarnings> upcomingEarnings = const []}): _currentReports = currentReports,_pastReports = pastReports,_filings = filings,_upcomingEarnings = upcomingEarnings;
  

 final  List<FinancialReport> _currentReports;
@override@JsonKey() List<FinancialReport> get currentReports {
  if (_currentReports is EqualUnmodifiableListView) return _currentReports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currentReports);
}

 final  List<FinancialReport> _pastReports;
@override@JsonKey() List<FinancialReport> get pastReports {
  if (_pastReports is EqualUnmodifiableListView) return _pastReports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pastReports);
}

 final  List<SecFiling> _filings;
@override@JsonKey() List<SecFiling> get filings {
  if (_filings is EqualUnmodifiableListView) return _filings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filings);
}

 final  List<UpcomingEarnings> _upcomingEarnings;
@override@JsonKey() List<UpcomingEarnings> get upcomingEarnings {
  if (_upcomingEarnings is EqualUnmodifiableListView) return _upcomingEarnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcomingEarnings);
}


/// Create a copy of ReportsFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportsFeedCopyWith<_ReportsFeed> get copyWith => __$ReportsFeedCopyWithImpl<_ReportsFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportsFeed&&const DeepCollectionEquality().equals(other._currentReports, _currentReports)&&const DeepCollectionEquality().equals(other._pastReports, _pastReports)&&const DeepCollectionEquality().equals(other._filings, _filings)&&const DeepCollectionEquality().equals(other._upcomingEarnings, _upcomingEarnings));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_currentReports),const DeepCollectionEquality().hash(_pastReports),const DeepCollectionEquality().hash(_filings),const DeepCollectionEquality().hash(_upcomingEarnings));

@override
String toString() {
  return 'ReportsFeed(currentReports: $currentReports, pastReports: $pastReports, filings: $filings, upcomingEarnings: $upcomingEarnings)';
}


}

/// @nodoc
abstract mixin class _$ReportsFeedCopyWith<$Res> implements $ReportsFeedCopyWith<$Res> {
  factory _$ReportsFeedCopyWith(_ReportsFeed value, $Res Function(_ReportsFeed) _then) = __$ReportsFeedCopyWithImpl;
@override @useResult
$Res call({
 List<FinancialReport> currentReports, List<FinancialReport> pastReports, List<SecFiling> filings, List<UpcomingEarnings> upcomingEarnings
});




}
/// @nodoc
class __$ReportsFeedCopyWithImpl<$Res>
    implements _$ReportsFeedCopyWith<$Res> {
  __$ReportsFeedCopyWithImpl(this._self, this._then);

  final _ReportsFeed _self;
  final $Res Function(_ReportsFeed) _then;

/// Create a copy of ReportsFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentReports = null,Object? pastReports = null,Object? filings = null,Object? upcomingEarnings = null,}) {
  return _then(_ReportsFeed(
currentReports: null == currentReports ? _self._currentReports : currentReports // ignore: cast_nullable_to_non_nullable
as List<FinancialReport>,pastReports: null == pastReports ? _self._pastReports : pastReports // ignore: cast_nullable_to_non_nullable
as List<FinancialReport>,filings: null == filings ? _self._filings : filings // ignore: cast_nullable_to_non_nullable
as List<SecFiling>,upcomingEarnings: null == upcomingEarnings ? _self._upcomingEarnings : upcomingEarnings // ignore: cast_nullable_to_non_nullable
as List<UpcomingEarnings>,
  ));
}


}

// dart format on
