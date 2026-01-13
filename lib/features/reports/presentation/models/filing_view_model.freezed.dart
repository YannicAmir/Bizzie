// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filing_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FilingViewModel {

 SecFiling get filing; FinancialReport? get report;
/// Create a copy of FilingViewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilingViewModelCopyWith<FilingViewModel> get copyWith => _$FilingViewModelCopyWithImpl<FilingViewModel>(this as FilingViewModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilingViewModel&&(identical(other.filing, filing) || other.filing == filing)&&(identical(other.report, report) || other.report == report));
}


@override
int get hashCode => Object.hash(runtimeType,filing,report);

@override
String toString() {
  return 'FilingViewModel(filing: $filing, report: $report)';
}


}

/// @nodoc
abstract mixin class $FilingViewModelCopyWith<$Res>  {
  factory $FilingViewModelCopyWith(FilingViewModel value, $Res Function(FilingViewModel) _then) = _$FilingViewModelCopyWithImpl;
@useResult
$Res call({
 SecFiling filing, FinancialReport? report
});


$SecFilingCopyWith<$Res> get filing;$FinancialReportCopyWith<$Res>? get report;

}
/// @nodoc
class _$FilingViewModelCopyWithImpl<$Res>
    implements $FilingViewModelCopyWith<$Res> {
  _$FilingViewModelCopyWithImpl(this._self, this._then);

  final FilingViewModel _self;
  final $Res Function(FilingViewModel) _then;

/// Create a copy of FilingViewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filing = null,Object? report = freezed,}) {
  return _then(_self.copyWith(
filing: null == filing ? _self.filing : filing // ignore: cast_nullable_to_non_nullable
as SecFiling,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as FinancialReport?,
  ));
}
/// Create a copy of FilingViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecFilingCopyWith<$Res> get filing {
  
  return $SecFilingCopyWith<$Res>(_self.filing, (value) {
    return _then(_self.copyWith(filing: value));
  });
}/// Create a copy of FilingViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialReportCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $FinancialReportCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}


/// Adds pattern-matching-related methods to [FilingViewModel].
extension FilingViewModelPatterns on FilingViewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilingViewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilingViewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilingViewModel value)  $default,){
final _that = this;
switch (_that) {
case _FilingViewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilingViewModel value)?  $default,){
final _that = this;
switch (_that) {
case _FilingViewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SecFiling filing,  FinancialReport? report)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilingViewModel() when $default != null:
return $default(_that.filing,_that.report);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SecFiling filing,  FinancialReport? report)  $default,) {final _that = this;
switch (_that) {
case _FilingViewModel():
return $default(_that.filing,_that.report);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SecFiling filing,  FinancialReport? report)?  $default,) {final _that = this;
switch (_that) {
case _FilingViewModel() when $default != null:
return $default(_that.filing,_that.report);case _:
  return null;

}
}

}

/// @nodoc


class _FilingViewModel implements FilingViewModel {
  const _FilingViewModel({required this.filing, this.report});
  

@override final  SecFiling filing;
@override final  FinancialReport? report;

/// Create a copy of FilingViewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilingViewModelCopyWith<_FilingViewModel> get copyWith => __$FilingViewModelCopyWithImpl<_FilingViewModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilingViewModel&&(identical(other.filing, filing) || other.filing == filing)&&(identical(other.report, report) || other.report == report));
}


@override
int get hashCode => Object.hash(runtimeType,filing,report);

@override
String toString() {
  return 'FilingViewModel(filing: $filing, report: $report)';
}


}

/// @nodoc
abstract mixin class _$FilingViewModelCopyWith<$Res> implements $FilingViewModelCopyWith<$Res> {
  factory _$FilingViewModelCopyWith(_FilingViewModel value, $Res Function(_FilingViewModel) _then) = __$FilingViewModelCopyWithImpl;
@override @useResult
$Res call({
 SecFiling filing, FinancialReport? report
});


@override $SecFilingCopyWith<$Res> get filing;@override $FinancialReportCopyWith<$Res>? get report;

}
/// @nodoc
class __$FilingViewModelCopyWithImpl<$Res>
    implements _$FilingViewModelCopyWith<$Res> {
  __$FilingViewModelCopyWithImpl(this._self, this._then);

  final _FilingViewModel _self;
  final $Res Function(_FilingViewModel) _then;

/// Create a copy of FilingViewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filing = null,Object? report = freezed,}) {
  return _then(_FilingViewModel(
filing: null == filing ? _self.filing : filing // ignore: cast_nullable_to_non_nullable
as SecFiling,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as FinancialReport?,
  ));
}

/// Create a copy of FilingViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecFilingCopyWith<$Res> get filing {
  
  return $SecFilingCopyWith<$Res>(_self.filing, (value) {
    return _then(_self.copyWith(filing: value));
  });
}/// Create a copy of FilingViewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialReportCopyWith<$Res>? get report {
    if (_self.report == null) {
    return null;
  }

  return $FinancialReportCopyWith<$Res>(_self.report!, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}

// dart format on
