// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_list_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostListState {
  PostFilter get selectedFilter;
  String get selectedRegion;
  bool get isDropdownOpen;

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostListStateCopyWith<PostListState> get copyWith =>
      _$PostListStateCopyWithImpl<PostListState>(
          this as PostListState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostListState &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter) &&
            (identical(other.selectedRegion, selectedRegion) ||
                other.selectedRegion == selectedRegion) &&
            (identical(other.isDropdownOpen, isDropdownOpen) ||
                other.isDropdownOpen == isDropdownOpen));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedFilter, selectedRegion, isDropdownOpen);

  @override
  String toString() {
    return 'PostListState(selectedFilter: $selectedFilter, selectedRegion: $selectedRegion, isDropdownOpen: $isDropdownOpen)';
  }
}

/// @nodoc
abstract mixin class $PostListStateCopyWith<$Res> {
  factory $PostListStateCopyWith(
          PostListState value, $Res Function(PostListState) _then) =
      _$PostListStateCopyWithImpl;
  @useResult
  $Res call(
      {PostFilter selectedFilter, String selectedRegion, bool isDropdownOpen});
}

/// @nodoc
class _$PostListStateCopyWithImpl<$Res>
    implements $PostListStateCopyWith<$Res> {
  _$PostListStateCopyWithImpl(this._self, this._then);

  final PostListState _self;
  final $Res Function(PostListState) _then;

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedFilter = null,
    Object? selectedRegion = null,
    Object? isDropdownOpen = null,
  }) {
    return _then(_self.copyWith(
      selectedFilter: null == selectedFilter
          ? _self.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as PostFilter,
      selectedRegion: null == selectedRegion
          ? _self.selectedRegion
          : selectedRegion // ignore: cast_nullable_to_non_nullable
              as String,
      isDropdownOpen: null == isDropdownOpen
          ? _self.isDropdownOpen
          : isDropdownOpen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [PostListState].
extension PostListStatePatterns on PostListState {
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
    TResult Function(_PostListState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostListState() when $default != null:
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
    TResult Function(_PostListState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostListState():
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
    TResult? Function(_PostListState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostListState() when $default != null:
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
    TResult Function(PostFilter selectedFilter, String selectedRegion,
            bool isDropdownOpen)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostListState() when $default != null:
        return $default(
            _that.selectedFilter, _that.selectedRegion, _that.isDropdownOpen);
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
    TResult Function(PostFilter selectedFilter, String selectedRegion,
            bool isDropdownOpen)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostListState():
        return $default(
            _that.selectedFilter, _that.selectedRegion, _that.isDropdownOpen);
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
    TResult? Function(PostFilter selectedFilter, String selectedRegion,
            bool isDropdownOpen)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostListState() when $default != null:
        return $default(
            _that.selectedFilter, _that.selectedRegion, _that.isDropdownOpen);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PostListState extends PostListState {
  const _PostListState(
      {this.selectedFilter = PostFilter.all,
      this.selectedRegion = 'Sta.Rosa',
      this.isDropdownOpen = false})
      : super._();

  @override
  @JsonKey()
  final PostFilter selectedFilter;
  @override
  @JsonKey()
  final String selectedRegion;
  @override
  @JsonKey()
  final bool isDropdownOpen;

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostListStateCopyWith<_PostListState> get copyWith =>
      __$PostListStateCopyWithImpl<_PostListState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostListState &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter) &&
            (identical(other.selectedRegion, selectedRegion) ||
                other.selectedRegion == selectedRegion) &&
            (identical(other.isDropdownOpen, isDropdownOpen) ||
                other.isDropdownOpen == isDropdownOpen));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedFilter, selectedRegion, isDropdownOpen);

  @override
  String toString() {
    return 'PostListState(selectedFilter: $selectedFilter, selectedRegion: $selectedRegion, isDropdownOpen: $isDropdownOpen)';
  }
}

/// @nodoc
abstract mixin class _$PostListStateCopyWith<$Res>
    implements $PostListStateCopyWith<$Res> {
  factory _$PostListStateCopyWith(
          _PostListState value, $Res Function(_PostListState) _then) =
      __$PostListStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {PostFilter selectedFilter, String selectedRegion, bool isDropdownOpen});
}

/// @nodoc
class __$PostListStateCopyWithImpl<$Res>
    implements _$PostListStateCopyWith<$Res> {
  __$PostListStateCopyWithImpl(this._self, this._then);

  final _PostListState _self;
  final $Res Function(_PostListState) _then;

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedFilter = null,
    Object? selectedRegion = null,
    Object? isDropdownOpen = null,
  }) {
    return _then(_PostListState(
      selectedFilter: null == selectedFilter
          ? _self.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as PostFilter,
      selectedRegion: null == selectedRegion
          ? _self.selectedRegion
          : selectedRegion // ignore: cast_nullable_to_non_nullable
              as String,
      isDropdownOpen: null == isDropdownOpen
          ? _self.isDropdownOpen
          : isDropdownOpen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
