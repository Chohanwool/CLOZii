import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/domain/entities/post.dart';

abstract class PostRepository {
  // 게시글 작성
  Future<Post> createPost(PostDraft postDraft);

  // 게시글 수정
  // UpdatePostUseCase에서 PostUpdate DTO 사용해서 부분 수정 처리 후 Post 엔티티로 변환하여 전달
  Future<Post> updatePost(Post post);

  // 게시글 삭제
  Future<void> deletePost(String postId);

  // 게시글 조회
  Future<Post> findPostById(String postId);

  // 게시글 목록 조회 (페이징 처리 - 기본값: page=1, limit=20)
  Future<List<Post>> findAllPosts({int page = 1, int limit = 20});
}
