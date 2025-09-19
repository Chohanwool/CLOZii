// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';

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

  // 자주 쓰는 문구 비어있는지 여부
  bool _isGoToPhrasesEmpty = true;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

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
                TextButton(
                  onPressed: () {},
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
                      : Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,

                                    title: Text(
                                      'Go-to Phrase $index',
                                      style: context.textTheme.bodyLarge,
                                    ),

                                    trailing: IconButton(
                                      onPressed: () {},
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
              PostContentField(controller: _contentController),

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
