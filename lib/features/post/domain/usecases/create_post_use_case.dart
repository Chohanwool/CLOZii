import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository _postRepository;

  const CreatePostUseCase(this._postRepository);

  void call(PostDraft postDraft) async {
    _postRepository.createPost(postDraft);
  }
}
