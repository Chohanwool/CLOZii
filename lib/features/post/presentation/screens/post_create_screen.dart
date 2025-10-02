// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/image_preview.dart';

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
import 'package:clozii/features/post/provider/selected_image_provider.dart';

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
    // 선택된 사진 ID 리스트
    final selectedImageIds = ref.watch(selectedImageProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // "저장하지 않은 내역은 사라집니다" 안내 추가 예정
            ref.read(selectedImageProvider.notifier).clearSelection();
            Navigator.pop(context);
          },
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

                // 사진 선택 섹션 (ImageSelector + 선택된 사진 미리보기)
                SizedBox(
                  height: 100.0,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedImageIds.length + 1,
                    itemBuilder: (context, index) {
                      // ImageSelector - 사진 선택 위젯
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ImageSelector(),
                        );
                      }

                      String assetId = selectedImageIds.keys.elementAt(
                        index - 1,
                      );

                      return ImagePreviews(assetId: assetId);
                    },
                  ),
                ),

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

          // 게시글 생성 완료 버튼
          // TODO: DB와 연동되는 게시글 생성 로직 구현 필요
          // 임시로 폼 검증 성공 시 더미 데이터에 새로운 게시글 저장 진행
          onTap: () {
            if (_formKey.currentState!.validate()) {
              debugPrint('폼 검증 성공! 데이터 저장 진행');
              debugPrint(
                'Complete: ${_titleController.text} | ${_contentController.text} | ${_selectedTransactionType.name} | ${_priceController.text} | ${_detailAddress ?? 'No address selected'}',
              );

              final price = int.parse(
                _priceController.text.replaceAll(RegExp(r'[^0-9]'), ''),
              );

              // TODO: 리포지토리에서 DB/서버 API에 게시글 저장 필요
              // 구현 예시는 파일 하단에 주석으로 작성되어 있음
              final postDraft = PostDraft(
                title: _titleController.text,
                content: _contentController.text,
                tradeType: _selectedTransactionType,
                price: price,
                images: [],
              );

              // 실무에서는 PostDraft에 XFile 형식 이미지 리스트를 그대로 넣고
              // 실제 저장 시 이미지를 서버에 없로드 후 URL로 변환하는 방식을 사용함
              // 구현 예시는 파일 하단에 주석으로 작성되어 있음
              final imageUrls = postDraft.images
                  .map((image) => image.path)
                  .toList();
              if (imageUrls.isEmpty) {
                imageUrls.add(
                  'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                );
              }

              // createPost()에서 생성된 게시글을 반환할때 Post 객체로 만들어서 반환 할 예정
              // 그렇게 하면 화면에도 생성된 게시글을 바로 보여줄 수 있고, 캐싱에도 쓸수 있고, 다른 메서드들에서도 생성된 게시글이 바로 필요할 떄 넣어줄 수 있음.
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
              // TODO: 폼 검증 실패 시 에러 처리 필요
              debugPrint('폼 검증 실패');
            }
          },
          height: 50.0,
        ),
      ),
    );
  }
}

// 구현 예시 : PostDraft 를 리포지토리에서 받아 실제 Firebase에 저장하는 로직

  // Future<Post> createPost(PostDraft draft) async {
  //   // 1. 이미지 업로드 후 URL 리스트 생성
  //   final imageUrls = await _uploadImages(draft.images);
  //
  //   // 2. Firestore에 게시글 저장
  //   final docRef = await FirebaseFirestore.instance.collection('posts').add({
  //     'title': draft.title,
  //     'content': draft.content,
  //     'price': draft.price,
  //     'tradeType': draft.tradeType.name,
  //     'imageUrls': imageUrls, // 업로드한 이미지 URL 저장
  //     'createdAt': FieldValue.serverTimestamp(),
  //     'updatedAt': FieldValue.serverTimestamp(),
  //   });
  //
  //   // 3. 저장된 데이터 가져오기
  //   final snapshot = await docRef.get();
  //
  //   // 4. Post 객체 반환
  //   return Post.fromJson(snapshot.data()!..['id'] = docRef.id);
  // }

// _uploadImages 구현 예시 :

  // Future<List<String>> _uploadImages(List<XFile> images) async {
  //   List<String> urls = [];
  //
  //   for (var image in images) {
  //     final fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     final ref = FirebaseStorage.instance.ref().child('post_images/$fileName'); // Firebase Storage 루트 디렉토리에 이미지가 저장될 경로를 지정 (아직 이미지 파일 없음)
  //
  //     // 업로드
  //     await ref.putFile(File(image.path)); // 이 부분이 실제로 파일을 업로드하는 부분!
  //
  //     // 다운로드 URL 획득
  //     final url = await ref.getDownloadURL(); // 업로드한 이미지의 다운로드 URL 획득
  //     urls.add(url);
  //   }
  //
  //   // 이미지 URL 리스트 반환
  //   return urls;
  // }