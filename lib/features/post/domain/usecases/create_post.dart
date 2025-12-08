import 'package:clozii/features/auth/domain/repositories/auth_repository.dart';
import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';

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

    final uploadResult = await _postRepository.uploadImages(
      postDraft.originImages,
      postDraft.thumbnailImages,
    );

    final post = postDraft
        .toPost(
          id: uploadResult.id,
          authorUid: user.uid,
          authorNickname: user.name,
        )
        .copyWith(images: uploadResult.imageUrls);

    return await _postRepository.createPost(post);
  }
}
