import 'dart:typed_data';

import 'package:clozii/features/post_old/data/image_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedImageProvider =
    NotifierProvider<SelectedImageNotifier, Map<String, ImageData>>(
      SelectedImageNotifier.new,
    );

// String : AssetEntity.id
// - 이 값으로 갤러리에 있는 원본 사진을 불러올 수 있지만, 사용자가 게시글 등록 후 사진을 삭제하면 다시 불러올 수 없음
// - 따라서, 게시글 등록 시 Firebase Storage에 Uint8List 형태로 업로드, Firestore 에는 Cloud Storage URL만 저장
// ImageData : 원본 사진 + 썸네일
class SelectedImageNotifier extends Notifier<Map<String, ImageData>> {
  static const int maxLength = 5;

  @override
  Map<String, ImageData> build() => {};

  void saveChanges(Map<String, ImageData> newState) {
    state = newState;
  }

  void undoChanges(Map<String, ImageData> previousState) {
    state = previousState;
  }

  Uint8List? getOrigin(String id) {
    if (!state.containsKey(id)) return null;
    return state[id]!.originBytes;
  }

  List<Uint8List?> getAllOrigins() {
    return state.values.map((imageData) => imageData.originBytes).toList();
  }

  Uint8List? getThumbnail(String id) {
    if (!state.containsKey(id)) return null;
    return state[id]!.thumbnailBytes;
  }

  List<Uint8List?> getAllThumbnails() {
    return state.values.map((imageData) => imageData.thumbnailBytes).toList();
  }

  void removeImage(String id) {
    if (state.containsKey(id)) {
      // state = {...state}..remove(id);
      final newState = Map<String, ImageData>.from(state);
      newState.remove(id);
      state = newState;
    }
  }

  void clearSelection() {
    state = {};
  }
}
