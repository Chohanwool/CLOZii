import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedImageIdsProvider =
    NotifierProvider<SelectedImageIdsNotifier, List<String>>(
      SelectedImageIdsNotifier.new,
    );

class SelectedImageIdsNotifier extends Notifier<List<String>> {
  static const int maxLength = 5;

  @override
  List<String> build() => [];

  bool isSelected(String id) => state.contains(id);

  void toggleSelection(String id) {
    if (state.contains(id)) {
      state = state.where((imageId) => imageId != id).toList();
    } else {
      if (state.length == maxLength) return;
      state = [...state, id];
    }
  }
}
