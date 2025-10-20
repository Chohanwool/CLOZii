import 'dart:typed_data';

import 'package:clozii/features/post/core/enums/trade_type.dart';
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

  // 거래희망장소 좌표 저장
  void setMeetingPoint(LatLng meetingPoint) {
    state = state.copyWith(meetingPoint: meetingPoint);
  }

  // 거래 유형 저장
  void setTradeType(TradeType type) {
    state = state.copyWith(tradeType: type);
  }

  // 상세 주소 저장
  void setDetailAddress(String detailAddress) {
    state = state.copyWith(detailAddress: detailAddress);
  }

  // 모달 관련 메서드들
  void showGoToPhrases() {
    state = state.copyWith(showGoToPhrases: true);
  }

  void hideGoToPhrases() {
    state = state.copyWith(showGoToPhrases: false);
  }

  void showAddPhraseModal(String? currentPhrase) {
    state = state.copyWith(
      showAddPhraseModal: true,
      currentPhraseForEdit: currentPhrase, // null이면 명시적으로 null로 설정됨
    );
  }

  void hideAddPhraseModal() {
    state = state.copyWith(
      showAddPhraseModal: false,
      currentPhraseForEdit: null,
    );
  }

  void showMoreOptions(String currentPhrase) {
    state = state.copyWith(
      showMoreOptions: true,
      currentPhraseForEdit: currentPhrase,
    );
  }

  void hideMoreOptions() {
    state = state.copyWith(showMoreOptions: false, currentPhraseForEdit: null);
  }
}
