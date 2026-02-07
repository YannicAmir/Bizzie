// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_data_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarketDataSnapshot {

 String get date; List<SectorPeDto> get peList; List<SectorPerformanceDto> get performanceList; int get cacheTimestamp;
/// Create a copy of MarketDataSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketDataSnapshotCopyWith<MarketDataSnapshot> get copyWith => _$MarketDataSnapshotCopyWithImpl<MarketDataSnapshot>(this as MarketDataSnapshot, _$identity);

  /// Serializes this MarketDataSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketDataSnapshot&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.peList, peList)&&const DeepCollectionEquality().equals(other.performanceList, performanceList)&&(identical(other.cacheTimestamp, cacheTimestamp) || other.cacheTimestamp == cacheTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(peList),const DeepCollectionEquality().hash(performanceList),cacheTimestamp);

@override
String toString() {
  return 'MarketDataSnapshot(date: $date, peList: $peList, performanceList: $performanceList, cacheTimestamp: $cacheTimestamp)';
}


}

/// @nodoc
abstract mixin class $MarketDataSnapshotCopyWith<$Res>  {
  factory $MarketDataSnapshotCopyWith(MarketDataSnapshot value, $Res Function(MarketDataSnapshot) _then) = _$MarketDataSnapshotCopyWithImpl;
@useResult
$Res call({
 String date, List<SectorPeDto> peList, List<SectorPerformanceDto> performanceList, int cacheTimestamp
});




}
/// @nodoc
class _$MarketDataSnapshotCopyWithImpl<$Res>
    implements $MarketDataSnapshotCopyWith<$Res> {
  _$MarketDataSnapshotCopyWithImpl(this._self, this._then);

  final MarketDataSnapshot _self;
  final $Res Function(MarketDataSnapshot) _then;

/// Create a copy of MarketDataSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? peList = null,Object? performanceList = null,Object? cacheTimestamp = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,peList: null == peList ? _self.peList : peList // ignore: cast_nullable_to_non_nullable
as List<SectorPeDto>,performanceList: null == performanceList ? _self.performanceList : performanceList // ignore: cast_nullable_to_non_nullable
as List<SectorPerformanceDto>,cacheTimestamp: null == cacheTimestamp ? _self.cacheTimestamp : cacheTimestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketDataSnapshot].
extension MarketDataSnapshotPatterns on MarketDataSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketDataSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketDataSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketDataSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _MarketDataSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketDataSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _MarketDataSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  List<SectorPeDto> peList,  List<SectorPerformanceDto> performanceList,  int cacheTimestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketDataSnapshot() when $default != null:
return $default(_that.date,_that.peList,_that.performanceList,_that.cacheTimestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  List<SectorPeDto> peList,  List<SectorPerformanceDto> performanceList,  int cacheTimestamp)  $default,) {final _that = this;
switch (_that) {
case _MarketDataSnapshot():
return $default(_that.date,_that.peList,_that.performanceList,_that.cacheTimestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  List<SectorPeDto> peList,  List<SectorPerformanceDto> performanceList,  int cacheTimestamp)?  $default,) {final _that = this;
switch (_that) {
case _MarketDataSnapshot() when $default != null:
return $default(_that.date,_that.peList,_that.performanceList,_that.cacheTimestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketDataSnapshot implements MarketDataSnapshot {
  const _MarketDataSnapshot({required this.date, required final  List<SectorPeDto> peList, required final  List<SectorPerformanceDto> performanceList, required this.cacheTimestamp}): _peList = peList,_performanceList = performanceList;
  factory _MarketDataSnapshot.fromJson(Map<String, dynamic> json) => _$MarketDataSnapshotFromJson(json);

@override final  String date;
 final  List<SectorPeDto> _peList;
@override List<SectorPeDto> get peList {
  if (_peList is EqualUnmodifiableListView) return _peList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_peList);
}

 final  List<SectorPerformanceDto> _performanceList;
@override List<SectorPerformanceDto> get performanceList {
  if (_performanceList is EqualUnmodifiableListView) return _performanceList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_performanceList);
}

@override final  int cacheTimestamp;

/// Create a copy of MarketDataSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketDataSnapshotCopyWith<_MarketDataSnapshot> get copyWith => __$MarketDataSnapshotCopyWithImpl<_MarketDataSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketDataSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketDataSnapshot&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._peList, _peList)&&const DeepCollectionEquality().equals(other._performanceList, _performanceList)&&(identical(other.cacheTimestamp, cacheTimestamp) || other.cacheTimestamp == cacheTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_peList),const DeepCollectionEquality().hash(_performanceList),cacheTimestamp);

@override
String toString() {
  return 'MarketDataSnapshot(date: $date, peList: $peList, performanceList: $performanceList, cacheTimestamp: $cacheTimestamp)';
}


}

/// @nodoc
abstract mixin class _$MarketDataSnapshotCopyWith<$Res> implements $MarketDataSnapshotCopyWith<$Res> {
  factory _$MarketDataSnapshotCopyWith(_MarketDataSnapshot value, $Res Function(_MarketDataSnapshot) _then) = __$MarketDataSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String date, List<SectorPeDto> peList, List<SectorPerformanceDto> performanceList, int cacheTimestamp
});




}
/// @nodoc
class __$MarketDataSnapshotCopyWithImpl<$Res>
    implements _$MarketDataSnapshotCopyWith<$Res> {
  __$MarketDataSnapshotCopyWithImpl(this._self, this._then);

  final _MarketDataSnapshot _self;
  final $Res Function(_MarketDataSnapshot) _then;

/// Create a copy of MarketDataSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? peList = null,Object? performanceList = null,Object? cacheTimestamp = null,}) {
  return _then(_MarketDataSnapshot(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,peList: null == peList ? _self._peList : peList // ignore: cast_nullable_to_non_nullable
as List<SectorPeDto>,performanceList: null == performanceList ? _self._performanceList : performanceList // ignore: cast_nullable_to_non_nullable
as List<SectorPerformanceDto>,cacheTimestamp: null == cacheTimestamp ? _self.cacheTimestamp : cacheTimestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
