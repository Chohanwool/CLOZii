import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';

class SearchPostsWithFilter {
  final SearchRepository repository;

  const SearchPostsWithFilter(this.repository);

  Future<List<Post>> call({
    required String query,
    required PostFilter filter,
    int page = 1,
    int limit = 20,
  }) async {
    switch (filter) {
      case PostFilter.all:
        return repository.searchPostsByQuery(
          query,
          page: page,
          limit: limit,
        );
      case PostFilter.shares:
        return repository.searchSharePosts(
          query: query,
          page: page,
          limit: limit,
        );
      case PostFilter.price:
      case PostFilter.nearby:
      case PostFilter.category:
        throw UnimplementedError('$filter is not implemented yet');
    }
  }
}
