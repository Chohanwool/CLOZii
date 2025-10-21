// features
import 'package:clozii/features/post/presentation/provider/post_detail_provider.dart';
import 'package:clozii/features/post/presentation/provider/post_provider.dart';
import 'package:clozii/features/post/presentation/widgets/post_detail/chat_box.dart';
import 'package:clozii/features/post/presentation/widgets/post_detail/post_detail_app_bar.dart';
import 'package:clozii/features/post/presentation/widgets/post_detail/post_detail_body.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  // 아래의 스크롤 컨트롤러는 UI 조작용이므로, Screen 에 둔다.
  // 비즈니스 로직과 관련된 컨트롤러의 경우 viewModel 에 둬야 한다. (예: 스크롤 끝에서 다음 데이터 로드, 특정 위치에서 ViewModel 호출 등)
  late final ScrollController _controller; // 스크롤 컨트롤러

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScroll);
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
    // autoDispose로 인해 PostProvider 를 구독하는 위젯이 없으면 자동으로 프로바이더에 등록된 post 가 dispost 됨
    final post = ref.watch(postProvider);
    final postDetailState = ref.watch(postDetailProvider);

    debugPrint(post.toString());
    if (post == null) {
      return Scaffold(
        body: Center(
          // lotties로 대체 가능
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      // CustomScrollView: 스크롤 가능한 위젯
      body: CustomScrollView(
        controller: _controller,

        // slivers: 스크롤 가능한 위젯의 일부분
        slivers: [
          // SliverAppBar: 상단 앱바
          PostDetailAppBar(
            post: post,
            isExpanded: postDetailState.isExpanded,
            stretchOffset: postDetailState.stretchOffset,
          ),

          // SliverToBoxAdapter: 앱바 하단 고정 영역
          PostDetailBody(post: post),
        ],
      ),

      // 챗 박스
      bottomSheet: ChatBox(),

      // 챗 박스 하단 여백
      bottomNavigationBar: Container(height: kToolbarHeight),
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
