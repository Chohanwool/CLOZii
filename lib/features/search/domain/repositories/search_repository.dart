import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/application/dto/post_summary.dart';

abstract class SearchRepository {
  // 검색어로 게시글 검색
  Future<List<PostSummary>> searchPostsByQuery({
    required String query,
    int page = 1,
    int limit = 20,
  });

  // 카테고리로 게시글 검색
  Future<List<PostSummary>> searchPostsByCategory({
    required PostCategory category,
    int page = 1,
    int limit = 20,
  });

  // 나눔 게시글 검색
  Future<List<PostSummary>> searchSharePosts({
    String? query,
    int page = 1,
    int limit = 20,
  });

  // 가격으로 게시글 검색
  Future<List<PostSummary>> searchPostsByPriceRange({
    String? query,
    required double minPrice,
    required double maxPrice,
    int page = 1,
    int limit = 20,
  });

  Future<List<PostSummary>> searchPostsByPriceAsc({
    String? query,
    int page = 1,
    int limit = 20,
  });

  Future<List<PostSummary>> searchPostsByPriceDesc({
    String? query,
    int page = 1,
    int limit = 20,
  });

  // 내 위치에서 가까운 게시글 검색
  Future<List<PostSummary>> searchNearByPosts({
    String? query,
    required double latitude,
    required double longitude,
    double radiusInKm = 1.0,
    int page = 1,
    int limit = 20,
  });
}
