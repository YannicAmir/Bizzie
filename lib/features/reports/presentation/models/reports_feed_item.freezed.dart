// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_feed_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsFeedItem {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsFeedItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ReportsFeedItem()';
}


}

/// @nodoc
class $ReportsFeedItemCopyWith<$Res>  {
$ReportsFeedItemCopyWith(ReportsFeedItem _, $Res Function(ReportsFeedItem) __);
}


/// Adds pattern-matching-related methods to [ReportsFeedItem].
extension ReportsFeedItemPatterns on ReportsFeedItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReportsFeedFilingItem value)?  filing,TResult Function( ReportsFeedWeeklyItem value)?  weekly,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReportsFeedFilingItem() when filing != null:
return filing(_that);case ReportsFeedWeeklyItem() when weekly != null:
return weekly(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReportsFeedFilingItem value)  filing,required TResult Function( ReportsFeedWeeklyItem value)  weekly,}){
final _that = this;
switch (_that) {
case ReportsFeedFilingItem():
return filing(_that);case ReportsFeedWeeklyItem():
return weekly(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReportsFeedFilingItem value)?  filing,TResult? Function( ReportsFeedWeeklyItem value)?  weekly,}){
final _that = this;
switch (_that) {
case ReportsFeedFilingItem() when filing != null:
return filing(_that);case ReportsFeedWeeklyItem() when weekly != null:
return weekly(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( FilingViewModel viewModel)?  filing,TResult Function( WeeklyReport report)?  weekly,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReportsFeedFilingItem() when filing != null:
return filing(_that.viewModel);case ReportsFeedWeeklyItem() when weekly != null:
return weekly(_that.report);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( FilingViewModel viewModel)  filing,required TResult Function( WeeklyReport report)  weekly,}) {final _that = this;
switch (_that) {
case ReportsFeedFilingItem():
return filing(_that.viewModel);case ReportsFeedWeeklyItem():
return weekly(_that.report);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( FilingViewModel viewModel)?  filing,TResult? Function( WeeklyReport report)?  weekly,}) {final _that = this;
switch (_that) {
case ReportsFeedFilingItem() when filing != null:
return filing(_that.viewModel);case ReportsFeedWeeklyItem() when weekly != null:
return weekly(_that.report);case _:
  return null;

}
}

}

/// @nodoc


class ReportsFeedFilingItem extends ReportsFeedItem {
  const ReportsFeedFilingItem(this.viewModel): super._();
  

 final  FilingViewModel viewModel;

/// Create a copy of ReportsFeedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsFeedFilingItemCopyWith<ReportsFeedFilingItem> get copyWith => _$ReportsFeedFilingItemCopyWithImpl<ReportsFeedFilingItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsFeedFilingItem&&(identical(other.viewModel, viewModel) || other.viewModel == viewModel));
}


@override
int get hashCode {
    return Object.hash(runtimeType,viewModel);
}

@override
String toString() {
    return 'ReportsFeedItem.filing(viewModel: $viewModel)';
}


}

/// @nodoc
abstract mixin class $ReportsFeedFilingItemCopyWith<$Res> implements $ReportsFeedItemCopyWith<$Res> {
  factory $ReportsFeedFilingItemCopyWith(ReportsFeedFilingItem value, $Res Function(ReportsFeedFilingItem) _then) = _$ReportsFeedFilingItemCopyWithImpl;
@useResult
$Res call({
 FilingViewModel viewModel
});


$FilingViewModelCopyWith<$Res> get viewModel;

}
/// @nodoc
class _$ReportsFeedFilingItemCopyWithImpl<$Res>
    implements $ReportsFeedFilingItemCopyWith<$Res> {
  _$ReportsFeedFilingItemCopyWithImpl(this._self, this._then);

  final ReportsFeedFilingItem _self;
  final $Res Function(ReportsFeedFilingItem) _then;

/// Create a copy of ReportsFeedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? viewModel = null,}) {
  return _then(ReportsFeedFilingItem(
null == viewModel ? _self.viewModel : viewModel // ignore: cast_nullable_to_non_nullable
as FilingViewModel,
  ));
}

/// Create a copy of ReportsFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilingViewModelCopyWith<$Res> get viewModel {
  
  return $FilingViewModelCopyWith<$Res>(_self.viewModel, (value) {
    return _then(_self.copyWith(viewModel: value));
  });
}
}

/// @nodoc


class ReportsFeedWeeklyItem extends ReportsFeedItem {
  const ReportsFeedWeeklyItem(this.report): super._();
  

 final  WeeklyReport report;

/// Create a copy of ReportsFeedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsFeedWeeklyItemCopyWith<ReportsFeedWeeklyItem> get copyWith => _$ReportsFeedWeeklyItemCopyWithImpl<ReportsFeedWeeklyItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsFeedWeeklyItem&&(identical(other.report, report) || other.report == report));
}


@override
int get hashCode {
    return Object.hash(runtimeType,report);
}

@override
String toString() {
    return 'ReportsFeedItem.weekly(report: $report)';
}


}

/// @nodoc
abstract mixin class $ReportsFeedWeeklyItemCopyWith<$Res> implements $ReportsFeedItemCopyWith<$Res> {
  factory $ReportsFeedWeeklyItemCopyWith(ReportsFeedWeeklyItem value, $Res Function(ReportsFeedWeeklyItem) _then) = _$ReportsFeedWeeklyItemCopyWithImpl;
@useResult
$Res call({
 WeeklyReport report
});


$WeeklyReportCopyWith<$Res> get report;

}
/// @nodoc
class _$ReportsFeedWeeklyItemCopyWithImpl<$Res>
    implements $ReportsFeedWeeklyItemCopyWith<$Res> {
  _$ReportsFeedWeeklyItemCopyWithImpl(this._self, this._then);

  final ReportsFeedWeeklyItem _self;
  final $Res Function(ReportsFeedWeeklyItem) _then;

/// Create a copy of ReportsFeedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? report = null,}) {
  return _then(ReportsFeedWeeklyItem(
null == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as WeeklyReport,
  ));
}

/// Create a copy of ReportsFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeeklyReportCopyWith<$Res> get report {
  
  return $WeeklyReportCopyWith<$Res>(_self.report, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}

// dart format on
