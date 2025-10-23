// lib/features/post/data/repositories/post_draft_repository.dart
import 'package:clozii/features/post/presentation/states/post_create_state.dart';
import 'package:hive/hive.dart';

class PostDraftRepository {
  static const String _boxName = 'postDraft';
  static const String _draftKey = 'draft';

  Future<void> saveDraft(PostCreateState state) async {
    final box = await Hive.openBox<PostCreateState>(_boxName);
    await box.put(_draftKey, state);
  }

  Future<PostCreateState?> loadDraft() async {
    final box = await Hive.openBox<PostCreateState>(_boxName);
    return box.get(_draftKey);
  }

  Future<void> deleteDraft() async {
    final box = await Hive.openBox<PostCreateState>(_boxName);
    await box.delete(_draftKey);
  }
}
