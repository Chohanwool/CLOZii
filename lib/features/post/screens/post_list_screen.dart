import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/data/dummy_posts.dart';
import 'package:clozii/features/post/data/post.dart';
import 'package:clozii/features/post/screens/post_detail_screen.dart';
import 'package:clozii/features/post/widgets/post_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 앱 메인 화면 - 로그인 이후 화면 (게시글 목록 화면이 될 가능성이 큼)
class PostListScreen extends StatefulWidget {
  PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<Post> _posts = dummyPosts;

  Future<void> _onRefresh() async {
    // TODO: 실제 API 호출
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _posts = List<Post>.from(_posts)..shuffle(); // 예시로 셔플
    });
  }

  void _navigateToPostDetail(Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Address'),
            IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
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
      bottomNavigationBar: BottomNavigationBar(
        // 개 이상이 되면 자동으로 BottomNavigationBarType.shifting 모드로 바뀌는데,
        // 이때 각 아이템에 backgroundColor가 없으면 UI가 깨지거나 사라져 보일 수 있다.
        // 아래 코드를 작성하면 4-5개까지는 문제 없이 보임
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
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _posts.length,
              itemBuilder: (context, index) => PostListTile(
                post: _posts[index],
                onTap: _navigateToPostDetail,
              ),
            ),
          ),
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
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.white24;
                    }
                    return null; // 기본
                  }),
                  child: SizedBox(
                    width: 110,
                    height: 55,
                    child: Row(
                      children: [
                        Spacer(flex: 2),
                        Icon(Icons.add, color: context.colors.onPrimary),
                        Text(
                          'Create',
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
