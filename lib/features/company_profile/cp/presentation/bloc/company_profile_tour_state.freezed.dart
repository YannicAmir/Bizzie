// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_tour_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyProfileTourState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileTourState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourState()';
}


}

/// @nodoc
class $CompanyProfileTourStateCopyWith<$Res>  {
$CompanyProfileTourStateCopyWith(CompanyProfileTourState _, $Res Function(CompanyProfileTourState) __);
}


/// Adds pattern-matching-related methods to [CompanyProfileTourState].
extension CompanyProfileTourStatePatterns on CompanyProfileTourState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( CompanyProfileTourActive value)?  active,TResult Function( CompanyProfileTourFinished value)?  finished,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CompanyProfileTourActive() when active != null:
return active(_that);case CompanyProfileTourFinished() when finished != null:
return finished(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( CompanyProfileTourActive value)  active,required TResult Function( CompanyProfileTourFinished value)  finished,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case CompanyProfileTourActive():
return active(_that);case CompanyProfileTourFinished():
return finished(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( CompanyProfileTourActive value)?  active,TResult? Function( CompanyProfileTourFinished value)?  finished,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CompanyProfileTourActive() when active != null:
return active(_that);case CompanyProfileTourFinished() when finished != null:
return finished(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String ticker,  String companyName,  bool shouldPromptNotifications,  CompanyProfileTourStep step,  bool isAwaitingRevenueData,  GrowthHighlight? revenueGrowth,  Set<CompanyProfileTourStep> completedSteps)?  active,TResult Function( bool shouldPromptNotifications,  bool wasSkipped)?  finished,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CompanyProfileTourActive() when active != null:
return active(_that.ticker,_that.companyName,_that.shouldPromptNotifications,_that.step,_that.isAwaitingRevenueData,_that.revenueGrowth,_that.completedSteps);case CompanyProfileTourFinished() when finished != null:
return finished(_that.shouldPromptNotifications,_that.wasSkipped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String ticker,  String companyName,  bool shouldPromptNotifications,  CompanyProfileTourStep step,  bool isAwaitingRevenueData,  GrowthHighlight? revenueGrowth,  Set<CompanyProfileTourStep> completedSteps)  active,required TResult Function( bool shouldPromptNotifications,  bool wasSkipped)  finished,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case CompanyProfileTourActive():
return active(_that.ticker,_that.companyName,_that.shouldPromptNotifications,_that.step,_that.isAwaitingRevenueData,_that.revenueGrowth,_that.completedSteps);case CompanyProfileTourFinished():
return finished(_that.shouldPromptNotifications,_that.wasSkipped);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String ticker,  String companyName,  bool shouldPromptNotifications,  CompanyProfileTourStep step,  bool isAwaitingRevenueData,  GrowthHighlight? revenueGrowth,  Set<CompanyProfileTourStep> completedSteps)?  active,TResult? Function( bool shouldPromptNotifications,  bool wasSkipped)?  finished,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CompanyProfileTourActive() when active != null:
return active(_that.ticker,_that.companyName,_that.shouldPromptNotifications,_that.step,_that.isAwaitingRevenueData,_that.revenueGrowth,_that.completedSteps);case CompanyProfileTourFinished() when finished != null:
return finished(_that.shouldPromptNotifications,_that.wasSkipped);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanyProfileTourState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CompanyProfileTourState.initial()';
}


}




/// @nodoc


class CompanyProfileTourActive implements CompanyProfileTourState {
  const CompanyProfileTourActive({required this.ticker, required this.companyName, required this.shouldPromptNotifications, required this.step, this.isAwaitingRevenueData = false, this.revenueGrowth,  Set<CompanyProfileTourStep> completedSteps = const <CompanyProfileTourStep>{}}): _completedSteps = completedSteps;
  

 final  String ticker;
 final  String companyName;
 final  bool shouldPromptNotifications;
 final  CompanyProfileTourStep step;
@JsonKey() final  bool isAwaitingRevenueData;
 final  GrowthHighlight? revenueGrowth;
 final  Set<CompanyProfileTourStep> _completedSteps;
@JsonKey() Set<CompanyProfileTourStep> get completedSteps {
  if (_completedSteps is EqualUnmodifiableSetView) return _completedSteps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_completedSteps);
}


/// Create a copy of CompanyProfileTourState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyProfileTourActiveCopyWith<CompanyProfileTourActive> get copyWith => _$CompanyProfileTourActiveCopyWithImpl<CompanyProfileTourActive>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileTourActive&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.shouldPromptNotifications, shouldPromptNotifications) || other.shouldPromptNotifications == shouldPromptNotifications)&&(identical(other.step, step) || other.step == step)&&(identical(other.isAwaitingRevenueData, isAwaitingRevenueData) || other.isAwaitingRevenueData == isAwaitingRevenueData)&&(identical(other.revenueGrowth, revenueGrowth) || other.revenueGrowth == revenueGrowth)&&const DeepCollectionEquality().equals(other.completedSteps, _completedSteps));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticker,companyName,shouldPromptNotifications,step,isAwaitingRevenueData,revenueGrowth,const DeepCollectionEquality().hash(_completedSteps));
}

@override
String toString() {
    return 'CompanyProfileTourState.active(ticker: $ticker, companyName: $companyName, shouldPromptNotifications: $shouldPromptNotifications, step: $step, isAwaitingRevenueData: $isAwaitingRevenueData, revenueGrowth: $revenueGrowth, completedSteps: $completedSteps)';
}


}

/// @nodoc
abstract mixin class $CompanyProfileTourActiveCopyWith<$Res> implements $CompanyProfileTourStateCopyWith<$Res> {
  factory $CompanyProfileTourActiveCopyWith(CompanyProfileTourActive value, $Res Function(CompanyProfileTourActive) _then) = _$CompanyProfileTourActiveCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName, bool shouldPromptNotifications, CompanyProfileTourStep step, bool isAwaitingRevenueData, GrowthHighlight? revenueGrowth, Set<CompanyProfileTourStep> completedSteps
});




}
/// @nodoc
class _$CompanyProfileTourActiveCopyWithImpl<$Res>
    implements $CompanyProfileTourActiveCopyWith<$Res> {
  _$CompanyProfileTourActiveCopyWithImpl(this._self, this._then);

  final CompanyProfileTourActive _self;
  final $Res Function(CompanyProfileTourActive) _then;

/// Create a copy of CompanyProfileTourState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? shouldPromptNotifications = null,Object? step = null,Object? isAwaitingRevenueData = null,Object? revenueGrowth = freezed,Object? completedSteps = null,}) {
  return _then(CompanyProfileTourActive(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,shouldPromptNotifications: null == shouldPromptNotifications ? _self.shouldPromptNotifications : shouldPromptNotifications // ignore: cast_nullable_to_non_nullable
as bool,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CompanyProfileTourStep,isAwaitingRevenueData: null == isAwaitingRevenueData ? _self.isAwaitingRevenueData : isAwaitingRevenueData // ignore: cast_nullable_to_non_nullable
as bool,revenueGrowth: freezed == revenueGrowth ? _self.revenueGrowth : revenueGrowth // ignore: cast_nullable_to_non_nullable
as GrowthHighlight?,completedSteps: null == completedSteps ? _self._completedSteps : completedSteps // ignore: cast_nullable_to_non_nullable
as Set<CompanyProfileTourStep>,
  ));
}


}

/// @nodoc


class CompanyProfileTourFinished implements CompanyProfileTourState {
  const CompanyProfileTourFinished({required this.shouldPromptNotifications, this.wasSkipped = false});
  

 final  bool shouldPromptNotifications;
@JsonKey() final  bool wasSkipped;

/// Create a copy of CompanyProfileTourState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyProfileTourFinishedCopyWith<CompanyProfileTourFinished> get copyWith => _$CompanyProfileTourFinishedCopyWithImpl<CompanyProfileTourFinished>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileTourFinished&&(identical(other.shouldPromptNotifications, shouldPromptNotifications) || other.shouldPromptNotifications == shouldPromptNotifications)&&(identical(other.wasSkipped, wasSkipped) || other.wasSkipped == wasSkipped));
}


@override
int get hashCode {
    return Object.hash(runtimeType,shouldPromptNotifications,wasSkipped);
}

@override
String toString() {
    return 'CompanyProfileTourState.finished(shouldPromptNotifications: $shouldPromptNotifications, wasSkipped: $wasSkipped)';
}


}

/// @nodoc
abstract mixin class $CompanyProfileTourFinishedCopyWith<$Res> implements $CompanyProfileTourStateCopyWith<$Res> {
  factory $CompanyProfileTourFinishedCopyWith(CompanyProfileTourFinished value, $Res Function(CompanyProfileTourFinished) _then) = _$CompanyProfileTourFinishedCopyWithImpl;
@useResult
$Res call({
 bool shouldPromptNotifications, bool wasSkipped
});




}
/// @nodoc
class _$CompanyProfileTourFinishedCopyWithImpl<$Res>
    implements $CompanyProfileTourFinishedCopyWith<$Res> {
  _$CompanyProfileTourFinishedCopyWithImpl(this._self, this._then);

  final CompanyProfileTourFinished _self;
  final $Res Function(CompanyProfileTourFinished) _then;

/// Create a copy of CompanyProfileTourState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shouldPromptNotifications = null,Object? wasSkipped = null,}) {
  return _then(CompanyProfileTourFinished(
shouldPromptNotifications: null == shouldPromptNotifications ? _self.shouldPromptNotifications : shouldPromptNotifications // ignore: cast_nullable_to_non_nullable
as bool,wasSkipped: null == wasSkipped ? _self.wasSkipped : wasSkipped // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
