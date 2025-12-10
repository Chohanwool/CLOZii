import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// core
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/domain/value_objects/meeting_location.dart';

// application
import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/application/dummies/dummy_posts.dart';

// presentation
import 'package:clozii/features/post/presentation/models/image_bytes.dart';

// providers
import 'package:clozii/features/post/presentation/providers/post_providers.dart';

// parts
part 'post_create_provider.freezed.dart';
part 'post_create_provider.g.dart';

// ============================================================================
// State
// ============================================================================

@freezed
sealed class PostCreateState with _$PostCreateState {
  const PostCreateState._();

  const factory PostCreateState({
    // 사용자 입력 데이터
    @Default('') String title,
    @Default('') String content,
    @Default(TradeType.sell) TradeType tradeType,
    @Default(0) int price,
    MeetingLocation? meetingLocation,
    @Default({}) Map<String, ImageBytes> selectedImages,
    // 모든 필드 입력에 대한 검증 성공 여부
    @Default(false) bool isAllValid,
    // 모달 상태
    @Default(false) bool showGoToPhrases,
    @Default(false) bool showAddPhraseModal,
    @Default(false) bool showMoreOptions,
    String? currentPhraseForEdit,
    // 임시저장 상태 (변경 감지용)
    PostCreateState? draftState,
  }) = _PostCreateState;

  // Computed properties
  static int get maxImageCount => 5;

  bool get isEmpty =>
      title.trim().isEmpty &&
      content.trim().isEmpty &&
      selectedImages.isEmpty &&
      (tradeType == TradeType.sell && price == 0) &&
      meetingLocation == null;
}

// ============================================================================
// Provider (ViewModel)
// ============================================================================

@Riverpod(keepAlive: true)
class PostCreate extends _$PostCreate {
  // FormKey를 ViewModel에서 직접 관리하는 것은 경미한 클린 아키텍처 위반 ⚠️
  // 원칙적으로 ViewModel은 UI 요소(FormKey 등)를 알아서는 안 됨 ❌
  // 하지만 "Form 검증"은 단순한 UI 로직이 아니라, 비즈니스 규칙에 가까움
  //  (예: 제목이 비어 있는지, 가격이 0 이상인지 등)
  // 따라서 전체 검증 로직을 ViewModel에 두는 편이 흐름이 명확하고 유지보수에도 유리함 ✅
  final formKey = GlobalKey<FormState>();

  @override
  PostCreateState build() {
    return const PostCreateState();
  }

  // 임시저장 데이터가 있을 경우, 상태 초기화
  void initState(PostCreateState draft) {
    state = draft;
  }

  // 게시글 변경사항 유무 여부 체크
  bool get hasChanges {
    return state.draftState == null
        ? !state.isEmpty
        : !_hasSameContentAs(state.draftState!);
  }

  // 임시저장 데이터와 현재 상태 비교
  bool _hasSameContentAs(PostCreateState other) {
    return state.title == other.title &&
        state.content == other.content &&
        state.price == other.price &&
        state.tradeType == other.tradeType &&
        _hasSameImageKeys(state.selectedImages, other.selectedImages) &&
        _hasSameMeetingLocation(state.meetingLocation, other.meetingLocation);
  }

  // 이미지 키 비교
  bool _hasSameImageKeys(Map<String, ImageBytes> a, Map<String, ImageBytes> b) {
    if (a.length != b.length) return false;
    return a.keys.every((key) => b.containsKey(key));
  }

  // 거래희망장소 비교
  bool _hasSameMeetingLocation(MeetingLocation? a, MeetingLocation? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    return a.latitude == b.latitude &&
        a.longitude == b.longitude &&
        a.detailAddress == b.detailAddress;
  }

  // 제목 저장 - 매 입력마다 호출됨
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  // 본문 저장 - 매 입력마다 호출됨
  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  // 거래 유형 저장
  void setTradeType(TradeType type) {
    state = state.copyWith(tradeType: type);
  }

  // 가격 저장 - 매 입력마다 호출됨
  void setPrice(int price) {
    state = state.copyWith(price: price);
  }

  // 거래희망장소 저장
  void setMeetingLocation(String detailAddress, LatLng coordinate) {
    state = state.copyWith(
      meetingLocation: MeetingLocation(
        latitude: coordinate.latitude,
        longitude: coordinate.longitude,
        detailAddress: detailAddress,
      ),
    );
  }

  // 선택된 이미지 저장
  void saveImages(Map<String, ImageBytes> images) {
    state = state.copyWith(selectedImages: images);
  }

  // 특정 원본 이미지 가져오기
  Uint8List? getOrigin(String id) {
    if (state.selectedImages.containsKey(id)) {
      return state.selectedImages[id]!.originBytes;
    }
    return null;
  }

  // 모든 원본 이미지 가져오기
  List<Uint8List?> getAllOrigins() {
    return state.selectedImages.values
        .map((imageBytes) => imageBytes.originBytes)
        .toList();
  }

  // 특정 썸네일 이미지 가져오기
  Uint8List? getThumbnail(String id) {
    if (state.selectedImages.containsKey(id)) {
      return state.selectedImages[id]!.thumbnailBytes;
    }
    return null;
  }

  // 모든 썸네일 이미지 가져오기
  List<Uint8List?> getAllThumbnails() {
    return state.selectedImages.values
        .map((imageBytes) => imageBytes.thumbnailBytes)
        .toList();
  }

  // 이미지 삭제
  void removeImage(String id) {
    if (state.selectedImages.containsKey(id)) {
      final newImages = {...state.selectedImages}..remove(id);
      state = state.copyWith(selectedImages: newImages);
    }
  }

  /// 모달 트리거 함수

  // 자주 쓰는 문구 모달 - 열기
  void showGoToPhrases() {
    state = state.copyWith(showGoToPhrases: true);
  }

  // 자주 쓰는 문구 모달 - 닫기
  void hideGoToPhrases() {
    state = state.copyWith(showGoToPhrases: false);
  }

  // 자주 쓰는 문구 추가 모달 - 열기
  // currentPhrase : 더보기 -> 수정 클릭 시, 수정할 문구
  void showAddPhraseModal(String? currentPhrase) {
    state = state.copyWith(
      showAddPhraseModal: true,
      currentPhraseForEdit: currentPhrase, // null이면 명시적으로 null로 설정됨
    );
  }

  // 자주 쓰는 문구 추가 모달 - 닫기
  void hideAddPhraseModal() {
    state = state.copyWith(
      showAddPhraseModal: false,
      currentPhraseForEdit: null,
    );
  }

  // (GoToPhraseModal) 더보기 모달 - 열기
  // currentPhrase : 수정 또는 삭제할 문구
  void showMoreOptions(String currentPhrase) {
    state = state.copyWith(
      showMoreOptions: true,
      currentPhraseForEdit: currentPhrase,
    );
  }

  // (GoToPhraseModal) 더보기 모달 - 닫기
  void hideMoreOptions() {
    state = state.copyWith(showMoreOptions: false, currentPhraseForEdit: null);
  }

  /// 임시저장 관련 메서드

  // 임시저장
  Future<void> saveTemp() async {
    final manageDraft = ref.read(manageDraftProvider);
    await manageDraft.save(state);

    // draftState를 현재 state로 업데이트하여 리빌드 트리거
    state = state.copyWith(draftState: state);

    debugPrint('임시저장 완료');
  }

  // 임시저장 불러오기
  Future<PostCreateState?> loadTemp() async {
    final manageDraft = ref.read(manageDraftProvider);
    final draft = await manageDraft.load();

    if (draft != null) {
      state = draft.copyWith(draftState: draft);
      debugPrint('임시저장 데이터 있음');

      return draft;
    } else {
      debugPrint('임시저장된 데이터 없음');

      return null;
    }
  }

  // 임시저장 삭제
  Future<void> deleteTemp() async {
    final manageDraft = ref.read(manageDraftProvider);
    await manageDraft.delete();

    state = state.copyWith(draftState: null);
    debugPrint('임시저장 삭제 완료');
  }

  // 게시글 생성 전 검증 로직 및 게시글 생성 유즈 케이스 호출
  Future<void> checkAllFieldsValid() async {
    final isFormValid = formKey.currentState!.validate();

    if (!isFormValid) return;

    // CreatePost 호출
    final createPost = ref.read(createPostProvider);
    createPost(
      PostDraft(
        title: state.title,
        content: state.content,
        originImages: getAllOrigins(),
        thumbnailImages: getAllThumbnails(),
        price: state.price,
        tradeType: state.tradeType,
        meetingLocation: state.meetingLocation,
      ),
    );

    debugPrint(
      'Complete: ${state.title} | ${state.content} | ${state.tradeType} | ${state.price} | ${state.meetingLocation?.latitude},${state.meetingLocation?.longitude} | ${state.meetingLocation?.detailAddress} | ${state.selectedImages.length}',
    );

    // debugPrint(dummyPosts.length.toString());

    // 게시글 생성 완료 후 임시저장 삭제
    await deleteTemp();

    state = state.copyWith(isAllValid: true);
  }

  void resetState() {
    debugPrint('상태 초기화');
    state = const PostCreateState();
  }
}
