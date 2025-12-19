import 'package:clozii/core/providers/location_provider.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/presentation/screens/post_detail_screen.dart';
import 'package:clozii/features/post/presentation/widgets/post_list/post_list_tile.dart';
import 'package:clozii/features/search/presentation/providers/search/search_state_provider.dart';
import 'package:clozii/features/search/presentation/providers/search_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResult extends ConsumerStatefulWidget {
  const SearchResult({super.key, required this.query});

  final String query;

  @override
  ConsumerState<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends ConsumerState<SearchResult> {
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchPosts();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(searchProvider, (previous, next) {
      if (previous?.selectedFilter != next.selectedFilter) {
        debugPrint(
            '\n🔍 Search filter changed to: ${next.selectedFilter.displayName}. Reloading posts...');
        setState(() {
          _isLoading = true;
        });
        _searchPosts();
      }
    });

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _onRefresh, // 새로고침 함수 연결
            child: _posts.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 200),
                      Center(child: Text('No posts available')),
                    ],
                  )
                : ListView.builder(
                    physics:
                        const AlwaysScrollableScrollPhysics(), // 리스트가 비어도 스크롤 가능
                    itemCount: _posts.length,
                    itemBuilder: (context, index) => PostListTile(
                      post: _posts[index],
                      onTap: _navigateToPostDetail, // 게시글 클릭 시 상세 페이지 이동
                    ),
                  ),
          );
  }

  // 게시글 검색 (필터 적용)
  Future<void> _searchPosts() async {
    try {
      debugPrint('════════════════════════════════════════');
      debugPrint('📥 Loading posts from Firebase...');

      final filter = ref.read(searchProvider).selectedFilter;
      final position = ref.read(locationProvider).position;

      final searchPostsByFilter = ref.read(searchPostsByFilterProvider);
      final posts = await searchPostsByFilter(
        query: widget.query,
        filter: filter,
        userPosition: position,
      );

      debugPrint('📦 Received ${posts.length} posts from Firebase');
      debugPrint('════════════════════════════════════════');

      if (mounted) {
        setState(() {
          _posts = posts;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load posts: $e')),
        );
        debugPrint('════════════════════════════════════════');
        debugPrint('❌ Failed to load posts: $e');
        debugPrint('════════════════════════════════════════');
      }
    }
  }

  // 새로고침
  Future<void> _onRefresh() async {
    debugPrint('\n🔄 Refreshing posts...');
    await _searchPosts();
    debugPrint('✅ Refresh complete. Loaded ${_posts.length} posts\n');
  }

  // 게시글 상세 화면으로 이동
  void _navigateToPostDetail(Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(post: post),
      ),
    );
  }
}
