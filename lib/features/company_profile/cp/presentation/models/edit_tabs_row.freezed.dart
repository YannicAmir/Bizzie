// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_tabs_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditTabsRow {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsRow);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsRow()';
}


}

/// @nodoc
class $EditTabsRowCopyWith<$Res>  {
$EditTabsRowCopyWith(EditTabsRow _, $Res Function(EditTabsRow) __);
}


/// Adds pattern-matching-related methods to [EditTabsRow].
extension EditTabsRowPatterns on EditTabsRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EditTabsSecurityRow value)?  security,TResult Function( EditTabsDividerRow value)?  divider,TResult Function( EditTabsTabRow value)?  tab,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EditTabsSecurityRow() when security != null:
return security(_that);case EditTabsDividerRow() when divider != null:
return divider(_that);case EditTabsTabRow() when tab != null:
return tab(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EditTabsSecurityRow value)  security,required TResult Function( EditTabsDividerRow value)  divider,required TResult Function( EditTabsTabRow value)  tab,}){
final _that = this;
switch (_that) {
case EditTabsSecurityRow():
return security(_that);case EditTabsDividerRow():
return divider(_that);case EditTabsTabRow():
return tab(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EditTabsSecurityRow value)?  security,TResult? Function( EditTabsDividerRow value)?  divider,TResult? Function( EditTabsTabRow value)?  tab,}){
final _that = this;
switch (_that) {
case EditTabsSecurityRow() when security != null:
return security(_that);case EditTabsDividerRow() when divider != null:
return divider(_that);case EditTabsTabRow() when tab != null:
return tab(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  security,TResult Function()?  divider,TResult Function( CompanyProfileTab tab,  bool isLocked)?  tab,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EditTabsSecurityRow() when security != null:
return security();case EditTabsDividerRow() when divider != null:
return divider();case EditTabsTabRow() when tab != null:
return tab(_that.tab,_that.isLocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  security,required TResult Function()  divider,required TResult Function( CompanyProfileTab tab,  bool isLocked)  tab,}) {final _that = this;
switch (_that) {
case EditTabsSecurityRow():
return security();case EditTabsDividerRow():
return divider();case EditTabsTabRow():
return tab(_that.tab,_that.isLocked);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  security,TResult? Function()?  divider,TResult? Function( CompanyProfileTab tab,  bool isLocked)?  tab,}) {final _that = this;
switch (_that) {
case EditTabsSecurityRow() when security != null:
return security();case EditTabsDividerRow() when divider != null:
return divider();case EditTabsTabRow() when tab != null:
return tab(_that.tab,_that.isLocked);case _:
  return null;

}
}

}

/// @nodoc


class EditTabsSecurityRow extends EditTabsRow {
  const EditTabsSecurityRow(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsSecurityRow);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsRow.security()';
}


}




/// @nodoc


class EditTabsDividerRow extends EditTabsRow {
  const EditTabsDividerRow(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsDividerRow);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditTabsRow.divider()';
}


}




/// @nodoc


class EditTabsTabRow extends EditTabsRow {
  const EditTabsTabRow({required this.tab, this.isLocked = false}): super._();
  

 final  CompanyProfileTab tab;
@JsonKey() final  bool isLocked;

/// Create a copy of EditTabsRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTabsTabRowCopyWith<EditTabsTabRow> get copyWith => _$EditTabsTabRowCopyWithImpl<EditTabsTabRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTabsTabRow&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked));
}


@override
int get hashCode => Object.hash(runtimeType,tab,isLocked);

@override
String toString() {
  return 'EditTabsRow.tab(tab: $tab, isLocked: $isLocked)';
}


}

/// @nodoc
abstract mixin class $EditTabsTabRowCopyWith<$Res> implements $EditTabsRowCopyWith<$Res> {
  factory $EditTabsTabRowCopyWith(EditTabsTabRow value, $Res Function(EditTabsTabRow) _then) = _$EditTabsTabRowCopyWithImpl;
@useResult
$Res call({
 CompanyProfileTab tab, bool isLocked
});




}
/// @nodoc
class _$EditTabsTabRowCopyWithImpl<$Res>
    implements $EditTabsTabRowCopyWith<$Res> {
  _$EditTabsTabRowCopyWithImpl(this._self, this._then);

  final EditTabsTabRow _self;
  final $Res Function(EditTabsTabRow) _then;

/// Create a copy of EditTabsRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tab = null,Object? isLocked = null,}) {
  return _then(EditTabsTabRow(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as CompanyProfileTab,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
