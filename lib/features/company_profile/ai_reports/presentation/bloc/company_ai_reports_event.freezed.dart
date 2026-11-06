// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_ai_reports_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyAiReportsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyAiReportsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsEvent()';
}


}

/// @nodoc
class $CompanyAiReportsEventCopyWith<$Res>  {
$CompanyAiReportsEventCopyWith(CompanyAiReportsEvent _, $Res Function(CompanyAiReportsEvent) __);
}


/// Adds pattern-matching-related methods to [CompanyAiReportsEvent].
extension CompanyAiReportsEventPatterns on CompanyAiReportsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( LoadRequested value)?  loadRequested,TResult Function( TabShown value)?  tabShown,TResult Function( TabHidden value)?  tabHidden,TResult Function( AppBackgrounded value)?  appBackgrounded,TResult Function( AppForegrounded value)?  appForegrounded,TResult Function( FormChanged value)?  formChanged,TResult Function( ReportOpened value)?  reportOpened,TResult Function( FilingLinkOpened value)?  filingLinkOpened,TResult Function( Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case LoadRequested() when loadRequested != null:
return loadRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case FormChanged() when formChanged != null:
return formChanged(_that);case ReportOpened() when reportOpened != null:
return reportOpened(_that);case FilingLinkOpened() when filingLinkOpened != null:
return filingLinkOpened(_that);case Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( LoadRequested value)  loadRequested,required TResult Function( TabShown value)  tabShown,required TResult Function( TabHidden value)  tabHidden,required TResult Function( AppBackgrounded value)  appBackgrounded,required TResult Function( AppForegrounded value)  appForegrounded,required TResult Function( FormChanged value)  formChanged,required TResult Function( ReportOpened value)  reportOpened,required TResult Function( FilingLinkOpened value)  filingLinkOpened,required TResult Function( Reset value)  reset,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case LoadRequested():
return loadRequested(_that);case TabShown():
return tabShown(_that);case TabHidden():
return tabHidden(_that);case AppBackgrounded():
return appBackgrounded(_that);case AppForegrounded():
return appForegrounded(_that);case FormChanged():
return formChanged(_that);case ReportOpened():
return reportOpened(_that);case FilingLinkOpened():
return filingLinkOpened(_that);case Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( LoadRequested value)?  loadRequested,TResult? Function( TabShown value)?  tabShown,TResult? Function( TabHidden value)?  tabHidden,TResult? Function( AppBackgrounded value)?  appBackgrounded,TResult? Function( AppForegrounded value)?  appForegrounded,TResult? Function( FormChanged value)?  formChanged,TResult? Function( ReportOpened value)?  reportOpened,TResult? Function( FilingLinkOpened value)?  filingLinkOpened,TResult? Function( Reset value)?  reset,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case LoadRequested() when loadRequested != null:
return loadRequested(_that);case TabShown() when tabShown != null:
return tabShown(_that);case TabHidden() when tabHidden != null:
return tabHidden(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case FormChanged() when formChanged != null:
return formChanged(_that);case ReportOpened() when reportOpened != null:
return reportOpened(_that);case FilingLinkOpened() when filingLinkOpened != null:
return filingLinkOpened(_that);case Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker)?  started,TResult Function( String ticker)?  loadRequested,TResult Function( String ticker)?  tabShown,TResult Function()?  tabHidden,TResult Function()?  appBackgrounded,TResult Function()?  appForegrounded,TResult Function( AiReportForm form)?  formChanged,TResult Function()?  reportOpened,TResult Function()?  filingLinkOpened,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that.ticker);case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case FormChanged() when formChanged != null:
return formChanged(_that.form);case ReportOpened() when reportOpened != null:
return reportOpened();case FilingLinkOpened() when filingLinkOpened != null:
return filingLinkOpened();case Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker)  started,required TResult Function( String ticker)  loadRequested,required TResult Function( String ticker)  tabShown,required TResult Function()  tabHidden,required TResult Function()  appBackgrounded,required TResult Function()  appForegrounded,required TResult Function( AiReportForm form)  formChanged,required TResult Function()  reportOpened,required TResult Function()  filingLinkOpened,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case Started():
return started(_that.ticker);case LoadRequested():
return loadRequested(_that.ticker);case TabShown():
return tabShown(_that.ticker);case TabHidden():
return tabHidden();case AppBackgrounded():
return appBackgrounded();case AppForegrounded():
return appForegrounded();case FormChanged():
return formChanged(_that.form);case ReportOpened():
return reportOpened();case FilingLinkOpened():
return filingLinkOpened();case Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker)?  started,TResult? Function( String ticker)?  loadRequested,TResult? Function( String ticker)?  tabShown,TResult? Function()?  tabHidden,TResult? Function()?  appBackgrounded,TResult? Function()?  appForegrounded,TResult? Function( AiReportForm form)?  formChanged,TResult? Function()?  reportOpened,TResult? Function()?  filingLinkOpened,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that.ticker);case LoadRequested() when loadRequested != null:
return loadRequested(_that.ticker);case TabShown() when tabShown != null:
return tabShown(_that.ticker);case TabHidden() when tabHidden != null:
return tabHidden();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case FormChanged() when formChanged != null:
return formChanged(_that.form);case ReportOpened() when reportOpened != null:
return reportOpened();case FilingLinkOpened() when filingLinkOpened != null:
return filingLinkOpened();case Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class Started implements CompanyAiReportsEvent {
  const Started(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyAiReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartedCopyWith<Started> get copyWith => _$StartedCopyWithImpl<Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'CompanyAiReportsEvent.started(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $StartedCopyWith<$Res> implements $CompanyAiReportsEventCopyWith<$Res> {
  factory $StartedCopyWith(Started value, $Res Function(Started) _then) = _$StartedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$StartedCopyWithImpl<$Res>
    implements $StartedCopyWith<$Res> {
  _$StartedCopyWithImpl(this._self, this._then);

  final Started _self;
  final $Res Function(Started) _then;

/// Create a copy of CompanyAiReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(Started(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoadRequested implements CompanyAiReportsEvent {
  const LoadRequested(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyAiReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadRequestedCopyWith<LoadRequested> get copyWith => _$LoadRequestedCopyWithImpl<LoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadRequested&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'CompanyAiReportsEvent.loadRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $LoadRequestedCopyWith<$Res> implements $CompanyAiReportsEventCopyWith<$Res> {
  factory $LoadRequestedCopyWith(LoadRequested value, $Res Function(LoadRequested) _then) = _$LoadRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$LoadRequestedCopyWithImpl<$Res>
    implements $LoadRequestedCopyWith<$Res> {
  _$LoadRequestedCopyWithImpl(this._self, this._then);

  final LoadRequested _self;
  final $Res Function(LoadRequested) _then;

/// Create a copy of CompanyAiReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(LoadRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabShown implements CompanyAiReportsEvent {
  const TabShown(this.ticker);
  

 final  String ticker;

/// Create a copy of CompanyAiReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabShownCopyWith<TabShown> get copyWith => _$TabShownCopyWithImpl<TabShown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabShown&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'CompanyAiReportsEvent.tabShown(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $TabShownCopyWith<$Res> implements $CompanyAiReportsEventCopyWith<$Res> {
  factory $TabShownCopyWith(TabShown value, $Res Function(TabShown) _then) = _$TabShownCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$TabShownCopyWithImpl<$Res>
    implements $TabShownCopyWith<$Res> {
  _$TabShownCopyWithImpl(this._self, this._then);

  final TabShown _self;
  final $Res Function(TabShown) _then;

/// Create a copy of CompanyAiReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(TabShown(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TabHidden implements CompanyAiReportsEvent {
  const TabHidden();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabHidden);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsEvent.tabHidden()';
}


}




/// @nodoc


class AppBackgrounded implements CompanyAiReportsEvent {
  const AppBackgrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBackgrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsEvent.appBackgrounded()';
}


}




/// @nodoc


class AppForegrounded implements CompanyAiReportsEvent {
  const AppForegrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppForegrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsEvent.appForegrounded()';
}


}




/// @nodoc


class FormChanged implements CompanyAiReportsEvent {
  const FormChanged(this.form);
  

 final  AiReportForm form;

/// Create a copy of CompanyAiReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormChangedCopyWith<FormChanged> get copyWith => _$FormChangedCopyWithImpl<FormChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormChanged&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'CompanyAiReportsEvent.formChanged(form: $form)';
}


}

/// @nodoc
abstract mixin class $FormChangedCopyWith<$Res> implements $CompanyAiReportsEventCopyWith<$Res> {
  factory $FormChangedCopyWith(FormChanged value, $Res Function(FormChanged) _then) = _$FormChangedCopyWithImpl;
@useResult
$Res call({
 AiReportForm form
});




}
/// @nodoc
class _$FormChangedCopyWithImpl<$Res>
    implements $FormChangedCopyWith<$Res> {
  _$FormChangedCopyWithImpl(this._self, this._then);

  final FormChanged _self;
  final $Res Function(FormChanged) _then;

/// Create a copy of CompanyAiReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? form = null,}) {
  return _then(FormChanged(
null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as AiReportForm,
  ));
}


}

/// @nodoc


class ReportOpened implements CompanyAiReportsEvent {
  const ReportOpened();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportOpened);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsEvent.reportOpened()';
}


}




/// @nodoc


class FilingLinkOpened implements CompanyAiReportsEvent {
  const FilingLinkOpened();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilingLinkOpened);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsEvent.filingLinkOpened()';
}


}




/// @nodoc


class Reset implements CompanyAiReportsEvent {
  const Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyAiReportsEvent.reset()';
}


}




// dart format on
