// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';

// feature
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';
import 'package:clozii/features/post/presentation/providers/post_providers.dart';
import 'package:clozii/features/post/presentation/screens/post_create_screen.dart';
import 'package:clozii/features/post/presentation/screens/post_detail_screen.dart';
import 'package:clozii/features/post/presentation/widgets/post_list/post_list_tile.dart';

//package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListScreen extends ConsumerStatefulWidget {
  const PostListScreen({super.key});

  @override
  ConsumerState<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends ConsumerState<PostListScreen> {
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  // 게시글 목록 로드
  Future<void> _loadPosts() async {
    try {
      final getAllPosts = ref.read(getAllPostsProvider);
      final posts = await getAllPosts();
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
        debugPrint('Failed to load posts: $e');
      }
    }
  }

  // 새로고침
  Future<void> _onRefresh() async {
    await _loadPosts();
  }

  // 게시글 상세 화면으로 이동
  void _navigateToPostDetail(Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(post: post),
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 게시글 리스트
        _isLoading
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
              ),

        /// 오른쪽 하단 Create 버튼
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
                // 게시글 생성 모달 띄우기
                onTap: _showPostCreateModal,
                splashFactory: NoSplash.splashFactory, // 버튼 클릭 시 잉크 효과 제거
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.white24; // 눌렀을 때 살짝 투명 오버레이
                  }
                  return null; // 기본
                }),
                child: SizedBox(
                  width: 110,
                  height: 55,
                  child: Row(
                    children: [
                      const Spacer(flex: 2),
                      Icon(
                        Icons.add,
                        color: context.colors.onPrimary, // + 아이콘
                      ),
                      Text(
                        'Create', // Create 버튼 텍스트
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
}
