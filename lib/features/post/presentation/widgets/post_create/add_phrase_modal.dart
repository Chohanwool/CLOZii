import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/widgets/keyboard_aware_button.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/go_to_phrase_field.dart';
import 'package:flutter/material.dart';

class AddPhraseModal extends StatefulWidget {
  const AddPhraseModal({super.key});

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
        onTap: _controller.text.trim().isEmpty ? null : () {},
      ),

      bottomNavigationBar: Container(height: kToolbarHeight),
    );
  }
}
