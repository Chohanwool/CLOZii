import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// parts
part 'go_to_phrase_provider.freezed.dart';
part 'go_to_phrase_provider.g.dart';

// ============================================================================
// State
// ============================================================================

@freezed
sealed class GoToPhraseState with _$GoToPhraseState {
  const GoToPhraseState._();

  const factory GoToPhraseState({
    @Default([]) List<String> goToPhrases,
    String? selectedPhrase,
  }) = _GoToPhraseState;
}

// ============================================================================
// Provider (ViewModel)
// ============================================================================

@riverpod
class GoToPhrases extends _$GoToPhrases {
  @override
  GoToPhraseState build() {
    return const GoToPhraseState();
  }

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
