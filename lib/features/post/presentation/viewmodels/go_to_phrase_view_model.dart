// packages
import 'package:clozii/features/post/presentation/states/go_to_phrase_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 상태 = 자주 쓰는 문구 리스트

class GoToPhrasesNotifier extends Notifier<GoToPhraseState> {
  @override
  GoToPhraseState build() => const GoToPhraseState(goToPhrases: []);

  void addPhrase(String phrase) {
    state = state.copyWith(goToPhrases: [...state.goToPhrases, phrase]);
  }

  void editPhrase(String oldPhrase, String newPhrase) {
    final index = state.goToPhrases.indexOf(oldPhrase);
    if (index != -1) {
      final updated = [...state.goToPhrases];
      updated[index] = newPhrase;
      state = state.copyWith(goToPhrases: updated);
    }
  }

  void removePhrase(String phrase) {
    state = state.copyWith(
      goToPhrases: state.goToPhrases.where((ph) => ph != phrase).toList(),
    );
  }

  void setSelectedPhrase(String phrase) {
    state = state.copyWith(selectedPhrase: phrase);
  }

  void resetSelectedPhrase() {
    state = state.copyWith(selectedPhrase: null);
  }
}
