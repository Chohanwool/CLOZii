// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/post/data/dummy_go_to_phrases.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/add_phrase_modal.dart';

// features
import 'package:clozii/features/post/presentation/widgets/post_create/image_selector.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/post_content.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/post_title_field.dart';

// packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  // 컨트롤러
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // 자주 쓰는 문구 리스트
  final _goToPhrases = dummyGoToPhrases;

  // 선택된 자주 쓰는 문구
  String? _selectedPhrase;

  // 자주 쓰는 문구 리스트가 비어있는지 여부
  bool get _isGoToPhrasesEmpty => _goToPhrases.isEmpty;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // 자주 쓰는 문구 추가 모달 열기
  void _showAddPhraseModal(String? currentPhrase) async {
    // 자주 쓰는 문구 모달 닫기
    Navigator.of(context).pop();

    // 추가한 자주 쓰는 문구 받아오기
    final phrase = await showModalBottomSheet(
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

    if (phrase != null) {
      int index = -1;

      if (currentPhrase != null) {
        index = _goToPhrases.indexOf(currentPhrase);
        _goToPhrases.remove(currentPhrase);
      }

      setState(() {
        if (index != -1) {
          _goToPhrases.insert(index, phrase);
        } else {
          _goToPhrases.add(phrase);
        }
      });
    }

    // 자주 쓰는 문구 추가 후 모달 다시 열기 - 새로고침
    _showGoToPhrases();
  }

  void _showMoreOptions(String currentPhrase) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              '수정',
              style: context.textTheme.titleLarge!.copyWith(
                color: AppColors.info,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              // 수정 로직
              _showAddPhraseModal(currentPhrase);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              '삭제',
              style: context.textTheme.titleLarge!.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              // 삭제 로직
              setState(() {
                _goToPhrases.remove(currentPhrase);
              });
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            '취소',
            style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.warning,
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
        child: Column(
          children: [
            // Drag Handle
            Divider(
              thickness: 4.0,
              color: AppColors.black12,
              indent: 150.0,
              endIndent: 150.0,
            ),

            // 자주 쓰는 문구 타이틀 / 추가 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Go-To Phrases', style: context.textTheme.titleLarge),

                // 추가 버튼
                TextButton(
                  onPressed: () => _showAddPhraseModal(null),
                  style: TextButton.styleFrom(
                    iconSize: 26.0,
                    textStyle: context.textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  child: const Row(children: [Icon(Icons.add), Text('Add')]),
                ),
              ],
            ),

            const SizedBox(height: 10.0),
            const Divider(),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isGoToPhrasesEmpty
                      ? Center(
                          child: Text(
                            'Try adding some go-to phrases.',
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors.black54,
                            ),
                          ),
                        )
                      // 자주 쓰는 문구 - ListTile
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _goToPhrases.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,

                                    title: Text(_goToPhrases[index]),
                                    onTap: () {
                                      // 선택된 자주 쓰는 문구 저장
                                      setState(() {
                                        _selectedPhrase = _goToPhrases[index];
                                      });

                                      // 자주 쓰는 문구 모달 닫기
                                      Navigator.of(context).pop();
                                    },

                                    // 더보기 버튼
                                    trailing: IconButton(
                                      onPressed: () =>
                                          _showMoreOptions(_goToPhrases[index]),
                                      icon: Icon(Icons.more_vert),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ],
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),

              // 사진 추가 버튼 - ImagePicker와 연결할 예정
              ImageSelector(),
              const SizedBox(height: 40.0),

              // 제목 입력 필드
              PostTitleField(controller: _titleController),
              const SizedBox(height: 40.0),

              // 본문 입력 필드
              PostContentField(
                controller: _contentController,
                selectedPhrase: _selectedPhrase,
                onPhraseAdded: () {
                  setState(() {
                    _selectedPhrase = null; // 문구 추가 후 리셋
                  });
                },
              ),

              // 자주 쓰는 문구 버튼
              CustomButton(
                text: 'My Go-To Phrases',
                onTap: _showGoToPhrases,
                width: 160.0,
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
