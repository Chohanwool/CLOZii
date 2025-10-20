class GoToPhraseState {
  final List<String> goToPhrases;
  final String? selectedPhrase;

  const GoToPhraseState({required this.goToPhrases, this.selectedPhrase});

  GoToPhraseState copyWith({
    List<String>? goToPhrases,
    String? selectedPhrase,
  }) {
    return GoToPhraseState(
      goToPhrases: goToPhrases ?? this.goToPhrases,
      selectedPhrase: selectedPhrase,
    );
  }
}
