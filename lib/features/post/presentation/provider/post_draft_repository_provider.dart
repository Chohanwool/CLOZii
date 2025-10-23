import 'package:clozii/features/post/data/repositories/post_draft_repository_impl.dart';
import 'package:clozii/features/post/domain/repositories/post_draft_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// PostDraftRepository Provider
final postDraftRepositoryProvider = Provider<PostDraftRepository>(
  (ref) => PostDraftRepositoryImpl(),
);
