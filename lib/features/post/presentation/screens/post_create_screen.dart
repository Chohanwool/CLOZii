// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/post/presentation/provider/go_to_phrases_provider.dart';

// features
import 'package:clozii/features/post/presentation/provider/post_create_provider.dart';
import 'package:clozii/features/post/presentation/states/post_create_state.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/forms/post_create_form.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/add_phrase_modal.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/go_to_phrase_modal.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/more_options_modal.dart';

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
  @override
  Widget build(BuildContext context) {
    final postCreateNotifier = ref.read(postCreateProvider.notifier);

    // showGoToPhrases 감지 - 자주 쓰는 문구 모달 표시
    ref.listen<PostCreateState>(postCreateProvider, (previous, next) {
      if (previous?.showGoToPhrases != next.showGoToPhrases &&
          next.showGoToPhrases) {
        _showGoToPhrasesModal();
      }
    });

    // showAddPhraseModal 감지 - 문구 추가 모달 표시
    ref.listen<PostCreateState>(postCreateProvider, (previous, next) {
      if (previous?.showAddPhraseModal != next.showAddPhraseModal &&
          next.showAddPhraseModal) {
        _showAddPhraseModal(next.currentPhraseForEdit);
      }
    });

    // showMoreOptions 감지 - 더보기 옵션 모달 표시
    ref.listen<PostCreateState>(postCreateProvider, (previous, next) {
      if (previous?.showMoreOptions != next.showMoreOptions &&
          next.showMoreOptions) {
        _showMoreOptionsModal(next.currentPhraseForEdit!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // "저장하지 않은 내역은 사라집니다" 안내 추가 예정
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
          child: Form(key: postCreateNotifier.formKey, child: PostCreateForm()),
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
            debugPrint('게시글 생성 완료 버튼 클릭됨');
            Navigator.of(context).pop();
          },
          height: 50.0,
        ),
      ),
    );
  }

  // 자주 쓰는 문구 모달 표시
  void _showGoToPhrasesModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        height: 400.0,
        child: GoToPhraseModal(
          onAddButtonPressed: (currentPhrase) {
            // currentPhrase는 GoToPhraseModal에서 null로 전달됨 (새 문구 추가)
            ref
                .read(postCreateProvider.notifier)
                .showAddPhraseModal(currentPhrase);
          },
          onMoreOptionsPressed: (currentPhrase) {
            ref
                .read(postCreateProvider.notifier)
                .showMoreOptions(currentPhrase);
          },
          onPhraseSelected: (String selectedPhrase) {
            // 선택된 자주 쓰는 문구 저장
            ref
                .read(goToPhrasesProvider.notifier)
                .setSelectedPhrase(selectedPhrase);
            // 자주 쓰는 문구 모달 닫기
            ref.read(postCreateProvider.notifier).hideGoToPhrases();
            Navigator.of(context).pop();
          },
        ),
      ),
    ).then((_) {
      // 모달이 닫힐 때 상태 초기화
      ref.read(postCreateProvider.notifier).hideGoToPhrases();
    });
  }

  // 문구 추가 모달 표시
  void _showAddPhraseModal(String? currentPhrase) async {
    // AddPhraseModal 표시 전 GoToPhrasesModal 제거
    Navigator.of(context).pop();

    final newPhrase = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => Container(
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
      } else {
        ref.read(goToPhrasesProvider.notifier).addPhrase(newPhrase);
      }
    }

    // 모달 상태 초기화
    ref.read(postCreateProvider.notifier).hideAddPhraseModal();

    // AddPhraseModal 제거 후 다시 GoToPhrasesModal 표시
    ref.read(postCreateProvider.notifier).showGoToPhrases();
  }

  // 더보기 옵션 모달 표시
  void _showMoreOptionsModal(String currentPhrase) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => MoreOptionsModal(
        currentPhrase: currentPhrase,
        onEditButtonPressed: (currentPhrase) {
          // MoreOptionsModal을 닫고 AddPhraseModal을 열기
          ref
              .read(postCreateProvider.notifier)
              .showAddPhraseModal(currentPhrase);
        },
      ),
    ).then((_) {
      // 모달이 닫힐 때 상태 초기화
      ref.read(postCreateProvider.notifier).hideMoreOptions();
    });
  }
}
