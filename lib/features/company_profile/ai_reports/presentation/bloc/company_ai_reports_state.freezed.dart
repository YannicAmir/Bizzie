// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_ai_reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyAiReportsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyAiReportsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsState()';
}


}

/// @nodoc
class $CompanyAiReportsStateCopyWith<$Res>  {
$CompanyAiReportsStateCopyWith(CompanyAiReportsState _, $Res Function(CompanyAiReportsState) __);
}


/// Adds pattern-matching-related methods to [CompanyAiReportsState].
extension CompanyAiReportsStatePatterns on CompanyAiReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( CompanyAiReportsLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanyAiReportsLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( CompanyAiReportsLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case CompanyAiReportsLoaded():
return loaded(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( CompanyAiReportsLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanyAiReportsLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String ticker,  CompanyFilings companyFilings,  String summaryButtonLabel,  AiReportForm selectedForm,  List<AiReportForm> forms,  AiReportsTabViewState? analyticsState)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanyAiReportsLoaded() when loaded != null:
return loaded(_that.ticker,_that.companyFilings,_that.summaryButtonLabel,_that.selectedForm,_that.forms,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String ticker,  CompanyFilings companyFilings,  String summaryButtonLabel,  AiReportForm selectedForm,  List<AiReportForm> forms,  AiReportsTabViewState? analyticsState)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case CompanyAiReportsLoaded():
return loaded(_that.ticker,_that.companyFilings,_that.summaryButtonLabel,_that.selectedForm,_that.forms,_that.analyticsState);case _Failure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String ticker,  CompanyFilings companyFilings,  String summaryButtonLabel,  AiReportForm selectedForm,  List<AiReportForm> forms,  AiReportsTabViewState? analyticsState)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanyAiReportsLoaded() when loaded != null:
return loaded(_that.ticker,_that.companyFilings,_that.summaryButtonLabel,_that.selectedForm,_that.forms,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanyAiReportsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsState.initial()';
}


}




/// @nodoc


class _Loading implements CompanyAiReportsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsState.loading()';
}


}




/// @nodoc


class CompanyAiReportsLoaded implements CompanyAiReportsState {
  const CompanyAiReportsLoaded({required this.ticker, required this.companyFilings, required this.summaryButtonLabel, this.selectedForm = AiReportForm.tenK, final  List<AiReportForm> forms = AiReportForm.values, this.analyticsState}): _forms = forms;
  

 final  String ticker;
 final  CompanyFilings companyFilings;
 final  String summaryButtonLabel;
@JsonKey() final  AiReportForm selectedForm;
 final  List<AiReportForm> _forms;
@JsonKey() List<AiReportForm> get forms {
  if (_forms is EqualUnmodifiableListView) return _forms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forms);
}

 final  AiReportsTabViewState? analyticsState;

/// Create a copy of CompanyAiReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyAiReportsLoadedCopyWith<CompanyAiReportsLoaded> get copyWith => _$CompanyAiReportsLoadedCopyWithImpl<CompanyAiReportsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyAiReportsLoaded&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyFilings, companyFilings) || other.companyFilings == companyFilings)&&(identical(other.summaryButtonLabel, summaryButtonLabel) || other.summaryButtonLabel == summaryButtonLabel)&&(identical(other.selectedForm, selectedForm) || other.selectedForm == selectedForm)&&const DeepCollectionEquality().equals(other._forms, _forms)&&(identical(other.analyticsState, analyticsState) || other.analyticsState == analyticsState));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyFilings,summaryButtonLabel,selectedForm,const DeepCollectionEquality().hash(_forms),analyticsState);

@override
String toString() {
  return 'CompanyAiReportsState.loaded(ticker: $ticker, companyFilings: $companyFilings, summaryButtonLabel: $summaryButtonLabel, selectedForm: $selectedForm, forms: $forms, analyticsState: $analyticsState)';
}


}

/// @nodoc
abstract mixin class $CompanyAiReportsLoadedCopyWith<$Res> implements $CompanyAiReportsStateCopyWith<$Res> {
  factory $CompanyAiReportsLoadedCopyWith(CompanyAiReportsLoaded value, $Res Function(CompanyAiReportsLoaded) _then) = _$CompanyAiReportsLoadedCopyWithImpl;
@useResult
$Res call({
 String ticker, CompanyFilings companyFilings, String summaryButtonLabel, AiReportForm selectedForm, List<AiReportForm> forms, AiReportsTabViewState? analyticsState
});


$CompanyFilingsCopyWith<$Res> get companyFilings;$AiReportsTabViewStateCopyWith<$Res>? get analyticsState;

}
/// @nodoc
class _$CompanyAiReportsLoadedCopyWithImpl<$Res>
    implements $CompanyAiReportsLoadedCopyWith<$Res> {
  _$CompanyAiReportsLoadedCopyWithImpl(this._self, this._then);

  final CompanyAiReportsLoaded _self;
  final $Res Function(CompanyAiReportsLoaded) _then;

/// Create a copy of CompanyAiReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyFilings = null,Object? summaryButtonLabel = null,Object? selectedForm = null,Object? forms = null,Object? analyticsState = freezed,}) {
  return _then(CompanyAiReportsLoaded(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyFilings: null == companyFilings ? _self.companyFilings : companyFilings // ignore: cast_nullable_to_non_nullable
as CompanyFilings,summaryButtonLabel: null == summaryButtonLabel ? _self.summaryButtonLabel : summaryButtonLabel // ignore: cast_nullable_to_non_nullable
as String,selectedForm: null == selectedForm ? _self.selectedForm : selectedForm // ignore: cast_nullable_to_non_nullable
as AiReportForm,forms: null == forms ? _self._forms : forms // ignore: cast_nullable_to_non_nullable
as List<AiReportForm>,analyticsState: freezed == analyticsState ? _self.analyticsState : analyticsState // ignore: cast_nullable_to_non_nullable
as AiReportsTabViewState?,
  ));
}

/// Create a copy of CompanyAiReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyFilingsCopyWith<$Res> get companyFilings {
  
  return $CompanyFilingsCopyWith<$Res>(_self.companyFilings, (value) {
    return _then(_self.copyWith(companyFilings: value));
  });
}/// Create a copy of CompanyAiReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiReportsTabViewStateCopyWith<$Res>? get analyticsState {
    if (_self.analyticsState == null) {
    return null;
  }

  return $AiReportsTabViewStateCopyWith<$Res>(_self.analyticsState!, (value) {
    return _then(_self.copyWith(analyticsState: value));
  });
}
}

/// @nodoc


class _Failure implements CompanyAiReportsState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of CompanyAiReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CompanyAiReportsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $CompanyAiReportsStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of CompanyAiReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of CompanyAiReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
