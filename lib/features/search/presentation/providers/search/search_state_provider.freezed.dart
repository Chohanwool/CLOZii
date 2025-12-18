// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchState {
  String get searchQuery; // 휘발성: Provider만 관리
  List<String> get recentSearches; // 영구: Provider + 로컬 저장소
  bool get hasSubmitted; // 검색 제출 여부
  PostFilter get selectedFilter;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchStateCopyWith<SearchState> get copyWith =>
      _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchState &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality()
                .equals(other.recentSearches, recentSearches) &&
            (identical(other.hasSubmitted, hasSubmitted) ||
                other.hasSubmitted == hasSubmitted) &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchQuery,
      const DeepCollectionEquality().hash(recentSearches),
      hasSubmitted,
      selectedFilter);

  @override
  String toString() {
    return 'SearchState(searchQuery: $searchQuery, recentSearches: $recentSearches, hasSubmitted: $hasSubmitted, selectedFilter: $selectedFilter)';
  }
}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) _then) =
      _$SearchStateCopyWithImpl;
  @useResult
  $Res call(
      {String searchQuery,
      List<String> recentSearches,
      bool hasSubmitted,
      PostFilter selectedFilter});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res> implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? recentSearches = null,
    Object? hasSubmitted = null,
    Object? selectedFilter = null,
  }) {
    return _then(_self.copyWith(
      searchQuery: null == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      recentSearches: null == recentSearches
          ? _self.recentSearches
          : recentSearches // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasSubmitted: null == hasSubmitted
          ? _self.hasSubmitted
          : hasSubmitted // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedFilter: null == selectedFilter
          ? _self.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as PostFilter,
    ));
  }
}

/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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
    TResult Function(_SearchState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
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
    TResult Function(_SearchState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState():
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
    TResult? Function(_SearchState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
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
    TResult Function(String searchQuery, List<String> recentSearches,
            bool hasSubmitted, PostFilter selectedFilter)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
        return $default(_that.searchQuery, _that.recentSearches,
            _that.hasSubmitted, _that.selectedFilter);
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
    TResult Function(String searchQuery, List<String> recentSearches,
            bool hasSubmitted, PostFilter selectedFilter)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState():
        return $default(_that.searchQuery, _that.recentSearches,
            _that.hasSubmitted, _that.selectedFilter);
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
    TResult? Function(String searchQuery, List<String> recentSearches,
            bool hasSubmitted, PostFilter selectedFilter)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
        return $default(_that.searchQuery, _that.recentSearches,
            _that.hasSubmitted, _that.selectedFilter);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SearchState extends SearchState {
  const _SearchState(
      {this.searchQuery = '',
      final List<String> recentSearches = const [],
      this.hasSubmitted = false,
      this.selectedFilter = PostFilter.all})
      : _recentSearches = recentSearches,
        super._();

  @override
  @JsonKey()
  final String searchQuery;
// 휘발성: Provider만 관리
  final List<String> _recentSearches;
// 휘발성: Provider만 관리
  @override
  @JsonKey()
  List<String> get recentSearches {
    if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentSearches);
  }

// 영구: Provider + 로컬 저장소
  @override
  @JsonKey()
  final bool hasSubmitted;
// 검색 제출 여부
  @override
  @JsonKey()
  final PostFilter selectedFilter;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchStateCopyWith<_SearchState> get copyWith =>
      __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchState &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality()
                .equals(other._recentSearches, _recentSearches) &&
            (identical(other.hasSubmitted, hasSubmitted) ||
                other.hasSubmitted == hasSubmitted) &&
            (identical(other.selectedFilter, selectedFilter) ||
                other.selectedFilter == selectedFilter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      searchQuery,
      const DeepCollectionEquality().hash(_recentSearches),
      hasSubmitted,
      selectedFilter);

  @override
  String toString() {
    return 'SearchState(searchQuery: $searchQuery, recentSearches: $recentSearches, hasSubmitted: $hasSubmitted, selectedFilter: $selectedFilter)';
  }
}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(
          _SearchState value, $Res Function(_SearchState) _then) =
      __$SearchStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String searchQuery,
      List<String> recentSearches,
      bool hasSubmitted,
      PostFilter selectedFilter});
}

/// @nodoc
class __$SearchStateCopyWithImpl<$Res> implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? searchQuery = null,
    Object? recentSearches = null,
    Object? hasSubmitted = null,
    Object? selectedFilter = null,
  }) {
    return _then(_SearchState(
      searchQuery: null == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      recentSearches: null == recentSearches
          ? _self._recentSearches
          : recentSearches // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasSubmitted: null == hasSubmitted
          ? _self.hasSubmitted
          : hasSubmitted // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedFilter: null == selectedFilter
          ? _self.selectedFilter
          : selectedFilter // ignore: cast_nullable_to_non_nullable
              as PostFilter,
    ));
  }
}

// dart format on
