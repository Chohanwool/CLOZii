import 'package:clozii/features/post/data/repositories/memory_post_repository.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memoryPostRepositoryProvider = Provider<PostRepository>(
  (ref) => MemoryPostRepository(),
);
