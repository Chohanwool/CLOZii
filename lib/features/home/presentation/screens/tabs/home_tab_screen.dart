import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/data/dummy_posts.dart';
import 'package:clozii/features/post/data/post.dart';
import 'package:clozii/features/post/presentation/screens/post_detail_screen.dart';
import 'package:clozii/features/post/presentation/widgets/post_list_tile.dart';
import 'package:flutter/material.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  List<Post> _posts = dummyPosts;

  // 새로고침
  Future<void> _onRefresh() async {
    // TODO: 실제 API 호출 - 게시글 목록 조회
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _posts = List<Post>.from(_posts)
        ..shuffle(); // 예시로 더미 데이터를 셔플해서 마치 새로 불러온 것처럼 보이게 함
    });
  }

  // 게시글 상세 화면으로 이동
  void _navigateToPostDetail(Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)),
    );
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
                onTap: () {},
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
