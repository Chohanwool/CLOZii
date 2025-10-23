import 'package:clozii/features/post/domain/repositories/post_draft_repository.dart';
import 'package:clozii/features/post/presentation/states/post_create_state.dart';
import 'package:hive/hive.dart';

/// Hive 기반 게시글 임시저장 Repository 구현체 (Data Layer)
class PostDraftRepositoryImpl implements PostDraftRepository {
  static const String _boxName = 'postDraft';
  static const String _draftKey = 'draft';

  @override
  Future<void> saveDraft(PostCreateState state) async {
    final box = await Hive.openBox<PostCreateState>(_boxName);
    await box.put(_draftKey, state);
  }

  @override
  Future<PostCreateState?> loadDraft() async {
    final box = await Hive.openBox<PostCreateState>(_boxName);
    return box.get(_draftKey);
  }

  @override
  Future<void> deleteDraft() async {
    final box = await Hive.openBox<PostCreateState>(_boxName);
    await box.delete(_draftKey);
  }
}
