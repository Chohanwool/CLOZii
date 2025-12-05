import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/application/dummies/dummy_posts.dart';
import 'package:clozii/features/post/core/models/image_urls.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';

class MemoryPostRepository extends PostRepository {
  int id = 0;

  @override
  Future<Post> createPost(PostDraft postDraft) {
    final originImageUrls = postDraft.originImages
        .map(
          // 이미지 있으면 임시로 성공 이미지, 없으면 플레이스 홀더 표시
          (image) => image != null
              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2cFWmgmh-xRsLXiuWYedhR7Xtwrc1Hz11iGSd9W2GTOUoW1oY_UQvmZedKYBEMHzrX3U&usqp=CAU'
              : 'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
        )
        .toList();

    final thumbnailImageUrls = postDraft.thumbnailImages.isNotEmpty
        ? postDraft.thumbnailImages
            .map(
              // 이미지 있으면 임시로 성공 이미지, 없으면 플레이스 홀더 표시
              (image) => image != null
                  ? 'https://media.istockphoto.com/id/496603666/vector/flat-icon-check.jpg?s=612x612&w=0&k=20&c=BMYf-7moOtevP8t46IjHHbxJ4x4I0ZoFReIp9ApXBqU='
                  : 'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
            )
            .toList()
        : [
            'https://static.vecteezy.com/system/resources/thumbnails/022/059/000/small_2x/no-image-available-icon-vector.jpg',
          ];

    List<ImageUrls> urls = [];

    for (int i = 0; i < originImageUrls.length; i++) {
      urls.add(
        ImageUrls(
          originUrl: originImageUrls[i],
          thumbnailUrl: thumbnailImageUrls[i],
        ),
      );
    }

    // PostDraft의 toPost 메서드 사용
    final newPost = postDraft
        .toPost(
          id: 'postId_${id++}',
          now: DateTime.now(),
          authorUid: 'test_user_uid',
          authorNickname: 'Test User',
        )
        .copyWith(images: urls);

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
