import 'dart:typed_data';

import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/value_objects/image_urls.dart';

abstract class PostRepository {
  // 새 게시글 ID 생성
  String generatePostId();

  // 게시글 작성
  Future<Post> createPost(Post post);

  // 이미지 업로드
  Future<List<ImageUrls>> uploadImages({
    required String postId,
    required List<Uint8List?> originImages,
    required List<Uint8List?> thumbnailImages,
  });

  // 게시글 수정
  // UpdatePostUseCase에서 PostUpdate DTO 사용해서 부분 수정 처리 후 Post 엔티티로 변환하여 전달
  // updateTimestamp: false로 설정 시 updatedAt 필드를 갱신하지 않음 (게시글 생성 시 이미지 추가용)
  Future<Post> updatePost(Post post, {bool updateTimestamp = true});

  // 게시글 삭제
  Future<void> deletePost(String postId);

  // 게시글 조회
  Future<Post> findById(String postId);

  // 게시글 목록 조회 (페이징 처리 - 기본값: page=1, limit=20)
  Future<List<Post>> findAllPosts({int page = 1, int limit = 20});
}
