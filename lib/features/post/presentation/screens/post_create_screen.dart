// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';

// features
import 'package:clozii/features/post/presentation/widgets/post_create/selectors/image_selector.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/go_to_phrase_modal.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/more_options_modal.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/fields/content_field.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/fields/title_field.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/fields/price_field.dart';
import 'package:clozii/features/post/provider/go_to_phrases_provider.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/selectors/meeting_point_selector.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/selectors/trade_type_selector.dart';
import 'package:clozii/features/post/data/dummy_go_to_phrases.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/add_phrase_modal.dart';
import 'package:clozii/features/post/data/dummy_posts.dart';
import 'package:clozii/features/post/data/post.dart';

// packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCreateScreen extends ConsumerStatefulWidget {
  const PostCreateScreen({super.key});

  @override
  ConsumerState<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends ConsumerState<PostCreateScreen> {
  // 컨트롤러
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // 선택된 자주 쓰는 문구
  String? _selectedPhrase;

  // 선택된 거래 타입
  TradeType _selectedTransactionType = TradeType.sell;

  // 선택된 거래 희망 장소
  String? _detailAddress;

  // Form 키 생성
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(goToPhrasesProvider.notifier).setInitial(dummyGoToPhrases);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // 자주 쓰는 문구 추가 모달 열기
  void _showAddPhraseModal(String? currentPhrase) async {
    // 자주 쓰는 문구 모달 닫기
    Navigator.of(context).pop();

    // 추가한 자주 쓰는 문구 받아오기
    final newPhrase = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => Container(
        // top padding ONLY! - bottom padding 은 모달 내부에서 처리
        // 여기에서 bottom padding 을 추가하면 모달 내부에서 키보드가 뜰때 버튼이 키보드에 붙지 못함
        padding: const EdgeInsets.only(top: kToolbarHeight),
        color: AppColors.white,
        child: AddPhraseModal(phrase: currentPhrase),
      ),
    );

    if (newPhrase != null) {
      if (currentPhrase != null) {
        ref
            .read(goToPhrasesProvider.notifier)
            .editPhrase(currentPhrase, newPhrase);
      }

      final goToPhrases = ref.watch(goToPhrasesProvider);
      if (!goToPhrases.contains(newPhrase)) {
        goToPhrases.add(newPhrase);
      }
    }

    // 자주 쓰는 문구 추가 후 모달 다시 열기 - 새로고침
    _showGoToPhrases();
  }

  void _showMoreOptions(String currentPhrase) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => MoreOptionsModal(
        currentPhrase: currentPhrase,
        onAddPhraseModal: _showAddPhraseModal,
      ),
    );
  }

  // 자주 쓰는 문구 모달 열기
  void _showGoToPhrases() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        height: 400.0,
        child: GoToPhraseModal(
          onAddButtonPressed: _showAddPhraseModal,
          onMoreOptionsPressed: _showMoreOptions,
          onPhraseSelected: (String currentPhrase) {
            // 선택된 자주 쓰는 문구 저장
            setState(() {
              _selectedPhrase = currentPhrase;
            });

            // 자주 쓰는 문구 모달 닫기
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        title: const Text('Sell My Items'),
        actions: [TextButton(onPressed: () {}, child: const Text('Save'))],
        surfaceTintColor: Colors.transparent,
        shape: Border(bottom: BorderSide(color: AppColors.black12)),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),

                // 사진 추가 버튼 - ImagePicker와 연결할 예정
                ImageSelector(),
                const SizedBox(height: 40.0),

                // 제목 입력 필드
                Text(
                  'Title',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                PostTitleField(controller: _titleController),
                const SizedBox(height: 40.0),

                // 본문 입력 필드
                Text(
                  'Content',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                PostContentField(
                  controller: _contentController,
                  selectedPhrase: _selectedPhrase,
                  onPhraseAdded: () {
                    setState(() {
                      _selectedPhrase = null; // 문구 추가 후 리셋
                    });
                  },
                ),
                const SizedBox(height: 10.0),

                // 자주 쓰는 문구 버튼
                CustomButton(
                  text: 'My Go-To Phrases',
                  onTap: _showGoToPhrases,
                  width: 160.0,
                  height: 40.0,
                ),
                const SizedBox(height: 40.0),

                // 가격 / 판매 방법 선택
                Text(
                  'Price',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                TradeTypeSelector(
                  onSelected: (type) {
                    setState(() {
                      _selectedTransactionType = type;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                PriceField(
                  controller: _priceController,
                  isForSale: _selectedTransactionType == TradeType.sell,
                ),
                const SizedBox(height: 40.0),

                // 거래 희망 장소 선택
                Text(
                  'Meeting Point',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                MeetingPointSelector(
                  onAddressSelected: (detailAddress) {
                    setState(() {
                      _detailAddress = detailAddress;
                    });
                  },
                ),

                const SizedBox(height: kBottomNavigationBarHeight * 2),
              ],
            ),
          ),
        ),
      ),

      bottomSheet: Container(
        padding: const EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
        color: AppColors.white,
        child: CustomButton(
          text: 'Complete',
          onTap: () {
            if (_formKey.currentState!.validate()) {
              debugPrint('폼 검증 성공! 데이터 저장 진행');
              debugPrint(
                'Complete: ${_titleController.text} | ${_contentController.text} | ${_selectedTransactionType.name} | ${_priceController.text} | ${_detailAddress ?? 'No address selected'}',
              );

              final price = int.parse(
                _priceController.text.replaceAll(RegExp(r'[^0-9]'), ''),
              );

              final postDraft = PostDraft(
                title: _titleController.text,
                content: _contentController.text,
                tradeType: _selectedTransactionType,
                price: price,
                images: [],
              );

              final imageUrls = postDraft.images
                  .map((image) => image.path)
                  .toList();
              if (imageUrls.isEmpty) {
                imageUrls.add(
                  'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                );
              }

              final post = Post(
                id: postDraft.hashCode.toString(),
                title: postDraft.title,
                content: postDraft.content,
                imageUrls: imageUrls,
                price: postDraft.price,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                tradeType: postDraft.tradeType,
              );

              dummyPosts.add(post);

              Navigator.of(context).pop(true);
            } else {
              debugPrint('폼 검증 실패');
            }
          },
          height: 50.0,
        ),
      ),
    );
  }
}
