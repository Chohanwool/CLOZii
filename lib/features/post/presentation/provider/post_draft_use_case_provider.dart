import 'package:clozii/features/post/domain/usecases/post_draft_use_case.dart';
import 'package:clozii/features/post/presentation/provider/post_draft_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDraftUseCaseProvider = Provider<PostDraftUseCase>((ref) {
  final repository = ref.read(postDraftRepositoryProvider);
  return PostDraftUseCase(repository);
});
