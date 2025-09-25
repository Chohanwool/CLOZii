// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 상태 = 자주 쓰는 문구 리스트
final goToPhrasesProvider = NotifierProvider<GoToPhrasesNotifier, List<String>>(
  GoToPhrasesNotifier.new,
);

class GoToPhrasesNotifier extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void addPhrase(String phrase) {
    state = [...state, phrase];
  }

  void editPhrase(String oldPhrase, String newPhrase) {
    final index = state.indexOf(oldPhrase);
    if (index != -1) {
      final updated = [...state];
      updated[index] = newPhrase;
      state = updated;
    }
  }

  void removePhrase(String phrase) {
    state = state.where((p) => p != phrase).toList();
  }

  void setInitial(List<String> phrases) {
    state = phrases;
  }
}
