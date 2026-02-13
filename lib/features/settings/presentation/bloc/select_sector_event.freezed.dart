// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_sector_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectSectorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectSectorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectSectorEvent()';
}


}

/// @nodoc
class $SelectSectorEventCopyWith<$Res>  {
$SelectSectorEventCopyWith(SelectSectorEvent _, $Res Function(SelectSectorEvent) __);
}


/// Adds pattern-matching-related methods to [SelectSectorEvent].
extension SelectSectorEventPatterns on SelectSectorEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SelectSector value)?  selectSector,TResult Function( SaveChanges value)?  saveChanges,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SelectSector() when selectSector != null:
return selectSector(_that);case SaveChanges() when saveChanges != null:
return saveChanges(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SelectSector value)  selectSector,required TResult Function( SaveChanges value)  saveChanges,}){
final _that = this;
switch (_that) {
case SelectSector():
return selectSector(_that);case SaveChanges():
return saveChanges(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SelectSector value)?  selectSector,TResult? Function( SaveChanges value)?  saveChanges,}){
final _that = this;
switch (_that) {
case SelectSector() when selectSector != null:
return selectSector(_that);case SaveChanges() when saveChanges != null:
return saveChanges(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Sector sector)?  selectSector,TResult Function()?  saveChanges,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SelectSector() when selectSector != null:
return selectSector(_that.sector);case SaveChanges() when saveChanges != null:
return saveChanges();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Sector sector)  selectSector,required TResult Function()  saveChanges,}) {final _that = this;
switch (_that) {
case SelectSector():
return selectSector(_that.sector);case SaveChanges():
return saveChanges();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Sector sector)?  selectSector,TResult? Function()?  saveChanges,}) {final _that = this;
switch (_that) {
case SelectSector() when selectSector != null:
return selectSector(_that.sector);case SaveChanges() when saveChanges != null:
return saveChanges();case _:
  return null;

}
}

}

/// @nodoc


class SelectSector implements SelectSectorEvent {
  const SelectSector(this.sector);
  

 final  Sector sector;

/// Create a copy of SelectSectorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectSectorCopyWith<SelectSector> get copyWith => _$SelectSectorCopyWithImpl<SelectSector>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectSector&&(identical(other.sector, sector) || other.sector == sector));
}


@override
int get hashCode => Object.hash(runtimeType,sector);

@override
String toString() {
  return 'SelectSectorEvent.selectSector(sector: $sector)';
}


}

/// @nodoc
abstract mixin class $SelectSectorCopyWith<$Res> implements $SelectSectorEventCopyWith<$Res> {
  factory $SelectSectorCopyWith(SelectSector value, $Res Function(SelectSector) _then) = _$SelectSectorCopyWithImpl;
@useResult
$Res call({
 Sector sector
});




}
/// @nodoc
class _$SelectSectorCopyWithImpl<$Res>
    implements $SelectSectorCopyWith<$Res> {
  _$SelectSectorCopyWithImpl(this._self, this._then);

  final SelectSector _self;
  final $Res Function(SelectSector) _then;

/// Create a copy of SelectSectorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sector = null,}) {
  return _then(SelectSector(
null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector,
  ));
}


}

/// @nodoc


class SaveChanges implements SelectSectorEvent {
  const SaveChanges();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveChanges);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectSectorEvent.saveChanges()';
}


}




// dart format on
