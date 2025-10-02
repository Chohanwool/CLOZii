import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedImageProvider =
    NotifierProvider<SelectedImageNotifier, Map<String, Uint8List?>>(
      SelectedImageNotifier.new,
    );

// String : AssetEntity.id
// - 이 값으로 갤러리에 있는 원본 사진을 불러올 수 있지만, 사용자가 게시글 등록 후 사진을 삭제하면 다시 불러올 수 없음
// - 따라서, 게시글 등록 시 Firebase Storage에 Uint8List 형태로 업로드, Firestore 에는 Cloud Storage URL만 저장
// Uint8List? : 썸네일 데이터
class SelectedImageNotifier extends Notifier<Map<String, Uint8List?>> {
  static const int maxLength = 5;

  @override
  Map<String, Uint8List?> build() => {};

  void saveChanges(Map<String, Uint8List?> newState) {
    state = newState;
  }

  void undoChanges(Map<String, Uint8List?> previousState) {
    state = previousState;
  }

  Uint8List? getThumbnail(String id) {
    if (!state.containsKey(id)) return null;
    return state[id];
  }

  List<Uint8List?> getAllThumbnails() {
    return state.values.toList();
  }

  void removeImage(String id) {
    if (state.containsKey(id)) {
      // state = {...state}..remove(id);
      final newState = Map<String, Uint8List?>.from(state);
      newState.remove(id);
      state = newState;
    }
  }

  void clearSelection() {
    state = {};
  }
}
