import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_list_provider.freezed.dart';
part 'post_list_provider.g.dart';

@freezed
sealed class PostListState with _$PostListState {
  const PostListState._();

  const factory PostListState({
    @Default(PostFilter.all) PostFilter selectedFilter,
    @Default('Sta.Rosa') String selectedRegion,
    @Default(false) bool isDropdownOpen,
  }) = _PostListState;
}

@riverpod
class PostList extends _$PostList {
  @override
  PostListState build() {
    return const PostListState();
  }

  // 필터 업데이트
  void updateSelectedFilter(PostFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  // region / dropdown state helpers
  void setRegion(String region) {
    state = state.copyWith(selectedRegion: region);
  }

  void toggleDropdown() {
    state = state.copyWith(isDropdownOpen: !state.isDropdownOpen);
  }

  void setDropdown(bool open) {
    state = state.copyWith(isDropdownOpen: open);
  }
}
