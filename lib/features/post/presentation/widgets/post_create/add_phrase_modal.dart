import 'package:flutter/material.dart';

class AddPhraseModal extends StatelessWidget {
  const AddPhraseModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('Add Go-To Phrase'),
      ),
    );
  }
}
