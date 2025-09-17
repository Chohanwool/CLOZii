import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/widgets/post_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 앱 메인 화면 - 로그인 이후 화면 (게시글 목록 화면이 될 가능성이 큼)
class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => PostListTile(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: context.colors.primary,
                  ),
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
        ],
      ),
    );
  }
}
