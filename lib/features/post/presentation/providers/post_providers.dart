import 'package:clozii/features/post/domain/usecases/manage_draft.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// repositories
import 'package:clozii/features/post/domain/repositories/post_repository.dart';
import 'package:clozii/features/post/data/repositories/memory_post_repository.dart';
import 'package:clozii/features/post/domain/repositories/post_draft_repository.dart';
import 'package:clozii/features/post/data/repositories/post_draft_repository_impl.dart';

// usecases
import 'package:clozii/features/post/domain/usecases/create_post.dart';

part 'post_providers.g.dart';

/// post 도메인의 DI provider 모음
/// - PostRepository -> postRepositoryProvider (메모리 저장소)
/// - PostDraftRepository -> postDraftRepositoryProvider
/// - CreatePost -> createPostProvider
/// - ManageDraft -> manageDraftProvider

// ============================================================================
// Repositories
// ============================================================================

@riverpod
PostRepository postRepository(Ref ref) {
  return MemoryPostRepository();
}

@riverpod
PostDraftRepository postDraftRepository(Ref ref) {
  return PostDraftRepositoryImpl();
}

// ============================================================================
// UseCases
// ============================================================================

@riverpod
CreatePost createPost(Ref ref) {
  final postRepository = ref.read(postRepositoryProvider);
  return CreatePost(postRepository);
}

@riverpod
ManageDraft manageDraft(Ref ref) {
  final repository = ref.read(postDraftRepositoryProvider);
  return ManageDraft(repository);
}
