import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/application/dummies/dummy_posts.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';

class MemoryPostRepository extends PostRepository {
  int id = 0;

  @override
  Future<Post> createPost(PostDraft postDraft) {
    // PostDraft의 toPost 메서드 사용
    final newPost = postDraft.toPost(
      id: 'postId_${id++}',
      now: DateTime.now(),
      authorUid: 'test_user_uid',
      authorNickname: 'Test User',
    );

    dummyPosts.add(newPost);

    return Future.value(newPost);
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
