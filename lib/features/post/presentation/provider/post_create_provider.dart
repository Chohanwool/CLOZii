import 'package:clozii/features/post/presentation/states/post_create_state.dart';
import 'package:clozii/features/post/presentation/viewmodels/post_create_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postCreateProvider =
    NotifierProvider<PostCreateViewModel, PostCreateState>(
      PostCreateViewModel.new,
    );
