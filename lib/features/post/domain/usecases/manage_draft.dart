import 'package:clozii/features/post/domain/repositories/post_draft_repository.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';

class ManageDraft {
  final PostDraftRepository _repository;

  ManageDraft(this._repository);

  Future<void> save(PostCreateState state) async {
    await _repository.saveDraft(state);
  }

  Future<PostCreateState?> load() async {
    return await _repository.loadDraft();
  }

  Future<void> delete() async {
    await _repository.deleteDraft();
  }
}
