// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_create_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostCreateState {
// 사용자 입력 데이터
  String get title;
  String get content;
  TradeType get tradeType;
  int get price;
  MeetingLocation? get meetingLocation;
  Map<String, ImageBytes> get selectedImages; // 모든 필드 입력에 대한 검증 성공 여부
  bool get isAllValid; // 모달 상태
  bool get showGoToPhrases;
  bool get showAddPhraseModal;
  bool get showMoreOptions;
  String? get currentPhraseForEdit; // 임시저장 상태 (변경 감지용)
  PostCreateState? get draftState;

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostCreateStateCopyWith<PostCreateState> get copyWith =>
      _$PostCreateStateCopyWithImpl<PostCreateState>(
          this as PostCreateState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostCreateState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.tradeType, tradeType) ||
                other.tradeType == tradeType) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.meetingLocation, meetingLocation) ||
                other.meetingLocation == meetingLocation) &&
            const DeepCollectionEquality()
                .equals(other.selectedImages, selectedImages) &&
            (identical(other.isAllValid, isAllValid) ||
                other.isAllValid == isAllValid) &&
            (identical(other.showGoToPhrases, showGoToPhrases) ||
                other.showGoToPhrases == showGoToPhrases) &&
            (identical(other.showAddPhraseModal, showAddPhraseModal) ||
                other.showAddPhraseModal == showAddPhraseModal) &&
            (identical(other.showMoreOptions, showMoreOptions) ||
                other.showMoreOptions == showMoreOptions) &&
            (identical(other.currentPhraseForEdit, currentPhraseForEdit) ||
                other.currentPhraseForEdit == currentPhraseForEdit) &&
            (identical(other.draftState, draftState) ||
                other.draftState == draftState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      content,
      tradeType,
      price,
      meetingLocation,
      const DeepCollectionEquality().hash(selectedImages),
      isAllValid,
      showGoToPhrases,
      showAddPhraseModal,
      showMoreOptions,
      currentPhraseForEdit,
      draftState);

  @override
  String toString() {
    return 'PostCreateState(title: $title, content: $content, tradeType: $tradeType, price: $price, meetingLocation: $meetingLocation, selectedImages: $selectedImages, isAllValid: $isAllValid, showGoToPhrases: $showGoToPhrases, showAddPhraseModal: $showAddPhraseModal, showMoreOptions: $showMoreOptions, currentPhraseForEdit: $currentPhraseForEdit, draftState: $draftState)';
  }
}

/// @nodoc
abstract mixin class $PostCreateStateCopyWith<$Res> {
  factory $PostCreateStateCopyWith(
          PostCreateState value, $Res Function(PostCreateState) _then) =
      _$PostCreateStateCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      String content,
      TradeType tradeType,
      int price,
      MeetingLocation? meetingLocation,
      Map<String, ImageBytes> selectedImages,
      bool isAllValid,
      bool showGoToPhrases,
      bool showAddPhraseModal,
      bool showMoreOptions,
      String? currentPhraseForEdit,
      PostCreateState? draftState});

  $PostCreateStateCopyWith<$Res>? get draftState;
}

/// @nodoc
class _$PostCreateStateCopyWithImpl<$Res>
    implements $PostCreateStateCopyWith<$Res> {
  _$PostCreateStateCopyWithImpl(this._self, this._then);

  final PostCreateState _self;
  final $Res Function(PostCreateState) _then;

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? tradeType = null,
    Object? price = null,
    Object? meetingLocation = freezed,
    Object? selectedImages = null,
    Object? isAllValid = null,
    Object? showGoToPhrases = null,
    Object? showAddPhraseModal = null,
    Object? showMoreOptions = null,
    Object? currentPhraseForEdit = freezed,
    Object? draftState = freezed,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      tradeType: null == tradeType
          ? _self.tradeType
          : tradeType // ignore: cast_nullable_to_non_nullable
              as TradeType,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      meetingLocation: freezed == meetingLocation
          ? _self.meetingLocation
          : meetingLocation // ignore: cast_nullable_to_non_nullable
              as MeetingLocation?,
      selectedImages: null == selectedImages
          ? _self.selectedImages
          : selectedImages // ignore: cast_nullable_to_non_nullable
              as Map<String, ImageBytes>,
      isAllValid: null == isAllValid
          ? _self.isAllValid
          : isAllValid // ignore: cast_nullable_to_non_nullable
              as bool,
      showGoToPhrases: null == showGoToPhrases
          ? _self.showGoToPhrases
          : showGoToPhrases // ignore: cast_nullable_to_non_nullable
              as bool,
      showAddPhraseModal: null == showAddPhraseModal
          ? _self.showAddPhraseModal
          : showAddPhraseModal // ignore: cast_nullable_to_non_nullable
              as bool,
      showMoreOptions: null == showMoreOptions
          ? _self.showMoreOptions
          : showMoreOptions // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPhraseForEdit: freezed == currentPhraseForEdit
          ? _self.currentPhraseForEdit
          : currentPhraseForEdit // ignore: cast_nullable_to_non_nullable
              as String?,
      draftState: freezed == draftState
          ? _self.draftState
          : draftState // ignore: cast_nullable_to_non_nullable
              as PostCreateState?,
    ));
  }

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCreateStateCopyWith<$Res>? get draftState {
    if (_self.draftState == null) {
      return null;
    }

    return $PostCreateStateCopyWith<$Res>(_self.draftState!, (value) {
      return _then(_self.copyWith(draftState: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PostCreateState].
extension PostCreateStatePatterns on PostCreateState {
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
    TResult Function(_PostCreateState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostCreateState() when $default != null:
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
    TResult Function(_PostCreateState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostCreateState():
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
    TResult? Function(_PostCreateState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostCreateState() when $default != null:
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
    TResult Function(
            String title,
            String content,
            TradeType tradeType,
            int price,
            MeetingLocation? meetingLocation,
            Map<String, ImageBytes> selectedImages,
            bool isAllValid,
            bool showGoToPhrases,
            bool showAddPhraseModal,
            bool showMoreOptions,
            String? currentPhraseForEdit,
            PostCreateState? draftState)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostCreateState() when $default != null:
        return $default(
            _that.title,
            _that.content,
            _that.tradeType,
            _that.price,
            _that.meetingLocation,
            _that.selectedImages,
            _that.isAllValid,
            _that.showGoToPhrases,
            _that.showAddPhraseModal,
            _that.showMoreOptions,
            _that.currentPhraseForEdit,
            _that.draftState);
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
    TResult Function(
            String title,
            String content,
            TradeType tradeType,
            int price,
            MeetingLocation? meetingLocation,
            Map<String, ImageBytes> selectedImages,
            bool isAllValid,
            bool showGoToPhrases,
            bool showAddPhraseModal,
            bool showMoreOptions,
            String? currentPhraseForEdit,
            PostCreateState? draftState)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostCreateState():
        return $default(
            _that.title,
            _that.content,
            _that.tradeType,
            _that.price,
            _that.meetingLocation,
            _that.selectedImages,
            _that.isAllValid,
            _that.showGoToPhrases,
            _that.showAddPhraseModal,
            _that.showMoreOptions,
            _that.currentPhraseForEdit,
            _that.draftState);
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
    TResult? Function(
            String title,
            String content,
            TradeType tradeType,
            int price,
            MeetingLocation? meetingLocation,
            Map<String, ImageBytes> selectedImages,
            bool isAllValid,
            bool showGoToPhrases,
            bool showAddPhraseModal,
            bool showMoreOptions,
            String? currentPhraseForEdit,
            PostCreateState? draftState)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostCreateState() when $default != null:
        return $default(
            _that.title,
            _that.content,
            _that.tradeType,
            _that.price,
            _that.meetingLocation,
            _that.selectedImages,
            _that.isAllValid,
            _that.showGoToPhrases,
            _that.showAddPhraseModal,
            _that.showMoreOptions,
            _that.currentPhraseForEdit,
            _that.draftState);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PostCreateState extends PostCreateState {
  const _PostCreateState(
      {this.title = '',
      this.content = '',
      this.tradeType = TradeType.sell,
      this.price = 0,
      this.meetingLocation,
      final Map<String, ImageBytes> selectedImages = const {},
      this.isAllValid = false,
      this.showGoToPhrases = false,
      this.showAddPhraseModal = false,
      this.showMoreOptions = false,
      this.currentPhraseForEdit,
      this.draftState})
      : _selectedImages = selectedImages,
        super._();

// 사용자 입력 데이터
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey()
  final TradeType tradeType;
  @override
  @JsonKey()
  final int price;
  @override
  final MeetingLocation? meetingLocation;
  final Map<String, ImageBytes> _selectedImages;
  @override
  @JsonKey()
  Map<String, ImageBytes> get selectedImages {
    if (_selectedImages is EqualUnmodifiableMapView) return _selectedImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedImages);
  }

// 모든 필드 입력에 대한 검증 성공 여부
  @override
  @JsonKey()
  final bool isAllValid;
// 모달 상태
  @override
  @JsonKey()
  final bool showGoToPhrases;
  @override
  @JsonKey()
  final bool showAddPhraseModal;
  @override
  @JsonKey()
  final bool showMoreOptions;
  @override
  final String? currentPhraseForEdit;
// 임시저장 상태 (변경 감지용)
  @override
  final PostCreateState? draftState;

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostCreateStateCopyWith<_PostCreateState> get copyWith =>
      __$PostCreateStateCopyWithImpl<_PostCreateState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostCreateState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.tradeType, tradeType) ||
                other.tradeType == tradeType) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.meetingLocation, meetingLocation) ||
                other.meetingLocation == meetingLocation) &&
            const DeepCollectionEquality()
                .equals(other._selectedImages, _selectedImages) &&
            (identical(other.isAllValid, isAllValid) ||
                other.isAllValid == isAllValid) &&
            (identical(other.showGoToPhrases, showGoToPhrases) ||
                other.showGoToPhrases == showGoToPhrases) &&
            (identical(other.showAddPhraseModal, showAddPhraseModal) ||
                other.showAddPhraseModal == showAddPhraseModal) &&
            (identical(other.showMoreOptions, showMoreOptions) ||
                other.showMoreOptions == showMoreOptions) &&
            (identical(other.currentPhraseForEdit, currentPhraseForEdit) ||
                other.currentPhraseForEdit == currentPhraseForEdit) &&
            (identical(other.draftState, draftState) ||
                other.draftState == draftState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      content,
      tradeType,
      price,
      meetingLocation,
      const DeepCollectionEquality().hash(_selectedImages),
      isAllValid,
      showGoToPhrases,
      showAddPhraseModal,
      showMoreOptions,
      currentPhraseForEdit,
      draftState);

  @override
  String toString() {
    return 'PostCreateState(title: $title, content: $content, tradeType: $tradeType, price: $price, meetingLocation: $meetingLocation, selectedImages: $selectedImages, isAllValid: $isAllValid, showGoToPhrases: $showGoToPhrases, showAddPhraseModal: $showAddPhraseModal, showMoreOptions: $showMoreOptions, currentPhraseForEdit: $currentPhraseForEdit, draftState: $draftState)';
  }
}

/// @nodoc
abstract mixin class _$PostCreateStateCopyWith<$Res>
    implements $PostCreateStateCopyWith<$Res> {
  factory _$PostCreateStateCopyWith(
          _PostCreateState value, $Res Function(_PostCreateState) _then) =
      __$PostCreateStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String title,
      String content,
      TradeType tradeType,
      int price,
      MeetingLocation? meetingLocation,
      Map<String, ImageBytes> selectedImages,
      bool isAllValid,
      bool showGoToPhrases,
      bool showAddPhraseModal,
      bool showMoreOptions,
      String? currentPhraseForEdit,
      PostCreateState? draftState});

  @override
  $PostCreateStateCopyWith<$Res>? get draftState;
}

/// @nodoc
class __$PostCreateStateCopyWithImpl<$Res>
    implements _$PostCreateStateCopyWith<$Res> {
  __$PostCreateStateCopyWithImpl(this._self, this._then);

  final _PostCreateState _self;
  final $Res Function(_PostCreateState) _then;

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? tradeType = null,
    Object? price = null,
    Object? meetingLocation = freezed,
    Object? selectedImages = null,
    Object? isAllValid = null,
    Object? showGoToPhrases = null,
    Object? showAddPhraseModal = null,
    Object? showMoreOptions = null,
    Object? currentPhraseForEdit = freezed,
    Object? draftState = freezed,
  }) {
    return _then(_PostCreateState(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      tradeType: null == tradeType
          ? _self.tradeType
          : tradeType // ignore: cast_nullable_to_non_nullable
              as TradeType,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      meetingLocation: freezed == meetingLocation
          ? _self.meetingLocation
          : meetingLocation // ignore: cast_nullable_to_non_nullable
              as MeetingLocation?,
      selectedImages: null == selectedImages
          ? _self._selectedImages
          : selectedImages // ignore: cast_nullable_to_non_nullable
              as Map<String, ImageBytes>,
      isAllValid: null == isAllValid
          ? _self.isAllValid
          : isAllValid // ignore: cast_nullable_to_non_nullable
              as bool,
      showGoToPhrases: null == showGoToPhrases
          ? _self.showGoToPhrases
          : showGoToPhrases // ignore: cast_nullable_to_non_nullable
              as bool,
      showAddPhraseModal: null == showAddPhraseModal
          ? _self.showAddPhraseModal
          : showAddPhraseModal // ignore: cast_nullable_to_non_nullable
              as bool,
      showMoreOptions: null == showMoreOptions
          ? _self.showMoreOptions
          : showMoreOptions // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPhraseForEdit: freezed == currentPhraseForEdit
          ? _self.currentPhraseForEdit
          : currentPhraseForEdit // ignore: cast_nullable_to_non_nullable
              as String?,
      draftState: freezed == draftState
          ? _self.draftState
          : draftState // ignore: cast_nullable_to_non_nullable
              as PostCreateState?,
    ));
  }

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCreateStateCopyWith<$Res>? get draftState {
    if (_self.draftState == null) {
      return null;
    }

    return $PostCreateStateCopyWith<$Res>(_self.draftState!, (value) {
      return _then(_self.copyWith(draftState: value));
    });
  }
}

// dart format on
