import 'dart:typed_data';

import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/application/dummies/dummy_posts.dart';
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/presentation/provider/create_post_use_case_provider.dart';
import 'package:clozii/features/post/presentation/states/image_state.dart';
import 'package:clozii/features/post/presentation/states/post_create_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostCreateViewModel extends Notifier<PostCreateState> {
  final formKey = GlobalKey<FormState>();

  @override
  PostCreateState build() {
    return const PostCreateState();
  }

  // 게시글 변경사항 유무 여부 체크
  bool get canSave {
    return state.title.trim().isNotEmpty ||
        state.content.trim().isNotEmpty ||
        state.selectedImages.isNotEmpty ||
        (state.tradeType == TradeType.sell && state.price > 0) ||
        (state.tradeType == TradeType.share && state.price == 0) ||
        state.meetingPoint != null ||
        state.detailAddress != null;
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

  // 상세 주소 저장
  void setDetailAddress(String detailAddress) {
    state = state.copyWith(detailAddress: detailAddress);
  }

  // 거래희망장소 좌표 저장
  void setMeetingPoint(LatLng meetingPoint) {
    state = state.copyWith(meetingPoint: meetingPoint);
  }

  // 선택된 이미지 저장
  void saveImages(Map<String, ImageState> images) {
    state = state.copyWith(selectedImages: images);
  }

  // 선택 취소 시 이전 상태로 복원
  void undoChanges(Map<String, ImageState> previousImages) {
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

  // 거래희망 장소명, 좌표 초기화
  void resetMeetingPoint() {
    state = state.copyWith(meetingPoint: null, detailAddress: null);
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
        meetingPoint: state.meetingPoint,
        detailAddress: state.detailAddress,
      ),
    );

    debugPrint(
      'Complete: ${state.title} | ${state.content} | ${state.tradeType} | ${state.price} | ${state.detailAddress} | ${state.meetingPoint} | ${state.selectedImages.length}',
    );

    debugPrint(dummyPosts.length.toString());

    state = state.copyWith(isAllValid: true);
  }

  void resetState() {
    state = const PostCreateState();
  }
}
