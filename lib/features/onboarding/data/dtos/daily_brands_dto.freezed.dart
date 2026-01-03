// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_brands_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyBrandsDto {

@TimestampConverter() DateTime get date; List<DailyBrandSectorDto> get sectors;
/// Create a copy of DailyBrandsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBrandsDtoCopyWith<DailyBrandsDto> get copyWith => _$DailyBrandsDtoCopyWithImpl<DailyBrandsDto>(this as DailyBrandsDto, _$identity);

  /// Serializes this DailyBrandsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBrandsDto&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.sectors, sectors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(sectors));

@override
String toString() {
  return 'DailyBrandsDto(date: $date, sectors: $sectors)';
}


}

/// @nodoc
abstract mixin class $DailyBrandsDtoCopyWith<$Res>  {
  factory $DailyBrandsDtoCopyWith(DailyBrandsDto value, $Res Function(DailyBrandsDto) _then) = _$DailyBrandsDtoCopyWithImpl;
@useResult
$Res call({
@TimestampConverter() DateTime date, List<DailyBrandSectorDto> sectors
});




}
/// @nodoc
class _$DailyBrandsDtoCopyWithImpl<$Res>
    implements $DailyBrandsDtoCopyWith<$Res> {
  _$DailyBrandsDtoCopyWithImpl(this._self, this._then);

  final DailyBrandsDto _self;
  final $Res Function(DailyBrandsDto) _then;

/// Create a copy of DailyBrandsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? sectors = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,sectors: null == sectors ? _self.sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<DailyBrandSectorDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBrandsDto].
extension DailyBrandsDtoPatterns on DailyBrandsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBrandsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBrandsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBrandsDto value)  $default,){
final _that = this;
switch (_that) {
case _DailyBrandsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBrandsDto value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBrandsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@TimestampConverter()  DateTime date,  List<DailyBrandSectorDto> sectors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBrandsDto() when $default != null:
return $default(_that.date,_that.sectors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@TimestampConverter()  DateTime date,  List<DailyBrandSectorDto> sectors)  $default,) {final _that = this;
switch (_that) {
case _DailyBrandsDto():
return $default(_that.date,_that.sectors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@TimestampConverter()  DateTime date,  List<DailyBrandSectorDto> sectors)?  $default,) {final _that = this;
switch (_that) {
case _DailyBrandsDto() when $default != null:
return $default(_that.date,_that.sectors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyBrandsDto implements DailyBrandsDto {
  const _DailyBrandsDto({@TimestampConverter() required this.date, required final  List<DailyBrandSectorDto> sectors}): _sectors = sectors;
  factory _DailyBrandsDto.fromJson(Map<String, dynamic> json) => _$DailyBrandsDtoFromJson(json);

@override@TimestampConverter() final  DateTime date;
 final  List<DailyBrandSectorDto> _sectors;
@override List<DailyBrandSectorDto> get sectors {
  if (_sectors is EqualUnmodifiableListView) return _sectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectors);
}


/// Create a copy of DailyBrandsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBrandsDtoCopyWith<_DailyBrandsDto> get copyWith => __$DailyBrandsDtoCopyWithImpl<_DailyBrandsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyBrandsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBrandsDto&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._sectors, _sectors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_sectors));

@override
String toString() {
  return 'DailyBrandsDto(date: $date, sectors: $sectors)';
}


}

/// @nodoc
abstract mixin class _$DailyBrandsDtoCopyWith<$Res> implements $DailyBrandsDtoCopyWith<$Res> {
  factory _$DailyBrandsDtoCopyWith(_DailyBrandsDto value, $Res Function(_DailyBrandsDto) _then) = __$DailyBrandsDtoCopyWithImpl;
@override @useResult
$Res call({
@TimestampConverter() DateTime date, List<DailyBrandSectorDto> sectors
});




}
/// @nodoc
class __$DailyBrandsDtoCopyWithImpl<$Res>
    implements _$DailyBrandsDtoCopyWith<$Res> {
  __$DailyBrandsDtoCopyWithImpl(this._self, this._then);

  final _DailyBrandsDto _self;
  final $Res Function(_DailyBrandsDto) _then;

/// Create a copy of DailyBrandsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? sectors = null,}) {
  return _then(_DailyBrandsDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,sectors: null == sectors ? _self._sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<DailyBrandSectorDto>,
  ));
}


}


/// @nodoc
mixin _$DailyBrandSectorDto {

 String get name; List<DailyBrandProductDto> get products;
/// Create a copy of DailyBrandSectorDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBrandSectorDtoCopyWith<DailyBrandSectorDto> get copyWith => _$DailyBrandSectorDtoCopyWithImpl<DailyBrandSectorDto>(this as DailyBrandSectorDto, _$identity);

  /// Serializes this DailyBrandSectorDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBrandSectorDto&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.products, products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(products));

@override
String toString() {
  return 'DailyBrandSectorDto(name: $name, products: $products)';
}


}

/// @nodoc
abstract mixin class $DailyBrandSectorDtoCopyWith<$Res>  {
  factory $DailyBrandSectorDtoCopyWith(DailyBrandSectorDto value, $Res Function(DailyBrandSectorDto) _then) = _$DailyBrandSectorDtoCopyWithImpl;
@useResult
$Res call({
 String name, List<DailyBrandProductDto> products
});




}
/// @nodoc
class _$DailyBrandSectorDtoCopyWithImpl<$Res>
    implements $DailyBrandSectorDtoCopyWith<$Res> {
  _$DailyBrandSectorDtoCopyWithImpl(this._self, this._then);

  final DailyBrandSectorDto _self;
  final $Res Function(DailyBrandSectorDto) _then;

/// Create a copy of DailyBrandSectorDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? products = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<DailyBrandProductDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBrandSectorDto].
extension DailyBrandSectorDtoPatterns on DailyBrandSectorDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBrandSectorDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBrandSectorDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBrandSectorDto value)  $default,){
final _that = this;
switch (_that) {
case _DailyBrandSectorDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBrandSectorDto value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBrandSectorDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<DailyBrandProductDto> products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBrandSectorDto() when $default != null:
return $default(_that.name,_that.products);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<DailyBrandProductDto> products)  $default,) {final _that = this;
switch (_that) {
case _DailyBrandSectorDto():
return $default(_that.name,_that.products);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<DailyBrandProductDto> products)?  $default,) {final _that = this;
switch (_that) {
case _DailyBrandSectorDto() when $default != null:
return $default(_that.name,_that.products);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyBrandSectorDto implements DailyBrandSectorDto {
  const _DailyBrandSectorDto({required this.name, required final  List<DailyBrandProductDto> products}): _products = products;
  factory _DailyBrandSectorDto.fromJson(Map<String, dynamic> json) => _$DailyBrandSectorDtoFromJson(json);

@override final  String name;
 final  List<DailyBrandProductDto> _products;
@override List<DailyBrandProductDto> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of DailyBrandSectorDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBrandSectorDtoCopyWith<_DailyBrandSectorDto> get copyWith => __$DailyBrandSectorDtoCopyWithImpl<_DailyBrandSectorDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyBrandSectorDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBrandSectorDto&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._products, _products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'DailyBrandSectorDto(name: $name, products: $products)';
}


}

/// @nodoc
abstract mixin class _$DailyBrandSectorDtoCopyWith<$Res> implements $DailyBrandSectorDtoCopyWith<$Res> {
  factory _$DailyBrandSectorDtoCopyWith(_DailyBrandSectorDto value, $Res Function(_DailyBrandSectorDto) _then) = __$DailyBrandSectorDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, List<DailyBrandProductDto> products
});




}
/// @nodoc
class __$DailyBrandSectorDtoCopyWithImpl<$Res>
    implements _$DailyBrandSectorDtoCopyWith<$Res> {
  __$DailyBrandSectorDtoCopyWithImpl(this._self, this._then);

  final _DailyBrandSectorDto _self;
  final $Res Function(_DailyBrandSectorDto) _then;

/// Create a copy of DailyBrandSectorDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? products = null,}) {
  return _then(_DailyBrandSectorDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<DailyBrandProductDto>,
  ));
}


}


/// @nodoc
mixin _$DailyBrandProductDto {

 String get company; String get description; String get name; String get ticker;
/// Create a copy of DailyBrandProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBrandProductDtoCopyWith<DailyBrandProductDto> get copyWith => _$DailyBrandProductDtoCopyWithImpl<DailyBrandProductDto>(this as DailyBrandProductDto, _$identity);

  /// Serializes this DailyBrandProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBrandProductDto&&(identical(other.company, company) || other.company == company)&&(identical(other.description, description) || other.description == description)&&(identical(other.name, name) || other.name == name)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,company,description,name,ticker);

@override
String toString() {
  return 'DailyBrandProductDto(company: $company, description: $description, name: $name, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $DailyBrandProductDtoCopyWith<$Res>  {
  factory $DailyBrandProductDtoCopyWith(DailyBrandProductDto value, $Res Function(DailyBrandProductDto) _then) = _$DailyBrandProductDtoCopyWithImpl;
@useResult
$Res call({
 String company, String description, String name, String ticker
});




}
/// @nodoc
class _$DailyBrandProductDtoCopyWithImpl<$Res>
    implements $DailyBrandProductDtoCopyWith<$Res> {
  _$DailyBrandProductDtoCopyWithImpl(this._self, this._then);

  final DailyBrandProductDto _self;
  final $Res Function(DailyBrandProductDto) _then;

/// Create a copy of DailyBrandProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? company = null,Object? description = null,Object? name = null,Object? ticker = null,}) {
  return _then(_self.copyWith(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBrandProductDto].
extension DailyBrandProductDtoPatterns on DailyBrandProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBrandProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBrandProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBrandProductDto value)  $default,){
final _that = this;
switch (_that) {
case _DailyBrandProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBrandProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBrandProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String company,  String description,  String name,  String ticker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBrandProductDto() when $default != null:
return $default(_that.company,_that.description,_that.name,_that.ticker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String company,  String description,  String name,  String ticker)  $default,) {final _that = this;
switch (_that) {
case _DailyBrandProductDto():
return $default(_that.company,_that.description,_that.name,_that.ticker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String company,  String description,  String name,  String ticker)?  $default,) {final _that = this;
switch (_that) {
case _DailyBrandProductDto() when $default != null:
return $default(_that.company,_that.description,_that.name,_that.ticker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyBrandProductDto implements DailyBrandProductDto {
  const _DailyBrandProductDto({required this.company, required this.description, required this.name, required this.ticker});
  factory _DailyBrandProductDto.fromJson(Map<String, dynamic> json) => _$DailyBrandProductDtoFromJson(json);

@override final  String company;
@override final  String description;
@override final  String name;
@override final  String ticker;

/// Create a copy of DailyBrandProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBrandProductDtoCopyWith<_DailyBrandProductDto> get copyWith => __$DailyBrandProductDtoCopyWithImpl<_DailyBrandProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyBrandProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBrandProductDto&&(identical(other.company, company) || other.company == company)&&(identical(other.description, description) || other.description == description)&&(identical(other.name, name) || other.name == name)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,company,description,name,ticker);

@override
String toString() {
  return 'DailyBrandProductDto(company: $company, description: $description, name: $name, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class _$DailyBrandProductDtoCopyWith<$Res> implements $DailyBrandProductDtoCopyWith<$Res> {
  factory _$DailyBrandProductDtoCopyWith(_DailyBrandProductDto value, $Res Function(_DailyBrandProductDto) _then) = __$DailyBrandProductDtoCopyWithImpl;
@override @useResult
$Res call({
 String company, String description, String name, String ticker
});




}
/// @nodoc
class __$DailyBrandProductDtoCopyWithImpl<$Res>
    implements _$DailyBrandProductDtoCopyWith<$Res> {
  __$DailyBrandProductDtoCopyWithImpl(this._self, this._then);

  final _DailyBrandProductDto _self;
  final $Res Function(_DailyBrandProductDto) _then;

/// Create a copy of DailyBrandProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? company = null,Object? description = null,Object? name = null,Object? ticker = null,}) {
  return _then(_DailyBrandProductDto(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
