import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePost {
  final AuthRepository _authRepository;
  final PostRepository _postRepository;

  const CreatePost(this._postRepository, this._authRepository);

  Future<Post> call(PostDraft postDraft) async {
    final result = await _authRepository.getCurrentUser();

    if (!result.isSuccess) {
      throw Exception('사용자를 불러오지 못했습니다.');
    }

    // AuthRepository 에서 AuthResult.success() 반환 시 유저 정보는 null 일 수 없음
    final user = result.data!;

    // 1. 새 postId 생성
    final postId = _postRepository.generatePostId();

    // 2. Post 엔티티 생성 (images는 빈 배열)
    final post = postDraft.toPost(
      id: postId,
      authorUid: user.uid,
      authorNickname: user.name,
    );

    // 3. Firestore에 Post 먼저 저장
    await _postRepository.createPost(post);

    // 4. Storage에 이미지 업로드 (이제 isPostOwner() 통과)
    final imageUrls = await _postRepository.uploadImages(
      postId: postId,
      originImages: postDraft.originImages,
      thumbnailImages: postDraft.thumbnailImages,
    );

    // 5. Post의 images 필드 업데이트 (updateTimestamp: false로 createdAt == updatedAt 유지)
    final updatedPost = post.copyWith(images: imageUrls);
    return await _postRepository.updatePost(updatedPost,
        updateTimestamp: false);
  }
}
