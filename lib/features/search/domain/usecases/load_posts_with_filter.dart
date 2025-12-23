import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';
import 'package:geolocator/geolocator.dart';

class LoadPostsWithFilter {
  final SearchRepository searchRepository;
  final PostRepository postRepository;

  const LoadPostsWithFilter(this.searchRepository, this.postRepository);

  Future<List<Post>> call({
    required PostFilter filter,
    PostCategory? selectedCategory,
    Position? userPosition,
    int page = 1,
    int limit = 20,
  }) async {
    switch (filter) {
      case PostFilter.all:
        return postRepository.findAllPosts();
      case PostFilter.category:
        if (selectedCategory == null) {
          throw Exception('Category is required to category post search');
        }

        return searchRepository.searchPostsByCategory(
          category: selectedCategory,
        );
      case PostFilter.shares:
        return searchRepository.searchSharePosts(
          page: page,
          limit: limit,
        );
      case PostFilter.nearby:
        if (userPosition != null) {
          return searchRepository.searchNearByPosts(
            latitude: userPosition.latitude,
            longitude: userPosition.longitude,
            page: page,
            limit: limit,
          );
        } else {
          throw Exception('User position is required for nearby post search');
        }

      // 홈화면에 없는 필터
      case PostFilter.priceAsc:
        throw UnimplementedError('This filter is not available in HomeScreen');
      case PostFilter.priceDesc:
        throw UnimplementedError('This filter is not available in HomeScreen');
    }
  }
}
