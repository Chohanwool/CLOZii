// features
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/number_format.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/presentation/providers/post_detail/post_detail_provider.dart';
import 'package:clozii/features/post/presentation/widgets/post_detail/post_detail_app_bar.dart';
import 'package:clozii/features/post/presentation/widgets/post_detail/post_detail_body.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key, required this.post});

  final Post post;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  // 아래의 스크롤 컨트롤러는 UI 조작용이므로, Screen 에 둔다.
  // 비즈니스 로직과 관련된 컨트롤러의 경우 viewModel 에 둬야 한다. (예: 스크롤 끝에서 다음 데이터 로드, 특정 위치에서 ViewModel 호출 등)
  late final ScrollController _controller; // 스크롤 컨트롤러
  late Post _currentPost; // 현재 게시글

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScroll);
    _currentPost = widget.post; // navigation parameter로 받은 post 저장
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // TODO - 액션 로직 ViewModel로 이동: 공유, 더보기, 좋아요, 신고 등 메서드로 캡슐화
  // TODO - ref.watch 범위 축소: select로 필요한 필드만 구독해 리빌드 최소화
  // TODO - 로딩/에러 상태 도입: 이미지/지도/네트워크 연동 시 isLoading, errorMessage 추가
  // TODO - 상수/문자열 분리 : 하드코딩 텍스트는 constants/localization 로 이동
  @override
  Widget build(BuildContext context) {
    final postDetailState = ref.watch(postDetailProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      // CustomScrollView: 스크롤 가능한 위젯
      body: CustomScrollView(
        controller: _controller,

        // slivers: 스크롤 가능한 위젯의 일부분
        slivers: [
          // SliverAppBar: 상단 앱바
          PostDetailAppBar(
            post: _currentPost,
            isExpanded: postDetailState.isExpanded,
            stretchOffset: postDetailState.stretchOffset,
          ),

          // SliverToBoxAdapter: 앱바 하단 고정 영역
          PostDetailBody(post: _currentPost),
        ],
      ),

      // 네비게이션 바 - 좋아요 버튼, 가격 표시, 채팅 버튼
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: context.colors.shadow)),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  size: 28.0,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12.0),
              const VerticalDivider(
                indent: 8.0,
                endIndent: 8.0,
                color: AppColors.borderDark,
                thickness: 1,
                width: 1,
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentPost.price != 0
                        ? '\u20B1 ${formatPrice(_currentPost.price)}'
                        : 'Sharing',
                    style: context.textTheme.titleLarge,
                  ),
                  const Text(
                    'Price negotiable',
                  ), // "Price negotiable" / "Price fixed"
                ],
              ),
              Spacer(),
              Expanded(
                child: CustomButton(text: 'Chat', onTap: () {}),
              ),
              const SizedBox(width: 12.0),
            ],
          ),
        ),
      ),
    );
  }

  void _onScroll() {
    // 300 - kToolbarHeight = 244
    // 화면 최초 진입 : (스크롤 X) _controller.offset == 0
    // 화면을 아래로 스크롤 하면 _controller.offset의 값은 증가함
    // 스크롤 위치가 244를 초과하면 isExpanded = false
    final isExpanded = _controller.offset < (300 - kToolbarHeight);

    // stretchOffset: 화면을 위로 당길 때(오버스크롤 시) 발생하는 추가 스크롤 거리 값
    // - _controller.offset 이 0보다 작을수록 더 많이 당겨진 상태를 의미함
    // - 이 값을 이용해 배경 이미지를 위쪽으로 확대하여, 오버스크롤 시 상단에 공백이 생기지 않도록 처리함
    final stretchOffset = _controller.offset < 0 ? _controller.offset : 0.0;

    ref
        .read(postDetailProvider.notifier)
        .updateScrollState(isExpanded, stretchOffset);
  }
}
