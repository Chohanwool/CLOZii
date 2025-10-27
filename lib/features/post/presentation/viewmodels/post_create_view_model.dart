import 'dart:typed_data';

import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/application/dummies/dummy_posts.dart';
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/core/models/meeting_location.dart';
import 'package:clozii/features/post/presentation/provider/create_post_use_case_provider.dart';
import 'package:clozii/features/post/presentation/provider/post_draft_use_case_provider.dart';
import 'package:clozii/features/post/core/models/image_data.dart';
import 'package:clozii/features/post/presentation/states/post_create_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostCreateViewModel extends Notifier<PostCreateState> {
  final formKey = GlobalKey<FormState>();
  PostCreateState? draftState;

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
    return draftState != null
        ? !_hasSameContentAs(draftState!)
        : isStateNotEmpty;
  }

  bool get isStateNotEmpty =>
      state.title.trim().isNotEmpty ||
      state.content.trim().isNotEmpty ||
      state.selectedImages.isNotEmpty ||
      (state.tradeType == TradeType.sell && state.price > 0) ||
      (state.tradeType == TradeType.share && state.price == 0) ||
      state.meetingLocation != null;

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
  bool _hasSameImageKeys(Map<String, ImageData> a, Map<String, ImageData> b) {
    if (a.length != b.length) return false;
    return a.keys.every((key) => b.containsKey(key));
  }

  // 거래희망장소 비교
  bool _hasSameMeetingLocation(MeetingLocation? a, MeetingLocation? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    return a.coordinate == b.coordinate && a.detailAddress == b.detailAddress;
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
        coordinate: coordinate,
        detailAddress: detailAddress,
      ),
    );
  }

  // 선택된 이미지 저장
  void saveImages(Map<String, ImageData> images) {
    state = state.copyWith(selectedImages: images);
  }

  // 선택 취소 시 이전 상태로 복원
  void undoChanges(Map<String, ImageData> previousImages) {
    state = state.copyWith(selectedImages: previousImages);
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
        .map((imageData) => imageData.originBytes)
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
        .map((imageData) => imageData.thumbnailBytes)
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
    draftState = state;
    state = state.copyWith(); // ← 리빌드 트리거

    final postDraftUseCase = ref.read(postDraftUseCaseProvider);
    await postDraftUseCase.save(state);

    debugPrint('임시저장 완료');
  }

  // 임시저장 불러오기
  Future<PostCreateState?> loadTemp() async {
    final postDraftUseCase = ref.read(postDraftUseCaseProvider);
    final draft = await postDraftUseCase.load();

    if (draft != null) {
      draftState = draft;
      state = draft;
      debugPrint('임시저장 데이터 있음');

      return draft;
    } else {
      debugPrint('임시저장된 데이터 없음');

      return null;
    }
  }

  // 임시저장 삭제
  Future<void> deleteTemp() async {
    draftState = null;

    final postDraftUseCase = ref.read(postDraftUseCaseProvider);
    await postDraftUseCase.delete();
    debugPrint('임시저장 삭제 완료');
  }

  // 게시글 생성 전 검증 로직 및 게시글 생성 유즈 케이스 호출
  Future<void> checkAllFieldsValid() async {
    final isFormValid = formKey.currentState!.validate();

    if (!isFormValid) return;

    // CreatePostUseCase 호출
    final createPostUseCase = ref.read(createPostUseCaseProvider);
    createPostUseCase(
      PostDraft(
        title: state.title,
        content: state.content,
        originImages: getAllOrigins(),
        thumbnailImages: getAllThumbnails(),
        price: state.price,
        tradeType: state.tradeType,
        meetingPoint: state.meetingLocation?.coordinate,
        detailAddress: state.meetingLocation?.detailAddress,
      ),
    );

    debugPrint(
      'Complete: ${state.title} | ${state.content} | ${state.tradeType} | ${state.price} | ${state.meetingLocation?.coordinate} | ${state.meetingLocation?.detailAddress} | ${state.selectedImages.length}',
    );

    debugPrint(dummyPosts.length.toString());

    // 게시글 생성 완료 후 임시저장 삭제
    await deleteTemp();

    state = state.copyWith(isAllValid: true);
  }

  void resetState() {
    debugPrint('상태 초기화');
    state = const PostCreateState();
  }
}
