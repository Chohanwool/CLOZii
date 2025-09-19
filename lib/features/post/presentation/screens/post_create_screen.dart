// core
import 'package:clozii/core/constants/app_constants.dart';

// features
import 'package:clozii/features/post/presentation/widgets/image_selector.dart';
import 'package:clozii/features/post/presentation/widgets/post_content.dart';
import 'package:clozii/features/post/presentation/widgets/post_title_field.dart';

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

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
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
            ],
          ),
        ),
      ),
    );
  }
}
