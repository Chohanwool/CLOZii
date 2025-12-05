// core
import 'package:clozii/core/theme/context_extension.dart';

// feature
import 'package:clozii/features/post/domain/entities/post.dart';

// package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostDetailAppBar extends StatelessWidget {
  const PostDetailAppBar({
    super.key,
    required this.post,
    required this.isExpanded,
    required this.stretchOffset,
  });

  final Post post;
  final bool isExpanded;
  final double stretchOffset;

  @override
  Widget build(BuildContext context) {
    return post.images.isNotEmpty
        ? appBarWithImage(context)
        : appBarWithoutImage(context);
  }

  Widget appBarWithImage(BuildContext context) {
    return SliverAppBar(
      // 상단 앱바 배경 색상
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.transparent, // Material 3에서 생기는 표면 색상 제거
      stretch: true, // 스트레치 효과 활성화 (오버스크롤 시 앱바 부분도 확장될 수 있도록)
      pinned: true, // 앱바 고정 여부 (true: 고정, false: 스크롤 시 사라짐)
      // 상태바 아이콘 색상 설정
      // 앱바가 확장되어 있으면, 상태바 아이콘 색상을 밝게 설정
      // 앱바가 축소되면, 상태바 아이콘 색상을 어둡게 설정
      systemOverlayStyle:
          isExpanded ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,

      // 상단 앱바 아이콘(텍스트 등) 색상 설정
      // 앱바가 확장되어 있으면, 아이콘 색상을 밝게 설정
      // 앱바가 축소되면, 아이콘 색상을 어둡게 설정
      foregroundColor: isExpanded ? context.colors.onPrimary : Colors.black,

      // 상단 앱바 기본 높이 설정 (전체 화면 높이의 45%)
      // 하지만 실제 적용되는 높이는 상태바 높이만큼 더 높아짐
      // 즉, expandedHeight = 전체 화면 높이의 45% + 상태바 높이
      // expandedHeight
      // = MediaQuery.of(context).size.height * 0.45
      // + MediaQuery.of(context).padding.top 와 같음
      expandedHeight: MediaQuery.of(context).size.height * 0.45,

      // 앱바 위젯 설정
      // LayoutBuilder: 앱바 크기 변경 시 재렌더링
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          // 앱바 기본 확장 상태 높이
          final double expandedHeight =
              MediaQuery.of(context).size.height * 0.45;

          // 앱바 높이
          final double toolbarHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;

          // 접힌 높이 계산
          // expandedHeight: 앱바 기본 확장 상태 높이
          // constraints.maxHeight: 현재 SliverAppBar가 차지하고 있는 실제 높이
          // 스크롤 안한 상태 : expandedHeight == constraints.maxHeight
          // 정상 스크롤 (아래로) : expandedHeight > constraints.maxHeight
          // 오버스크롤 (위로) : expandedHeight < constraints.maxHeight
          final double collapseExtent = expandedHeight - constraints.maxHeight;

          return Stack(
            children: [
              // 배경 이미지 위치 설정 :
              // 기본적으로 SliverAppBar의 flexibleSpace 에 지정되는 위젯은
              // top: 0 으로 지정해도 상태바 높이만큼 아래로 내려간 위치에서 표시됨
              // 따라서 배경 이미지 위치를 상태바 뒤까지 적용하기 위해서는 상태바 높이만큼 위로 올려줘야 함
              // 추가로 collapseExtent 를 사용하여 스크롤 상태에 따라 배경 이미지 위치를 조정함
              // _stretchOffset 은 화면이 얼마만큼 오버스크롤 되었는지 알 수 있는 수치이며,
              // 이 수치만큼 배경 이미지를 확대하여 오버스크롤 시 상단에 공백이 표시 되는 것을 방지함
              Positioned(
                // 계산 예시:
                // 초기 화면 상태 : collapseExtent = 0, _stretchOffset = 0, padding.top = 59
                // top: 0 - 59 + 0 = top: -59
                // 정상 스크롤 (아래로) : collapseExtent = 100, _stretchOffset = 0
                // top: -100 - 59 + 0 = top: -159
                // 오버스크롤 (위로) : collapseExtent = -100, _stretchOffset = -100
                // top: 100 - 59 + -100 = top: -59
                top: -collapseExtent -
                    MediaQuery.of(context).padding.top +
                    stretchOffset,

                // (left, right = 0) == (width: double.infinity)
                left: 0,
                right: 0,

                // 배경 이미지 높이 설정
                // SliverAppBar의 expandedHeight와 동일하게 지정해야 함
                // 하지만 실제 적용되는 높이는 상태바 높이만큼 높아지기 때문에
                // 이미지 높이도 상태바 높이만큼 높아져야 함
                // height(이미지 높이) = expandedHeight(전체 화면 높이의 45%) + 상태바 높이
                // 여기에 오버스크롤 시에만 적용되는 _stretchOffset 빼줘야 함
                // _stretchOffset 은 화면이 얼마만큼 오버스크롤 되었는지 알 수 있는 수치이며,
                // _stretchOffset 은 항상 음수이다
                // 따라서 _stretchOffset 만큼 이미지 높이를 추가하기 위해서는
                // _stretchOffset 를 빼줘야 함
                // 예를 들어 -100만큼 오버스크롤이 된 경우 (-(-100)) = 100만큼 이미지 높이를 추가
                height: expandedHeight +
                    MediaQuery.of(context).padding.top -
                    stretchOffset,

                // PageView: 이미지 슬라이드 위젯
                child: PageView(
                  children: [
                    ...post.images.map(
                      (imageData) => Image.network(
                        imageData.originUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              // 상단 오버레이 (앱바)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: toolbarHeight,
                child: Container(
                  decoration: BoxDecoration(
                    // _isExpanded = true 인 경우, 화면 상단에 약간 어두운 그라데이션을 적용함
                    gradient: isExpanded
                        ? const LinearGradient(
                            colors: [Colors.black38, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : null,

                    // _isExpanded = false 인 경우, 화면 상단에 흰색 배경을 적용함
                    color: !isExpanded ? Colors.white : null,
                  ),
                ),
              ),
            ],
          );
        },
      ),

      // 앱바 오른쪽 아이콘 설정
      actions: [
        // 공유 버튼
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill),
        ),
        // 더보기 버튼
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }

  Widget appBarWithoutImage(BuildContext context) {
    return SliverAppBar(
      // 상단 앱바 배경 색상
      backgroundColor: context.colors.surface,
      surfaceTintColor: Colors.transparent, // Material 3에서 생기는 표면 색상 제거
      pinned: true, // 앱바 고정 여부 (true: 고정, false: 스크롤 시 사라짐)
      // 상단 앱바 아이콘(텍스트 등) 색상 설정
      foregroundColor: Colors.black,

      // 상단 앱바 기본 높이 설정 (전체 화면 높이의 45%)
      // 하지만 실제 적용되는 높이는 상태바 높이만큼 더 높아짐
      // 즉, expandedHeight = 전체 화면 높이의 45% + 상태바 높이
      // expandedHeight
      // = MediaQuery.of(context).size.height * 0.45
      // + MediaQuery.of(context).padding.top 와 같음
      expandedHeight: kToolbarHeight,

      // 앱바 오른쪽 아이콘 설정
      actions: [
        // 공유 버튼
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill),
        ),
        // 더보기 버튼
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}
