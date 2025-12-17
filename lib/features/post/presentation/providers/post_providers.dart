// riverpod
import 'package:clozii/features/post/data/repositories/firebase_post_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// provider
import 'package:clozii/features/auth/presentation/providers/auth_providers.dart';

// repositories
import 'package:clozii/features/post/domain/repositories/post_repository.dart';
import 'package:clozii/features/post/domain/repositories/post_draft_repository.dart';
import 'package:clozii/features/post/data/repositories/post_draft_repository_impl.dart';

// usecases
import 'package:clozii/features/post/domain/usecases/create_post.dart';
import 'package:clozii/features/post/domain/usecases/manage_draft.dart';
import 'package:clozii/features/post/domain/usecases/find_all_posts.dart';

part 'post_providers.g.dart';

/// post 도메인의 DI provider 모음
/// - PostRepository -> postRepositoryProvider (Firebase 저장소)
/// - PostDraftRepository -> postDraftRepositoryProvider
/// - CreatePost -> createPostProvider
/// - ManageDraft -> manageDraftProvider
/// - GetAllPosts -> getAllPostsProvider

// ============================================================================
// Repositories
// ============================================================================

@riverpod
PostRepository postRepository(Ref ref) {
  // return MemoryPostRepository();
  return FirebasePostRepository();
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
  final authRepository = ref.read(authRepositoryProvider);
  return CreatePost(postRepository, authRepository);
}

@riverpod
ManageDraft manageDraft(Ref ref) {
  final repository = ref.read(postDraftRepositoryProvider);
  return ManageDraft(repository);
}

@riverpod
FindAllPosts findAllPosts(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return FindAllPosts(repository);
}
