import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_provider.freezed.dart';
part 'search_provider.g.dart';

// ============================================================================
// State
// ============================================================================

@freezed
sealed class SearchState with _$SearchState {
  const SearchState._();

  const factory SearchState({
    @Default('') String searchQuery, // 휘발성: Provider만 관리
    @Default([]) List<String> recentSearches, // 영구: Provider + 로컬 저장소

    @Default(false) bool hasSubmitted, // 검색 제출 여부
  }) = _SearchState;
}

// ============================================================================
// Provider (ViewModel)
// ============================================================================

@riverpod
class Search extends _$Search {
  static const String _storageKey = 'recent_searches';

  @override
  SearchState build() {
    // 초기화 시 로컬에서 최근 검색어 로드
    _loadRecentSearches();
    return const SearchState();
  }

  // 로컬에서 최근 검색어 로드
  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList(_storageKey) ?? [];
    state = state.copyWith(recentSearches: searches);
  }

  // 로컬에 최근 검색어 저장
  Future<void> _saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, state.recentSearches);
  }

  // 검색어 업데이트 (휘발성 - 저장 안함)
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  // 검색어 클리어
  void clearSearchQuery() {
    state = state.copyWith(searchQuery: '');
  }

  // 최근 검색어 추가 (영구 저장)
  Future<void> addRecentSearch(String query) async {
    if (query.isEmpty) return;

    final searches = [...state.recentSearches];

    searches.remove(query); // 중복 제거

    if (searches.length >= 15) {
      searches.removeLast(); // 최대 개수 초과 시 마지막 항목 제거
    }

    searches.insert(0, query); // 맨 앞에 추가

    state = state.copyWith(recentSearches: searches);
    await _saveRecentSearches(); // 로컬에 저장
  }

  // 최근 검색어 삭제 (영구 저장)
  Future<void> removeRecentSearch(int index) async {
    final searches = [...state.recentSearches];
    searches.removeAt(index);
    state = state.copyWith(recentSearches: searches);
    await _saveRecentSearches(); // 로컬에 저장
  }

  // 최근 검색어 전체 삭제 (영구 저장)
  Future<void> clearRecentSearches() async {
    state = state.copyWith(recentSearches: []);
    await _saveRecentSearches(); // 로컬에서도 삭제
  }

  void setHasSubmitted(bool submitted) {
    state = state.copyWith(hasSubmitted: submitted);
  }
}
