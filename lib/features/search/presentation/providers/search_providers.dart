import 'package:clozii/features/search/data/repositories/algolia_search_repository.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';
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

@riverpod
SearchPostsWithFilter searchPostsByFilter(Ref ref) {
  final repository = ref.read(searchRepositoryProvider);
  return SearchPostsWithFilter(repository);
}
