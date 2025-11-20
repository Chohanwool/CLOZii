import 'package:clozii/features/post/application/dto/post_draft.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';

class CreatePost {
  final PostRepository _postRepository;

  const CreatePost(this._postRepository);

  void call(PostDraft postDraft) async {
    _postRepository.createPost(postDraft);
  }
}
