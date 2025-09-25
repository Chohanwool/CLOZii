// core
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/number_format.dart';
import 'package:clozii/core/utils/show_uploaded_time.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/core/widgets/custom_text_link.dart';

// features
import 'package:clozii/features/post/data/post.dart';
import 'package:clozii/features/post/presentation/widgets/post_detail/chat_field.dart';

// packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.post});

  final Post post;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  // background 이미지 확장 여부
  bool _isExpanded = true;

  final ScrollController _controller = ScrollController(); // 스크롤 컨트롤러
  double _stretchOffset = 0.0; // 스트레치 오프셋

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        // 300 - kToolbarHeight = 292
        // 292(Height) 보다 적게 스크롤 한 경우 true, 그 이상일 경우 false
        _isExpanded = _controller.offset < (300 - kToolbarHeight);

        // 오버스크롤 시에만 stretch offset 계산 (음수 값)
        // 스크롤 위치가 0인 경우 -> 아직 스크롤 하지 않은 상태
        // 스크롤 위치가 0보다 큰 경우 -> 정상 스크롤 상태
        // 스크롤 위치가 0보다 작은 경우 -> 오버스크롤 상태
        _stretchOffset = _controller.offset < 0 ? _controller.offset : 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 챗 박스
      bottomSheet: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: context.colors.shadow)),
        ),
        child: Row(
          children: [
            // ... 아이콘, TextField, Send 버튼
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border_outlined, size: 30.0),
            ),
            Expanded(child: ChatField()),
            CustomButton(text: 'Send', onTap: () {}, width: 80.0, height: 45.0),
          ],
        ),
      ),

      // 챗 박스 하단 여백
      bottomNavigationBar: Container(height: kToolbarHeight),

      // 본문 - body widgets
      // CustomScrollView: 스크롤 가능한 위젯
      body: CustomScrollView(
        controller: _controller,

        // slivers: 스크롤 가능한 위젯의 일부분
        // SliverAppBar: 상단 앱바
        // SliverToBoxAdapter: 상단 앱바 하단 고정 영역
        slivers: [
          // 상단 앱바
          SliverAppBar(
            // 상단 앱바 배경 색상
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.transparent, // Material 3에서 생기는 표면 색상 제거
            stretch: true, // 스트레치 효과 활성화 (오버스크롤 시 앱바 부분도 확장될 수 있도록)
            pinned: true, // 앱바 고정 여부 (true: 고정, false: 스크롤 시 사라짐)
            // 상태바 아이콘 색상 설정
            // 앱바가 확장되어 있으면, 상태바 아이콘 색상을 밝게 설정
            // 앱바가 축소되면, 상태바 아이콘 색상을 어둡게 설정
            systemOverlayStyle: _isExpanded
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,

            // 상단 앱바 아이콘(텍스트 등) 색상 설정
            // 앱바가 확장되어 있으면, 아이콘 색상을 밝게 설정
            // 앱바가 축소되면, 아이콘 색상을 어둡게 설정
            foregroundColor: _isExpanded
                ? context.colors.onPrimary
                : Colors.black,

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
                final double collapseExtent =
                    expandedHeight - constraints.maxHeight;

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
                      top:
                          -collapseExtent -
                          MediaQuery.of(context).padding.top +
                          _stretchOffset,

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
                      height:
                          expandedHeight +
                          MediaQuery.of(context).padding.top -
                          _stretchOffset,

                      // PageView: 이미지 슬라이드 위젯
                      child: PageView(
                        children: [
                          ...widget.post.imageUrls.map(
                            (url) => Image.network(url, fit: BoxFit.cover),
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
                          gradient: _isExpanded
                              ? LinearGradient(
                                  colors: [Colors.black38, Colors.transparent],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                              : null,

                          // _isExpanded = false 인 경우, 화면 상단에 흰색 배경을 적용함
                          color: !_isExpanded ? Colors.white : null,
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
                icon: Icon(CupertinoIcons.arrowshape_turn_up_right_fill),
              ),
              // 더보기 버튼
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          ),

          // 본문 내용
          SliverToBoxAdapter(
            // 본문 패딩 설정
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 16.0,
                right: 16.0,
                bottom: 65.0 + kToolbarHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 사용자 정보, 매너 온도 표시(예시) - CLOZii 만의 포인트 시스템 필요
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('사용자 정보', style: context.textTheme.titleLarge),
                      Text('매너 온도', style: context.textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 구분선
                  Divider(indent: 20, endIndent: 20),
                  const SizedBox(height: 10),

                  // 제목
                  Text(widget.post.title, style: context.textTheme.titleLarge),
                  const SizedBox(height: 10),

                  // 가격 또는 나눔 표시
                  // Post 객체의 price 필드에 저장된 가격이 있다면 가격을 표시하고,
                  // 없다면(null), 나눔 표시
                  widget.post.price != null
                      ? Text(
                          '\u20B1 ${formatPrice(widget.post.price!)}', //₱
                          style: context.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              'SHARES',
                              style: context.textTheme.titleLarge!.copyWith(
                                color: context.colors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Icon(
                              Icons.favorite,
                              size: 16,
                              color: context.colors.primary,
                            ),
                          ],
                        ),
                  const SizedBox(height: 10.0),

                  // 카테고리(링크 텍스트), 업로드 시간 표시
                  // 카테고리 탭 시, 관련된 상품들만 필터링 된 페이지로 이동
                  Row(
                    children: [
                      CustomTextLink(
                        linkText: 'Category',
                        linkTextStyle: context.textTheme.bodyLarge!.copyWith(
                          color: context.colors.scrim,
                          decoration: TextDecoration.underline,
                          decorationColor: context.colors.scrim,
                        ),
                        onTap: () {},
                      ),
                      Text(' · '),
                      Text(
                        '${showUploadedTime(widget.post.createdAt)} ago',
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: context.colors.scrim,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),

                  // 게시글 내용
                  if (widget.post.content != null)
                    Text(
                      widget.post.content!,
                      style: context.textTheme.bodyLarge,
                    ),

                  const SizedBox(height: 24.0),

                  // 거래 희망 장소
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meeting Point :',
                        style: context.textTheme.titleSmall,
                      ),

                      // 사용자가 입력한 장소명 (예: 광교 고등학교 앞)
                      Row(
                        children: [
                          CustomTextLink(
                            linkText: 'Infront of McDonald\'s Laguna Bel-Air',
                            onTap: () {},
                          ),

                          const SizedBox(width: 10.0),

                          Icon(CupertinoIcons.right_chevron, size: 16.0),
                        ],
                      ),

                      const SizedBox(height: 20.0),

                      // 지도 화면
                      Material(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadiusGeometry.circular(16.0),
                        child: Container(
                          width: double.infinity,
                          height: 150.0,
                          color: Colors.grey,

                          // 지도 이미지
                          child: Image.asset(
                            'assets/images/inmark.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20.0),

                  // 관심수, 조회수 표시
                  Row(
                    children: [
                      Text(
                        'Favorites ${widget.post.favorites} · Views ${widget.post.views}',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20.0),

                  // 신고 링크
                  CustomTextLink(
                    linkText: 'Report this post',
                    linkTextStyle: context.textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
