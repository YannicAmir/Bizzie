// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_tour_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyProfileTourEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileTourEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourEvent()';
}


}

/// @nodoc
class $CompanyProfileTourEventCopyWith<$Res>  {
$CompanyProfileTourEventCopyWith(CompanyProfileTourEvent _, $Res Function(CompanyProfileTourEvent) __);
}


/// Adds pattern-matching-related methods to [CompanyProfileTourEvent].
extension CompanyProfileTourEventPatterns on CompanyProfileTourEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TourStarted value)?  started,TResult Function( TourStepCompleted value)?  stepCompleted,TResult Function( TourPreviousRequested value)?  previousRequested,TResult Function( TourRevenueTabSelected value)?  revenueTabSelected,TResult Function( TourRevenueGrowthResolved value)?  revenueGrowthResolved,TResult Function( TourTargetUnavailableReported value)?  targetUnavailableReported,TResult Function( TourSkipRequested value)?  skipRequested,TResult Function( TourReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TourStarted() when started != null:
return started(_that);case TourStepCompleted() when stepCompleted != null:
return stepCompleted(_that);case TourPreviousRequested() when previousRequested != null:
return previousRequested(_that);case TourRevenueTabSelected() when revenueTabSelected != null:
return revenueTabSelected(_that);case TourRevenueGrowthResolved() when revenueGrowthResolved != null:
return revenueGrowthResolved(_that);case TourTargetUnavailableReported() when targetUnavailableReported != null:
return targetUnavailableReported(_that);case TourSkipRequested() when skipRequested != null:
return skipRequested(_that);case TourReset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TourStarted value)  started,required TResult Function( TourStepCompleted value)  stepCompleted,required TResult Function( TourPreviousRequested value)  previousRequested,required TResult Function( TourRevenueTabSelected value)  revenueTabSelected,required TResult Function( TourRevenueGrowthResolved value)  revenueGrowthResolved,required TResult Function( TourTargetUnavailableReported value)  targetUnavailableReported,required TResult Function( TourSkipRequested value)  skipRequested,required TResult Function( TourReset value)  reset,}){
final _that = this;
switch (_that) {
case TourStarted():
return started(_that);case TourStepCompleted():
return stepCompleted(_that);case TourPreviousRequested():
return previousRequested(_that);case TourRevenueTabSelected():
return revenueTabSelected(_that);case TourRevenueGrowthResolved():
return revenueGrowthResolved(_that);case TourTargetUnavailableReported():
return targetUnavailableReported(_that);case TourSkipRequested():
return skipRequested(_that);case TourReset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TourStarted value)?  started,TResult? Function( TourStepCompleted value)?  stepCompleted,TResult? Function( TourPreviousRequested value)?  previousRequested,TResult? Function( TourRevenueTabSelected value)?  revenueTabSelected,TResult? Function( TourRevenueGrowthResolved value)?  revenueGrowthResolved,TResult? Function( TourTargetUnavailableReported value)?  targetUnavailableReported,TResult? Function( TourSkipRequested value)?  skipRequested,TResult? Function( TourReset value)?  reset,}){
final _that = this;
switch (_that) {
case TourStarted() when started != null:
return started(_that);case TourStepCompleted() when stepCompleted != null:
return stepCompleted(_that);case TourPreviousRequested() when previousRequested != null:
return previousRequested(_that);case TourRevenueTabSelected() when revenueTabSelected != null:
return revenueTabSelected(_that);case TourRevenueGrowthResolved() when revenueGrowthResolved != null:
return revenueGrowthResolved(_that);case TourTargetUnavailableReported() when targetUnavailableReported != null:
return targetUnavailableReported(_that);case TourSkipRequested() when skipRequested != null:
return skipRequested(_that);case TourReset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  String companyName,  bool shouldPromptNotifications)?  started,TResult Function()?  stepCompleted,TResult Function()?  previousRequested,TResult Function()?  revenueTabSelected,TResult Function( GrowthHighlight? growth)?  revenueGrowthResolved,TResult Function()?  targetUnavailableReported,TResult Function()?  skipRequested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TourStarted() when started != null:
return started(_that.ticker,_that.companyName,_that.shouldPromptNotifications);case TourStepCompleted() when stepCompleted != null:
return stepCompleted();case TourPreviousRequested() when previousRequested != null:
return previousRequested();case TourRevenueTabSelected() when revenueTabSelected != null:
return revenueTabSelected();case TourRevenueGrowthResolved() when revenueGrowthResolved != null:
return revenueGrowthResolved(_that.growth);case TourTargetUnavailableReported() when targetUnavailableReported != null:
return targetUnavailableReported();case TourSkipRequested() when skipRequested != null:
return skipRequested();case TourReset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  String companyName,  bool shouldPromptNotifications)  started,required TResult Function()  stepCompleted,required TResult Function()  previousRequested,required TResult Function()  revenueTabSelected,required TResult Function( GrowthHighlight? growth)  revenueGrowthResolved,required TResult Function()  targetUnavailableReported,required TResult Function()  skipRequested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case TourStarted():
return started(_that.ticker,_that.companyName,_that.shouldPromptNotifications);case TourStepCompleted():
return stepCompleted();case TourPreviousRequested():
return previousRequested();case TourRevenueTabSelected():
return revenueTabSelected();case TourRevenueGrowthResolved():
return revenueGrowthResolved(_that.growth);case TourTargetUnavailableReported():
return targetUnavailableReported();case TourSkipRequested():
return skipRequested();case TourReset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  String companyName,  bool shouldPromptNotifications)?  started,TResult? Function()?  stepCompleted,TResult? Function()?  previousRequested,TResult? Function()?  revenueTabSelected,TResult? Function( GrowthHighlight? growth)?  revenueGrowthResolved,TResult? Function()?  targetUnavailableReported,TResult? Function()?  skipRequested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case TourStarted() when started != null:
return started(_that.ticker,_that.companyName,_that.shouldPromptNotifications);case TourStepCompleted() when stepCompleted != null:
return stepCompleted();case TourPreviousRequested() when previousRequested != null:
return previousRequested();case TourRevenueTabSelected() when revenueTabSelected != null:
return revenueTabSelected();case TourRevenueGrowthResolved() when revenueGrowthResolved != null:
return revenueGrowthResolved(_that.growth);case TourTargetUnavailableReported() when targetUnavailableReported != null:
return targetUnavailableReported();case TourSkipRequested() when skipRequested != null:
return skipRequested();case TourReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class TourStarted implements CompanyProfileTourEvent {
  const TourStarted({required this.ticker, required this.companyName, required this.shouldPromptNotifications});
  

 final  String ticker;
 final  String companyName;
 final  bool shouldPromptNotifications;

/// Create a copy of CompanyProfileTourEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourStartedCopyWith<TourStarted> get copyWith => _$TourStartedCopyWithImpl<TourStarted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TourStarted&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.shouldPromptNotifications, shouldPromptNotifications) || other.shouldPromptNotifications == shouldPromptNotifications));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticker,companyName,shouldPromptNotifications);
}

@override
String toString() {
    return 'CompanyProfileTourEvent.started(ticker: $ticker, companyName: $companyName, shouldPromptNotifications: $shouldPromptNotifications)';
}


}

/// @nodoc
abstract mixin class $TourStartedCopyWith<$Res> implements $CompanyProfileTourEventCopyWith<$Res> {
  factory $TourStartedCopyWith(TourStarted value, $Res Function(TourStarted) _then) = _$TourStartedCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName, bool shouldPromptNotifications
});




}
/// @nodoc
class _$TourStartedCopyWithImpl<$Res>
    implements $TourStartedCopyWith<$Res> {
  _$TourStartedCopyWithImpl(this._self, this._then);

  final TourStarted _self;
  final $Res Function(TourStarted) _then;

/// Create a copy of CompanyProfileTourEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? shouldPromptNotifications = null,}) {
  return _then(TourStarted(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,shouldPromptNotifications: null == shouldPromptNotifications ? _self.shouldPromptNotifications : shouldPromptNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class TourStepCompleted implements CompanyProfileTourEvent {
  const TourStepCompleted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TourStepCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourEvent.stepCompleted()';
}


}




/// @nodoc


class TourPreviousRequested implements CompanyProfileTourEvent {
  const TourPreviousRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TourPreviousRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourEvent.previousRequested()';
}


}




/// @nodoc


class TourRevenueTabSelected implements CompanyProfileTourEvent {
  const TourRevenueTabSelected();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TourRevenueTabSelected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourEvent.revenueTabSelected()';
}


}




/// @nodoc


class TourRevenueGrowthResolved implements CompanyProfileTourEvent {
  const TourRevenueGrowthResolved(this.growth);
  

 final  GrowthHighlight? growth;

/// Create a copy of CompanyProfileTourEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourRevenueGrowthResolvedCopyWith<TourRevenueGrowthResolved> get copyWith => _$TourRevenueGrowthResolvedCopyWithImpl<TourRevenueGrowthResolved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TourRevenueGrowthResolved&&(identical(other.growth, growth) || other.growth == growth));
}


@override
int get hashCode {
    return Object.hash(runtimeType,growth);
}

@override
String toString() {
    return 'CompanyProfileTourEvent.revenueGrowthResolved(growth: $growth)';
}


}

/// @nodoc
abstract mixin class $TourRevenueGrowthResolvedCopyWith<$Res> implements $CompanyProfileTourEventCopyWith<$Res> {
  factory $TourRevenueGrowthResolvedCopyWith(TourRevenueGrowthResolved value, $Res Function(TourRevenueGrowthResolved) _then) = _$TourRevenueGrowthResolvedCopyWithImpl;
@useResult
$Res call({
 GrowthHighlight? growth
});




}
/// @nodoc
class _$TourRevenueGrowthResolvedCopyWithImpl<$Res>
    implements $TourRevenueGrowthResolvedCopyWith<$Res> {
  _$TourRevenueGrowthResolvedCopyWithImpl(this._self, this._then);

  final TourRevenueGrowthResolved _self;
  final $Res Function(TourRevenueGrowthResolved) _then;

/// Create a copy of CompanyProfileTourEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? growth = freezed,}) {
  return _then(TourRevenueGrowthResolved(
freezed == growth ? _self.growth : growth // ignore: cast_nullable_to_non_nullable
as GrowthHighlight?,
  ));
}


}

/// @nodoc


class TourTargetUnavailableReported implements CompanyProfileTourEvent {
  const TourTargetUnavailableReported();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TourTargetUnavailableReported);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourEvent.targetUnavailableReported()';
}


}




/// @nodoc


class TourSkipRequested implements CompanyProfileTourEvent {
  const TourSkipRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TourSkipRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourEvent.skipRequested()';
}


}




/// @nodoc


class TourReset implements CompanyProfileTourEvent {
  const TourReset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TourReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourEvent.reset()';
}


}




// dart format on
