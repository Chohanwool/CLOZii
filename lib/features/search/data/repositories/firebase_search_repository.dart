import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/data/models/post_model.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';

class FirebaseSearchRepository extends SearchRepository {
  @override
  Future<List<Post>> searchPostsByQuery(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore
          .collection('posts')
          .where('title', isEqualTo: query)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((snapshot) => PostModel.fromJson(snapshot.data()).toEntity())
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('게시글 검색 실패(Firebase): ${e.message}');
    } catch (e) {
      throw Exception('게시글 검색 실패: $e');
    }
  }

  @override
  Future<List<Post>> searchPostsByCategory(PostCategory category,
      {int page = 1, int limit = 20}) {
    // TODO: implement searchPostsByCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> searchSharePosts({int page = 1, int limit = 20}) {
    // TODO: implement searchSharePosts
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> searchPostsByPriceRange(double minPrice, double maxPrice,
      {int page = 1, int limit = 20}) {
    // TODO: implement searchPostsByPriceRange
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> searchNearByPosts(double latitude, double longitude,
      {double radiusInKm = 1.0, int page = 1, int limit = 20}) {
    // TODO: implement searchNearByPosts
    throw UnimplementedError();
  }
}
