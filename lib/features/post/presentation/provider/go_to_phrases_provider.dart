import 'package:clozii/features/post/presentation/states/go_to_phrase_state.dart';
import 'package:clozii/features/post/presentation/viewmodels/go_to_phrase_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goToPhrasesProvider =
    NotifierProvider<GoToPhrasesNotifier, GoToPhraseState>(
      GoToPhrasesNotifier.new,
    );
