import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/number_format.dart';
import 'package:clozii/core/utils/show_uploaded_time.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/core/widgets/custom_text_link.dart';
import 'package:clozii/features/post/data/post.dart';
import 'package:clozii/features/post/presentation/widgets/chat_field.dart';
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
  bool _isExpanded = true;
  final ScrollController _controller = ScrollController();
  double _stretchOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isExpanded = _controller.offset < (300 - kToolbarHeight);
        // 위로 스크롤할 때만 stretch offset 계산 (음수 값)
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

      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.transparent,
            stretch: true,
            pinned: true,
            systemOverlayStyle: _isExpanded
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            foregroundColor: _isExpanded
                ? context.colors.onPrimary
                : Colors.black,
            expandedHeight: MediaQuery.of(context).size.height * 0.45,

            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final double expandedHeight =
                    MediaQuery.of(context).size.height * 0.45;
                final double toolbarHeight =
                    kToolbarHeight + MediaQuery.of(context).padding.top;
                final double collapseExtent =
                    expandedHeight - constraints.maxHeight;

                return Stack(
                  children: [
                    // 배경 이미지 - 위로 당길 때만 확대
                    Positioned(
                      top:
                          -collapseExtent -
                          MediaQuery.of(context).padding.top +
                          _stretchOffset,
                      left: 0,
                      right: 0,
                      height:
                          expandedHeight +
                          MediaQuery.of(context).padding.top -
                          _stretchOffset,
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
                          gradient: _isExpanded
                              ? LinearGradient(
                                  colors: [Colors.black38, Colors.transparent],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                              : null,
                          color: !_isExpanded ? Colors.white : null,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.arrowshape_turn_up_right_fill),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          ),
          SliverToBoxAdapter(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('사용자 정보', style: context.textTheme.titleLarge),
                      Text('매너 온도', style: context.textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(indent: 20, endIndent: 20),
                  const SizedBox(height: 10),
                  Text(widget.post.title, style: context.textTheme.titleLarge),
                  const SizedBox(height: 10),
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

                      Material(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadiusGeometry.circular(16.0),
                        child: Container(
                          width: double.infinity,
                          height: 150.0,
                          color: Colors.grey,

                          // 지도 화면
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
