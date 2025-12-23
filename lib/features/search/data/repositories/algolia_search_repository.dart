import 'package:algoliasearch/algoliasearch.dart';
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/application/dto/post_summary.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';

class AlgoliaSearchRepository extends SearchRepository {
  late final SearchClient _client;

  AlgoliaSearchRepository() {
    _client = SearchClient(
      appId: AppConstants.algoliaApplicationId,
      apiKey: AppConstants.algoliaSearchApiKey,
    );
  }

  @override
  Future<List<PostSummary>> searchPostsByQuery({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaPostIndex,
        query: query,
        hitsPerPage: limit,
        page: page - 1, // Algolia는 0-based indexing
      );

      final response = await _client.searchIndex(request: request);

      return response.hits.map(_mapHitToPostSummary).toList();
    } catch (e) {
      throw Exception('Algolia 검색 실패: $e');
    }
  }

  @override
  Future<List<PostSummary>> searchPostsByCategory({
    required PostCategory category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaPostIndex,
        filters: 'category:${category.name}',
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      return response.hits.map(_mapHitToPostSummary).toList();
    } catch (e) {
      throw Exception('카테고리 검색 실패: $e');
    }
  }

  @override
  Future<List<PostSummary>> searchSharePosts({
    String? query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaPostIndex,
        query: query ?? '',
        filters: 'tradeType:share',
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      return response.hits.map(_mapHitToPostSummary).toList();
    } catch (e) {
      throw Exception('나눔 게시글 검색 실패: $e');
    }
  }

  @override
  Future<List<PostSummary>> searchPostsByPriceRange({
    String? query,
    required double minPrice,
    required double maxPrice,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaPostIndex,
        query: query ?? '',
        filters: 'price:$minPrice TO $maxPrice',
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      return response.hits.map(_mapHitToPostSummary).toList();
    } catch (e) {
      throw Exception('가격 범위 검색 실패: $e');
    }
  }

  @override
  Future<List<PostSummary>> searchPostsByPriceAsc({
    String? query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaPostAscIndex,
        query: query ?? '',
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      return response.hits.map(_mapHitToPostSummary).toList();
    } catch (e) {
      throw Exception('가격 오름차순 검색 실패: $e');
    }
  }

  @override
  Future<List<PostSummary>> searchPostsByPriceDesc({
    String? query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaPostDescIndex,
        query: query ?? '',
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      return response.hits.map(_mapHitToPostSummary).toList();
    } catch (e) {
      throw Exception('가격 내림차순 검색 실패: $e');
    }
  }

  @override
  Future<List<PostSummary>> searchNearByPosts({
    String? query,
    required double latitude,
    required double longitude,
    double radiusInKm = 1.0,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final request = SearchForHits(
        indexName: AppConstants.algoliaPostIndex,
        query: query ?? '',
        aroundLatLng: '$latitude,$longitude',
        aroundRadius: (radiusInKm * 1000).toInt(), // km를 m로 변환
        hitsPerPage: limit,
        page: page - 1,
      );

      final response = await _client.searchIndex(request: request);

      return response.hits.map(_mapHitToPostSummary).toList();
    } catch (e) {
      throw Exception('내 근처 검색 실패: $e');
    }
  }

  PostSummary _mapHitToPostSummary(dynamic hit) {
    final hitMap = _hitToMap(hit);
    final objectId = _readObjectId(hit, hitMap);
    final title = hitMap['title'] as String? ?? '';
    final price = _readInt(hitMap['price']);
    final createdAt = _parseDateTime(hitMap['createdAt']);
    final thumbnailUrl = _readThumbnailUrl(hitMap['thumbnailImageUrls']);

    return PostSummary(
      id: objectId,
      title: title,
      price: price,
      createdAt: createdAt,
      thumbnailUrl: thumbnailUrl,
    );
  }

  Map<String, dynamic> _hitToMap(dynamic hit) {
    if (hit is Map<String, dynamic>) {
      return hit;
    }
    if (hit is Map) {
      return Map<String, dynamic>.from(hit);
    }
    try {
      final json = (hit as dynamic).toJson();
      if (json is Map) {
        return Map<String, dynamic>.from(json);
      }
    } catch (_) {}
    return <String, dynamic>{};
  }

  String _readObjectId(dynamic hit, Map<String, dynamic> hitMap) {
    final objectId = hitMap['objectID'];
    if (objectId is String && objectId.isNotEmpty) {
      return objectId;
    }
    final fallbackId = hitMap['id'];
    if (fallbackId is String && fallbackId.isNotEmpty) {
      return fallbackId;
    }
    try {
      final value = (hit as dynamic).objectID;
      if (value is String && value.isNotEmpty) {
        return value;
      }
    } catch (_) {}
    return '';
  }

  int _readInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.round();
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  String? _readThumbnailUrl(dynamic thumbnails) {
    if (thumbnails is List && thumbnails.isNotEmpty) {
      final first = thumbnails.first;
      if (first is String && first.isNotEmpty) {
        return first;
      }

      for (int i = 1; i < thumbnails.length; i++) {
        final url = thumbnails[i];
        if (url is String && url.isNotEmpty) {
          return url;
        }
      }
    }
    return null;
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value is DateTime) {
      return value;
    }
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is double) {
      return DateTime.fromMillisecondsSinceEpoch(value.round());
    }
    if (value is String) {
      return DateTime.tryParse(value);
    }
    if (value is Map) {
      final seconds = value['_seconds'] ?? value['seconds'];
      if (seconds is int) {
        return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
      }
      if (seconds is double) {
        return DateTime.fromMillisecondsSinceEpoch(seconds.round() * 1000);
      }
    }
    return null;
  }

  /// 리소스 정리
  void dispose() {
    _client.dispose();
  }
}
