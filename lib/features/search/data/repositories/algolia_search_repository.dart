import 'package:algoliasearch/algoliasearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/data/models/post_model.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';

class AlgoliaSearchRepository extends SearchRepository {
  late final SearchClient _client;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AlgoliaSearchRepository() {
    _client = SearchClient(
      appId: AppConstants.algoliaApplicationId,
      apiKey: AppConstants.algoliaSearchApiKey,
    );
  }

  @override
  Future<List<Post>> searchPostsByQuery({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // 1. Algolia에서 검색하여 objectID 리스트 가져오기
      final request = SearchForHits(
        indexName: AppConstants.algoliaIndexName,
        query: query,
        hitsPerPage: limit,
        page: page - 1, // Algolia는 0-based indexing
      );

      final response = await _client.searchIndex(request: request);

      // 2. objectID 추출 (Hit 객체의 objectID 프로퍼티 사용)
      final postIds = response.hits
          .map((hit) => (hit as dynamic).objectID as String)
          .toList();

      // 3. Firestore에서 실제 게시글 데이터 가져오기
      return _fetchPostsByIds(postIds);
    } catch (e) {
      throw Exception('Algolia 검색 실패: $e');
    }
  }

  @override
  Future<List<Post>> searchPostsByCategory({
    required PostCategory category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaIndexName,
        filters: 'category:${category.name}',
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      final postIds = response.hits
          .map((hit) => (hit as dynamic).objectID as String)
          .toList();

      return _fetchPostsByIds(postIds);
    } catch (e) {
      throw Exception('카테고리 검색 실패: $e');
    }
  }

  @override
  Future<List<Post>> searchSharePosts({
    String? query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaIndexName,
        query: query ?? '',
        filters: 'tradeType:share',
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      final postIds = response.hits
          .map((hit) => (hit as dynamic).objectID as String)
          .toList();

      return _fetchPostsByIds(postIds);
    } catch (e) {
      throw Exception('나눔 게시글 검색 실패: $e');
    }
  }

  @override
  Future<List<Post>> searchPostsByPriceRange({
    String? query,
    required double minPrice,
    required double maxPrice,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaIndexName,
        query: query ?? '',
        filters: 'price:$minPrice TO $maxPrice',
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      final postIds = response.hits
          .map((hit) => (hit as dynamic).objectID as String)
          .toList();

      return _fetchPostsByIds(postIds);
    } catch (e) {
      throw Exception('가격 범위 검색 실패: $e');
    }
  }

  @override
  Future<List<Post>> searchNearByPosts({
    String? query,
    required double latitude,
    required double longitude,
    double radiusInKm = 1.0,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaIndexName,
        query: query ?? '',
        aroundLatLng: '$latitude,$longitude',
        aroundRadius: (radiusInKm * 1000).toInt(), // km를 m로 변환
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      final postIds = response.hits
          .map((hit) => (hit as dynamic).objectID as String)
          .toList();

      return _fetchPostsByIds(postIds);
    } catch (e) {
      throw Exception('내 근처 검색 실패: $e');
    }
  }

  /// Firestore에서 ID 리스트로 게시글 가져오기
  Future<List<Post>> _fetchPostsByIds(List<String> postIds) async {
    if (postIds.isEmpty) {
      return [];
    }

    try {
      // Firestore에서 각 ID로 게시글 가져오기
      final posts = <Post>[];
      for (final postId in postIds) {
        final docSnapshot =
            await _firestore.collection('posts').doc(postId).get();

        if (docSnapshot.exists && docSnapshot.data() != null) {
          final postModel = PostModel.fromJson(docSnapshot.data()!);
          posts.add(postModel.toEntity());
        }
      }

      return posts;
    } catch (e) {
      throw Exception('Firestore에서 게시글 가져오기 실패: $e');
    }
  }

  /// 리소스 정리
  void dispose() {
    _client.dispose();
  }
}
