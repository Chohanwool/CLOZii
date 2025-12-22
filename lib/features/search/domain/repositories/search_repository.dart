import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/domain/entities/post.dart';

abstract class SearchRepository {
  // 검색어로 게시글 검색
  Future<List<Post>> searchPostsByQuery({
    required String query,
    int page = 1,
    int limit = 20,
  });

  // 카테고리로 게시글 검색
  Future<List<Post>> searchPostsByCategory({
    required PostCategory category,
    int page = 1,
    int limit = 20,
  });

  // 나눔 게시글 검색
  Future<List<Post>> searchSharePosts({
    String? query,
    int page = 1,
    int limit = 20,
  });

  // 가격으로 게시글 검색
  Future<List<Post>> searchPostsByPriceRange({
    String? query,
    required double minPrice,
    required double maxPrice,
    int page = 1,
    int limit = 20,
  });

  Future<List<Post>> searchPostsByPriceAsc({
    String? query,
    int page = 1,
    int limit = 20,
  });

  Future<List<Post>> searchPostsByPriceDesc({
    String? query,
    int page = 1,
    int limit = 20,
  });

  // 내 위치에서 가까운 게시글 검색
  Future<List<Post>> searchNearByPosts({
    String? query,
    required double latitude,
    required double longitude,
    double radiusInKm = 1.0,
    int page = 1,
    int limit = 20,
  });
}
