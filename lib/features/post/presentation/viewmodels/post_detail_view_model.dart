import 'package:clozii/features/post/presentation/states/post_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailViewModel extends Notifier<PostDetailState> {
  @override
  PostDetailState build() => PostDetailState();

  void updateScrollState(bool isExpanded, double stretchOffset) {
    state = state.copyWith(
      isExpanded: isExpanded,
      stretchOffset: stretchOffset,
    );
  }
}
