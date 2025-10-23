import 'package:clozii/features/post/domain/usecases/create_post_use_case.dart';
import 'package:clozii/features/post/presentation/provider/memory_post_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createPostUseCaseProvider = Provider<CreatePostUseCase>((ref) {
  final postRepository = ref.read(memoryPostRepositoryProvider);
  return CreatePostUseCase(postRepository);
});
