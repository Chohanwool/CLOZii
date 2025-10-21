import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/presentation/viewmodels/post_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postProvider = NotifierProvider.autoDispose<PostViewModel, Post?>(
  PostViewModel.new,
);
