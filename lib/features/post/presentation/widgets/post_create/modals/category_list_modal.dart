import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListModal extends ConsumerWidget {
  const CategoryListModal({super.key, required this.onSelected});

  final ValueChanged<PostCategory> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(false),
          icon: const Icon(Icons.close),
        ),
        title: const Text('Category'),
        centerTitle: true,
        shape: const Border(bottom: BorderSide(color: AppColors.black12)),
        surfaceTintColor: AppColors.background,
      ),
      body: ListView.separated(
        itemCount: PostCategory.values.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: AppColors.black12,
        ),
        itemBuilder: (context, index) {
          final currentCategory = PostCategory.values[index];

          return ListTile(
            title: Text(
              currentCategory.displayName,
              style: context.textTheme.bodyMedium!
                  .copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              onSelected(currentCategory);
              Navigator.of(context).pop(true);
            },
          );
        },
      ),
    );
  }
}
