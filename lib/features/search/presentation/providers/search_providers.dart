import 'package:clozii/features/post/presentation/providers/post_providers.dart';
import 'package:clozii/features/search/data/repositories/algolia_search_repository.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';
import 'package:clozii/features/search/domain/usecases/load_posts_with_filter.dart';
import 'package:clozii/features/search/domain/usecases/search_posts_with_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_providers.g.dart';

// ============================================================================
// Repositories
// ============================================================================

@riverpod
SearchRepository searchRepository(Ref ref) {
  return AlgoliaSearchRepository();
}

// ============================================================================
// UseCases
// ============================================================================

// 검색 화면용 필터 기능
@riverpod
SearchPostsWithFilter searchPostsByFilter(Ref ref) {
  final repository = ref.read(searchRepositoryProvider);
  return SearchPostsWithFilter(repository);
}

// 홈화면용 필터 기능
@riverpod
LoadPostsWithFilter loadPostsByFilter(Ref ref) {
  final searchRepository = ref.read(searchRepositoryProvider);
  final postRepository = ref.read(postRepositoryProvider);
  return LoadPostsWithFilter(searchRepository, postRepository);
}
