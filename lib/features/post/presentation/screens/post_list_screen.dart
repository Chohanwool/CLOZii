// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/providers/location_provider.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';

// feature
import 'package:clozii/features/post/application/dto/post_summary.dart';
import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';
import 'package:clozii/features/post/presentation/screens/post_create_screen.dart';
import 'package:clozii/features/post/presentation/screens/post_detail_screen.dart';
import 'package:clozii/features/post/presentation/widgets/post_list/post_list_tile.dart';
import 'package:clozii/features/post/presentation/providers/post_list/post_list_provider.dart';
import 'package:clozii/features/search/presentation/providers/search_providers.dart';

//package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({super.key});

  @override
  ConsumerState<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {
  List<PostSummary> _posts = [];
  bool _isLoading = true;
  // region/dropdown moved to postList provider

  @override
  void initState() {
    super.initState();
    _searchPosts();
  }

  @override
  Widget build(BuildContext context) {
    // 필터 변경 감지 (예: All -> Category)
    ref.listen(postListProvider, (previous, next) {
      if (previous?.selectedFilter != next.selectedFilter) {
        debugPrint(
            '\n🔍 Search filter changed to: ${next.selectedFilter.displayName}. Reloading posts...');
        setState(() {
          _isLoading = true;
        });
        _searchPosts();
      }
    });

    // 카테고리 필터가 선택되어 있는 상태에서 다시 카테고리 필터 탭 감지
    ref.listen(postListProvider, (previous, next) {
      if (previous?.selectedFilter == PostFilter.category &&
          previous?.selectedCategory != next.selectedCategory) {
        debugPrint(
            '\n🔍 Category set to: ${next.selectedCategory!.displayName}. Reloading posts...');
        setState(() {
          _isLoading = true;
        });
        _searchPosts();
      }
    });

    return Stack(
      children: [
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _onRefresh,
                child: _posts.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 200),
                          Center(child: Text('No posts available')),
                        ],
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: _posts.length,
                        itemBuilder: (context, index) => PostListTile(
                          post: _posts[index],
                          onTap: _navigateToPostDetail,
                        ),
                      ),
              ),

        // 오른쪽 하단 Create 버튼
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(100),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: _showPostCreateModal,
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.white24;
                  }
                  return null;
                }),
                child: SizedBox(
                  width: 110,
                  height: 55,
                  child: Row(
                    children: [
                      const Spacer(flex: 2),
                      Icon(
                        Icons.add,
                        color: context.colors.onPrimary,
                      ),
                      Text(
                        'Create',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 새로고침
  Future<void> _onRefresh() async {
    debugPrint('\n🔄 Refreshing posts...');
    await _searchPosts();
    debugPrint('✅ Refresh complete. Loaded ${_posts.length} posts\n');
  }

  // 게시글 상세 화면으로 이동
  void _navigateToPostDetail(PostSummary post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(postId: post.id),
      ),
    );
  }

  // Cross - feature 의존성있지만, 같은 feature 내이므로 허용 가능
  // UX를 위해 게시글 생성 화면 진입 전 다이얼로그 표시 필요!
  // 게시글 생성 모달 띄우기
  void _showPostCreateModal() async {
    final draft = await ref.read(postCreateProvider.notifier).loadTemp();

    // 임시저장 데이터가 있을 경우, 안내메시지 표시
    if (draft != null && mounted) {
      final result = await showConfirmDialog(
        context: context,
        title: 'Alert',
        messageBody:
            'There is an existing draft. Do you want to continue creating a new post?',
        confirmButtonText: 'Continue',
        cancelButtonText: 'Create New Post',
      );

      if (result != null && !result) {
        ref.read(postCreateProvider.notifier).deleteTemp();
        ref.read(postCreateProvider.notifier).resetState();
      }
    }

    if (!mounted) return;
    final newPost = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => Container(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
          bottom: kBottomNavigationBarHeight,
        ),
        color: AppColors.white,
        child: const PostCreateScreen(),
      ),
    );

    if (newPost == true) {
      _onRefresh();
    }
  }

  // 게시글 검색 (필터 적용)
  Future<void> _searchPosts() async {
    try {
      debugPrint('════════════════════════════════════════');
      debugPrint('📥 Loading posts from Firebase...');

      final position = ref.read(locationProvider).position;
      final filter = ref.read(postListProvider).selectedFilter;
      final category = ref.read(postListProvider).selectedCategory;

      final loadPostsByFilter = ref.read(loadPostsByFilterProvider);
      final posts = await loadPostsByFilter(
        filter: filter,
        userPosition: position,
        selectedCategory: category,
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
}
