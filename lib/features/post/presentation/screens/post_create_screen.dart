import 'package:clozii/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: const Center(child: Text('Post Create Screen')),
        ),
      ),
    );
  }
}
