import 'package:clozii/features/post/presentation/states/post_detail_state.dart';
import 'package:clozii/features/post/presentation/viewmodels/post_detail_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postDetailProvider =
    NotifierProvider<PostDetailViewModel, PostDetailState>(
      PostDetailViewModel.new,
    );
