// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_detail_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostDetailState {
  bool get isExpanded;
  double get stretchOffset;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostDetailStateCopyWith<PostDetailState> get copyWith =>
      _$PostDetailStateCopyWithImpl<PostDetailState>(
          this as PostDetailState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostDetailState &&
            (identical(other.isExpanded, isExpanded) ||
                other.isExpanded == isExpanded) &&
            (identical(other.stretchOffset, stretchOffset) ||
                other.stretchOffset == stretchOffset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isExpanded, stretchOffset);

  @override
  String toString() {
    return 'PostDetailState(isExpanded: $isExpanded, stretchOffset: $stretchOffset)';
  }
}

/// @nodoc
abstract mixin class $PostDetailStateCopyWith<$Res> {
  factory $PostDetailStateCopyWith(
          PostDetailState value, $Res Function(PostDetailState) _then) =
      _$PostDetailStateCopyWithImpl;
  @useResult
  $Res call({bool isExpanded, double stretchOffset});
}

/// @nodoc
class _$PostDetailStateCopyWithImpl<$Res>
    implements $PostDetailStateCopyWith<$Res> {
  _$PostDetailStateCopyWithImpl(this._self, this._then);

  final PostDetailState _self;
  final $Res Function(PostDetailState) _then;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isExpanded = null,
    Object? stretchOffset = null,
  }) {
    return _then(_self.copyWith(
      isExpanded: null == isExpanded
          ? _self.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      stretchOffset: null == stretchOffset
          ? _self.stretchOffset
          : stretchOffset // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [PostDetailState].
extension PostDetailStatePatterns on PostDetailState {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PostDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostDetailState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PostDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostDetailState():
        return $default(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PostDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostDetailState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool isExpanded, double stretchOffset)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostDetailState() when $default != null:
        return $default(_that.isExpanded, _that.stretchOffset);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(bool isExpanded, double stretchOffset) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostDetailState():
        return $default(_that.isExpanded, _that.stretchOffset);
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(bool isExpanded, double stretchOffset)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostDetailState() when $default != null:
        return $default(_that.isExpanded, _that.stretchOffset);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PostDetailState extends PostDetailState {
  const _PostDetailState({this.isExpanded = true, this.stretchOffset = 0.0})
      : super._();

  @override
  @JsonKey()
  final bool isExpanded;
  @override
  @JsonKey()
  final double stretchOffset;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostDetailStateCopyWith<_PostDetailState> get copyWith =>
      __$PostDetailStateCopyWithImpl<_PostDetailState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostDetailState &&
            (identical(other.isExpanded, isExpanded) ||
                other.isExpanded == isExpanded) &&
            (identical(other.stretchOffset, stretchOffset) ||
                other.stretchOffset == stretchOffset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isExpanded, stretchOffset);

  @override
  String toString() {
    return 'PostDetailState(isExpanded: $isExpanded, stretchOffset: $stretchOffset)';
  }
}

/// @nodoc
abstract mixin class _$PostDetailStateCopyWith<$Res>
    implements $PostDetailStateCopyWith<$Res> {
  factory _$PostDetailStateCopyWith(
          _PostDetailState value, $Res Function(_PostDetailState) _then) =
      __$PostDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isExpanded, double stretchOffset});
}

/// @nodoc
class __$PostDetailStateCopyWithImpl<$Res>
    implements _$PostDetailStateCopyWith<$Res> {
  __$PostDetailStateCopyWithImpl(this._self, this._then);

  final _PostDetailState _self;
  final $Res Function(_PostDetailState) _then;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isExpanded = null,
    Object? stretchOffset = null,
  }) {
    return _then(_PostDetailState(
      isExpanded: null == isExpanded
          ? _self.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      stretchOffset: null == stretchOffset
          ? _self.stretchOffset
          : stretchOffset // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
