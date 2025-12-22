import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_state_provider.freezed.dart';
part 'home_state_provider.g.dart';

@freezed
sealed class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default(PostFilter.all) PostFilter selectedFilter,
  }) = _HomeState;
}

@riverpod
class Home extends _$Home {
  @override
  HomeState build() {
    return const HomeState();
  }

  // 필터 업데이트
  void updateSelectedFilter(PostFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}
