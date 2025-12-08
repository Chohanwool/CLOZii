import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clozii/features/post/domain/value_objects/image_urls.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';
import 'package:clozii/features/post/domain/value_objects/upload_result.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebasePostRepository extends PostRepository {
  @override
  Future<Post> createPost(Post post) {
    // TODO: implement deletePost
    throw UnimplementedError();
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

      await originRef.putData(originData);
      await thumbnailRef.putData(thumbnailData);

      // 다운로드 URL 가져오기
      final originUrl = await originRef.getDownloadURL();
      final thumbnailUrl = await thumbnailRef.getDownloadURL();

      uploadedImageUrls.add(
        ImageUrls(
          originUrl: originUrl,
          thumbnailUrl: thumbnailUrl,
        ),
      );
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
