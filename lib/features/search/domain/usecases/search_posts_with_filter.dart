import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';
import 'package:geolocator/geolocator.dart';

class SearchPostsWithFilter {
  final SearchRepository repository;

  const SearchPostsWithFilter(this.repository);

  Future<List<Post>> call({
    required String query,
    required PostFilter filter,
    Position? userPosition,
    int page = 1,
    int limit = 20,
  }) async {
    switch (filter) {
      case PostFilter.all:
        return repository.searchPostsByQuery(
          query: query,
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
        throw UnimplementedError('$filter is not implemented yet');
      case PostFilter.nearby:
        if (userPosition != null) {
          return repository.searchNearByPosts(
            query: query,
            latitude: userPosition.latitude,
            longitude: userPosition.longitude,
            page: page,
            limit: limit,
          );
        } else {
          throw Exception('User position is required for nearby post search');
        }
      case PostFilter.category:
        throw UnimplementedError('$filter is not implemented yet');
    }
  }
}
