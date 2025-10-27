// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_confirm_dialog.dart';

// feature
import 'package:clozii/features/post/application/dummies/dummy_posts.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/presentation/provider/post_create_provider.dart';
import 'package:clozii/features/post/presentation/provider/post_provider.dart';
import 'package:clozii/features/post/presentation/screens/post_create_screen.dart';
import 'package:clozii/features/post/presentation/screens/post_detail_screen.dart';
import 'package:clozii/features/post/presentation/viewmodels/post_view_model.dart';
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
  List<Post> _posts = dummyPosts;

  // 새로고침
  Future<void> _onRefresh() async {
    // TODO: 실제 API 호출 - 게시글 목록 조회
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _posts = List<Post>.from(dummyPosts)
        ..shuffle(); // 예시로 더미 데이터를 셔플해서 마치 새로 불러온 것처럼 보이게 함
    });
  }

  // 게시글 상세 화면으로 이동
  void _navigateToPostDetail(Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProviderScope(
          overrides: [postProvider.overrideWith(() => PostViewModel(post))],
          child: PostDetailScreen(),
        ),
      ),
    );
  }

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
        RefreshIndicator(
          onRefresh: _onRefresh, // 새로고침 함수 연결
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(), // 리스트가 비어도 스크롤 가능
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
                      Spacer(flex: 2),
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
                      Spacer(flex: 3),
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
