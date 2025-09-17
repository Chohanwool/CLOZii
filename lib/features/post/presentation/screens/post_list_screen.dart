import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/data/dummy_posts.dart';
import 'package:clozii/features/post/data/post.dart';
import 'package:clozii/features/post/presentation/screens/post_detail_screen.dart';
import 'package:clozii/features/post/presentation/widgets/post_list_tile.dart';
import 'package:flutter/material.dart';

/// 앱 메인 화면 - 로그인 이후 화면 (게시글 목록 화면이 될 가능성이 큼)
class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<Post> _posts = dummyPosts;

  // 새로고침
  // RefreshIndicator와 연결되어 pull-to-refresh 시 호출됨
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
    return Scaffold(
      /// 앱 바
      appBar: AppBar(
        surfaceTintColor: Colors.transparent, // Material 3에서 생기는 표면 색상 제거
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Address'), // 현재 주소 표시
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.expand_more),
            ), // 주소 선택 버튼
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
        shape: Border(bottom: BorderSide(color: Colors.black12)),
      ),

      /// 하단 메뉴 - 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        // 5개 이상이 되면 자동으로 BottomNavigationBarType.shifting 모드로 바뀌는데,
        // 이때 각 아이템에 backgroundColor가 없으면 UI가 깨지거나 사라져 보일 수 있다.
        // 아래 코드를 작성하면 4개까지는 문제 없이 보임
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'CLOZ ME',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My'),
        ],
      ),

      /// 본문 - body widgets
      body: Stack(
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
      ),
    );
  }
}
