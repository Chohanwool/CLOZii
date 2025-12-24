import 'package:clozii/core/providers/location_provider.dart';
import 'package:clozii/features/post/application/dto/post_summary.dart';
import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:clozii/features/post/presentation/screens/post_detail_screen.dart';
import 'package:clozii/features/post/presentation/widgets/post_list/post_list_tile.dart';
import 'package:clozii/features/search/presentation/providers/search/search_state_provider.dart';
import 'package:clozii/features/search/presentation/providers/search_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResult extends ConsumerStatefulWidget {
  const SearchResult({super.key});

  @override
  ConsumerState<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends ConsumerState<SearchResult> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeSearch(ref.read(searchProvider));
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    final results = searchState.results;

    if (searchState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    ref.listen<SearchState>(searchProvider, (previous, next) {
      if (previous?.searchQuery != next.searchQuery) {
        ref.read(searchProvider.notifier).setSelectedFilter(PostFilter.all);
      }

      final filterChanged = previous?.selectedFilter != next.selectedFilter;
      final queryChanged = previous?.searchQuery != next.searchQuery;
      final submitChanged = previous?.hasSubmitted != next.hasSubmitted;

      if (next.hasSubmitted &&
          (filterChanged || queryChanged || submitChanged)) {
        _maybeSearch(next);
      }
    });

    return RefreshIndicator(
      onRefresh: () => _maybeSearch(searchState, force: true),
      child: results.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 200),
                Center(child: Text('No posts available')),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) => PostListTile(
                post: results[index],
                onTap: _navigateToPostDetail,
              ),
            ),
    );
  }

  Future<void> _maybeSearch(
    SearchState state, {
    bool force = false,
  }) async {
    // 방어: 검색 제출 전이거나 검색어가 비어 있으면 요청하지 않음.
    if (!state.hasSubmitted || state.searchQuery.isEmpty) {
      return;
    }
    // 방어: 이미 검색 중이면 중복 요청 방지.
    if (state.isLoading) {
      return;
    }

    final isSameQuery = state.resultsQuery == state.searchQuery;
    final isSameFilter = state.resultsFilter == state.selectedFilter;
    // 방어: 동일한 검색어/필터 결과가 있으면 재요청하지 않음.
    if (!force && isSameQuery && isSameFilter && state.results.isNotEmpty) {
      return;
    }

    // 새로고침(force:true) 시 로딩 오버레이 중복 표시 방지.
    if (!force) {
      ref.read(searchProvider.notifier).setLoading(true);
    }

    try {
      debugPrint('════════════════════════════════════════');
      debugPrint('📥 Loading posts from Algolia...');

      final filter = state.selectedFilter;
      final position = ref.read(locationProvider).position;
      final searchPostsByFilter = ref.read(searchPostsByFilterProvider);
      final posts = await searchPostsByFilter(
        query: state.searchQuery,
        filter: filter,
        userPosition: position,
      );

      debugPrint('📦 Received ${posts.length} posts from Algolia');
      debugPrint('════════════════════════════════════════');

      ref.read(searchProvider.notifier).setResults(
            results: posts,
            query: state.searchQuery,
            filter: filter,
          );
    } catch (e) {
      ref.read(searchProvider.notifier).setLoading(false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load posts: $e')),
        );
        debugPrint('════════════════════════════════════════');
        debugPrint('❌ Failed to load posts: $e');
        debugPrint('════════════════════════════════════════');
      }
    }
  }

  // 게시글 상세 화면으로 이동
  void _navigateToPostDetail(PostSummary post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(postId: post.id),
      ),
    );
  }
}
