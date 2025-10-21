import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/application/dummies/dummy_posts.dart';
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

    double? meetingPointLat;
    double? meetingPointLong;

    if (postDraft.meetingPoint != null) {
      meetingPointLat = postDraft.meetingPoint!.latitude;
      meetingPointLong = postDraft.meetingPoint!.longitude;
    }

    final newPost = Post(
      id: 'postId_${id++}',
      title: postDraft.title,
      content: postDraft.content,
      originImageUrls: originImageUrls,
      thumbnailImageUrls: thumbnailImageUrls,
      price: postDraft.price,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tradeType: postDraft.tradeType,
      meetingPointLat: meetingPointLat,
      meetingPointLong: meetingPointLong,
      detailAddress: postDraft.detailAddress,
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
