// features
import 'package:clozii/features/post/presentation/viewmodels/go_to_phrases_view_model.dart';

// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 상태 = 자주 쓰는 문구 리스트
final goToPhrasesProvider =
    NotifierProvider<GoToPhrasesViewModel, List<String>>(
      GoToPhrasesViewModel.new,
    );
