// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'go_to_phrase_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoToPhraseState {

 List<String> get goToPhrases; String? get selectedPhrase;
/// Create a copy of GoToPhraseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoToPhraseStateCopyWith<GoToPhraseState> get copyWith => _$GoToPhraseStateCopyWithImpl<GoToPhraseState>(this as GoToPhraseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoToPhraseState&&const DeepCollectionEquality().equals(other.goToPhrases, goToPhrases)&&(identical(other.selectedPhrase, selectedPhrase) || other.selectedPhrase == selectedPhrase));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(goToPhrases),selectedPhrase);

@override
String toString() {
  return 'GoToPhraseState(goToPhrases: $goToPhrases, selectedPhrase: $selectedPhrase)';
}


}

/// @nodoc
abstract mixin class $GoToPhraseStateCopyWith<$Res>  {
  factory $GoToPhraseStateCopyWith(GoToPhraseState value, $Res Function(GoToPhraseState) _then) = _$GoToPhraseStateCopyWithImpl;
@useResult
$Res call({
 List<String> goToPhrases, String? selectedPhrase
});




}
/// @nodoc
class _$GoToPhraseStateCopyWithImpl<$Res>
    implements $GoToPhraseStateCopyWith<$Res> {
  _$GoToPhraseStateCopyWithImpl(this._self, this._then);

  final GoToPhraseState _self;
  final $Res Function(GoToPhraseState) _then;

/// Create a copy of GoToPhraseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? goToPhrases = null,Object? selectedPhrase = freezed,}) {
  return _then(_self.copyWith(
goToPhrases: null == goToPhrases ? _self.goToPhrases : goToPhrases // ignore: cast_nullable_to_non_nullable
as List<String>,selectedPhrase: freezed == selectedPhrase ? _self.selectedPhrase : selectedPhrase // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GoToPhraseState].
extension GoToPhraseStatePatterns on GoToPhraseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoToPhraseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoToPhraseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoToPhraseState value)  $default,){
final _that = this;
switch (_that) {
case _GoToPhraseState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoToPhraseState value)?  $default,){
final _that = this;
switch (_that) {
case _GoToPhraseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> goToPhrases,  String? selectedPhrase)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoToPhraseState() when $default != null:
return $default(_that.goToPhrases,_that.selectedPhrase);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> goToPhrases,  String? selectedPhrase)  $default,) {final _that = this;
switch (_that) {
case _GoToPhraseState():
return $default(_that.goToPhrases,_that.selectedPhrase);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> goToPhrases,  String? selectedPhrase)?  $default,) {final _that = this;
switch (_that) {
case _GoToPhraseState() when $default != null:
return $default(_that.goToPhrases,_that.selectedPhrase);case _:
  return null;

}
}

}

/// @nodoc


class _GoToPhraseState extends GoToPhraseState {
  const _GoToPhraseState({final  List<String> goToPhrases = const [], this.selectedPhrase}): _goToPhrases = goToPhrases,super._();
  

 final  List<String> _goToPhrases;
@override@JsonKey() List<String> get goToPhrases {
  if (_goToPhrases is EqualUnmodifiableListView) return _goToPhrases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goToPhrases);
}

@override final  String? selectedPhrase;

/// Create a copy of GoToPhraseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoToPhraseStateCopyWith<_GoToPhraseState> get copyWith => __$GoToPhraseStateCopyWithImpl<_GoToPhraseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoToPhraseState&&const DeepCollectionEquality().equals(other._goToPhrases, _goToPhrases)&&(identical(other.selectedPhrase, selectedPhrase) || other.selectedPhrase == selectedPhrase));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_goToPhrases),selectedPhrase);

@override
String toString() {
  return 'GoToPhraseState(goToPhrases: $goToPhrases, selectedPhrase: $selectedPhrase)';
}


}

/// @nodoc
abstract mixin class _$GoToPhraseStateCopyWith<$Res> implements $GoToPhraseStateCopyWith<$Res> {
  factory _$GoToPhraseStateCopyWith(_GoToPhraseState value, $Res Function(_GoToPhraseState) _then) = __$GoToPhraseStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> goToPhrases, String? selectedPhrase
});




}
/// @nodoc
class __$GoToPhraseStateCopyWithImpl<$Res>
    implements _$GoToPhraseStateCopyWith<$Res> {
  __$GoToPhraseStateCopyWithImpl(this._self, this._then);

  final _GoToPhraseState _self;
  final $Res Function(_GoToPhraseState) _then;

/// Create a copy of GoToPhraseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goToPhrases = null,Object? selectedPhrase = freezed,}) {
  return _then(_GoToPhraseState(
goToPhrases: null == goToPhrases ? _self._goToPhrases : goToPhrases // ignore: cast_nullable_to_non_nullable
as List<String>,selectedPhrase: freezed == selectedPhrase ? _self.selectedPhrase : selectedPhrase // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
