import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/data/models/post_model.dart';
import 'package:clozii/features/post/domain/value_objects/image_urls.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebasePostRepository extends PostRepository {
  @override
  String generatePostId() {
    final firestore = FirebaseFirestore.instance;
    return firestore.collection('posts').doc().id;
  }

  @override
  Future<Post> createPost(Post post) async {
    final postModel = PostModel.fromEntity(post);
    final jsonPost = postModel.toJson();

    // 서버 타임스탬프 설정 - Firestore 서버가 저장 시점에 직접 시간을 채우게 하는 예약 값
    jsonPost['createdAt'] = FieldValue.serverTimestamp();
    jsonPost['updatedAt'] = FieldValue.serverTimestamp();

    final firestore = FirebaseFirestore.instance;

    try {
      // 저장
      await firestore.collection('posts').doc(post.id).set(jsonPost);

      // 조회 (서버에서 직접 가져와서 serverTimestamp가 적용된 데이터 확인)
      final snapshot = await firestore
          .collection('posts')
          .doc(post.id)
          .get(const GetOptions(source: Source.server));

      if (!snapshot.exists || snapshot.data() == null) {
        throw Exception('문서 없음 after save (id: ${post.id})');
      }

      return PostModel.fromJson(snapshot.data()!).toEntity();
    } on FirebaseException catch (e) {
      throw Exception('게시글 생성 실패(Firebase): ${e.message}');
    } catch (e) {
      throw Exception('게시글 생성 실패: $e');
    }
  }

  @override
  Future<Post> updatePost(Post post, {bool updateTimestamp = true}) async {
    final postModel = PostModel.fromEntity(post);
    final jsonPost = postModel.toJson();

    // createdAt은 항상 제거 (생성 이후 수정되지 않아야 함)
    jsonPost.remove('createdAt');

    // updateTimestamp가 true일 때만 updatedAt 갱신
    if (updateTimestamp) {
      jsonPost['updatedAt'] = FieldValue.serverTimestamp();
    } else {
      // updateTimestamp가 false일 때는 updatedAt도 제거 (기존 값 유지)
      jsonPost.remove('updatedAt');
    }

    final firestore = FirebaseFirestore.instance;

    try {
      // 업데이트 - update : 전달된 필드만 수정 (createdAt 이 포함되어 있으면 현재 값이 무엇이든 덮어씌워짐)
      await firestore.collection('posts').doc(post.id).update(jsonPost);

      // 조회 (서버에서 직접 가져와서 serverTimestamp가 적용된 데이터 확인)
      final snapshot = await firestore
          .collection('posts')
          .doc(post.id)
          .get(const GetOptions(source: Source.server));

      if (!snapshot.exists || snapshot.data() == null) {
        throw Exception('문서 없음 after update (id: ${post.id})');
      }

      return PostModel.fromJson(snapshot.data()!).toEntity();
    } on FirebaseException catch (e) {
      throw Exception('게시글 수정 실패(Firebase): ${e.message}');
    } catch (e) {
      throw Exception('게시글 수정 실패: $e');
    }
  }

  @override
  Future<List<ImageUrls>> uploadImages({
    required String postId,
    required List<Uint8List?> originImages,
    required List<Uint8List?> thumbnailImages,
  }) async {
    // final firestore = FirebaseFirestore.instance;
    // final postId = firestore.collection('posts').doc().id;

    final storage = FirebaseStorage.instance;
    final List<ImageUrls> uploadedImageUrls = [];

    for (int i = 0; i < originImages.length; i++) {
      final originData = originImages[i];
      final thumbnailData = thumbnailImages[i];

      // null 체크
      if (originData == null || thumbnailData == null) {
        throw Exception('이미지 데이터가 없습니다');
      }

      // 원본 이미지 경로
      final originPath = 'posts/$postId/original/$i.jpg';

      // 썸네일 이미지 경로
      final thumbnailPath = 'posts/$postId/thumbnail/$i.jpg';

      final originRef = storage.ref().child(originPath);
      final thumbnailRef = storage.ref().child(thumbnailPath);

      try {
        // 업로드
        await originRef.putData(originData);
        await thumbnailRef.putData(thumbnailData);

        // URL 가져오기
        final originUrl = await originRef.getDownloadURL();
        final thumbnailUrl = await thumbnailRef.getDownloadURL();

        uploadedImageUrls.add(
          ImageUrls(
            originUrl: originUrl,
            thumbnailUrl: thumbnailUrl,
          ),
        );
      } on FirebaseException catch (e) {
        throw Exception('[$i]번째 이미지 처리 실패: ${e.message}');
      }
    }

    return uploadedImageUrls;
  }

  @override
  Future<void> deletePost(String postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Post> findById(String postId) {
    // TODO: implement find ById
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> findAllPosts({int page = 1, int limit = 20}) async {
    final firestore = FirebaseFirestore.instance;

    try {
      // 최신순으로 정렬하여 조회
      final querySnapshot = await firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data()).toEntity())
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('게시글 목록 조회 실패(Firebase): ${e.message}');
    } catch (e) {
      throw Exception('게시글 목록 조회 실패: $e');
    }
  }

  @override
  Future<List<Post>> findByTitle(
    String title, {
    int page = 1,
    int limit = 20,
  }) {
    // TODO: implement findByTitle
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> findByCategory(
    PostCategory category, {
    int page = 1,
    int limit = 20,
  }) {
    // TODO: implement findByCategory
    throw UnimplementedError();
  }
}
