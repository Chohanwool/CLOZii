import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clozii/features/post/data/models/post_model.dart';
import 'package:clozii/features/post/domain/value_objects/image_urls.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';
import 'package:clozii/features/post/domain/value_objects/upload_result.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebasePostRepository extends PostRepository {
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

      // 조회
      final snapshot = await firestore.collection('posts').doc(post.id).get();

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
  Future<UploadResult> uploadImages(
    List<Uint8List?> originImages,
    List<Uint8List?> thumbnailImages,
  ) async {
    final firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;

    final docId = firestore.collection('posts').doc().id;
    final List<ImageUrls> uploadedImageUrls = [];

    for (int i = 0; i < originImages.length; i++) {
      final originData = originImages[i];
      final thumbnailData = thumbnailImages[i];

      // null 체크
      if (originData == null || thumbnailData == null) {
        throw Exception('이미지 데이터가 없습니다');
      }

      final originPath = 'posts/$docId/images/$i-origin.jpg';
      final thumbnailPath = 'posts/$docId/images/$i-thumbnail.jpg';

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

    return UploadResult(id: docId, imageUrls: uploadedImageUrls);
  }

  @override
  Future<void> deletePost(String postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> findAllPosts({int page = 1, int limit = 20}) {
    // TODO: implement findAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Post> findPostById(String postId) {
    // TODO: implement findPostById
    throw UnimplementedError();
  }

  @override
  Future<Post> updatePost(Post post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
