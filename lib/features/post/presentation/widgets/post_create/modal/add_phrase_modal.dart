// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/widgets/keyboard_aware_button.dart';

// features
import 'package:clozii/features/post/presentation/widgets/post_create/go_to_phrase_field.dart';

// packages
import 'package:flutter/material.dart';

class AddPhraseModal extends StatefulWidget {
  const AddPhraseModal({super.key, this.phrase});

  // 이전에 입력된 문구
  // 자주 쓰는 문구 추가하는 경우 -> phrase == null
  // 자주 쓰는 문구 수정하는 경우 -> phrase != null
  final String? phrase;

  @override
  State<AddPhraseModal> createState() => _AddPhraseModalState();
}

class _AddPhraseModalState extends State<AddPhraseModal> {
  // 컨트롤러
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));

    if (widget.phrase != null) {
      _controller.text = widget.phrase!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('Add Go-To Phrase'),
        shape: Border(bottom: BorderSide(color: AppColors.black12)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            GoToPhraseField(controller: _controller),
          ],
        ),
      ),

      bottomSheet: KeyboardAwareButton(
        text: 'Add',
        onTap: _controller.text.trim().isEmpty
            ? null
            : () => Navigator.of(
                context,
              ).pop(_controller.text.trim()), // 입력된 문구를 모달 밖으로 반환
      ),

      bottomNavigationBar: Container(height: kToolbarHeight),
    );
  }
}
