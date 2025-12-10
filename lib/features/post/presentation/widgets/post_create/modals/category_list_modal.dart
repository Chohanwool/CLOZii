import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListModal extends ConsumerWidget {
  const CategoryListModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('Category'),
        centerTitle: true,
        shape: const Border(bottom: BorderSide(color: AppColors.black12)),
      ),
      body: ListView.builder(
        itemCount: PostCategory.values.length,
        itemBuilder: (context, index) {
          final currentCategory = PostCategory.values[index];

          return ListTile(
            title: Text(
              currentCategory.name,
              style: context.textTheme.bodyMedium!
                  .copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              ref
                  .read(postCreateProvider.notifier)
                  .setCategory(currentCategory);
              debugPrint('selected category: ${currentCategory.name}');

              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
