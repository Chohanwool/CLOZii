import 'package:clozii/features/post/presentation/states/post_create_state.dart';

/// 게시글 임시저장 Repository Interface (Domain Layer)
abstract class PostDraftRepository {
  /// 게시글 임시저장
  Future<void> saveDraft(PostCreateState state);

  /// 임시저장된 게시글 불러오기
  Future<PostCreateState?> loadDraft();

  /// 임시저장된 게시글 삭제
  Future<void> deleteDraft();
}
