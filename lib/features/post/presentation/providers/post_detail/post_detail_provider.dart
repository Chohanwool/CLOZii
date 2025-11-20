import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// parts
part 'post_detail_provider.freezed.dart';
part 'post_detail_provider.g.dart';

// ============================================================================
// State
// ============================================================================

@freezed
sealed class PostDetailState with _$PostDetailState {
  const PostDetailState._();

  const factory PostDetailState({
    @Default(true) bool isExpanded,
    @Default(0.0) double stretchOffset,
  }) = _PostDetailState;
}

// ============================================================================
// Provider (ViewModel)
// ============================================================================

@riverpod
class PostDetail extends _$PostDetail {
  @override
  PostDetailState build() {
    return const PostDetailState();
  }

  void updateScrollState(bool isExpanded, double stretchOffset) {
    state = state.copyWith(
      isExpanded: isExpanded,
      stretchOffset: stretchOffset,
    );
  }
}
