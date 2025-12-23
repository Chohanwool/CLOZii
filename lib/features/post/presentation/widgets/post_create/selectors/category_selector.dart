import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/category_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySelector extends ConsumerWidget {
  const CategorySelector({super.key});

  void _showCategoryList(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors.white,
      builder: (BuildContext context) => Container(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: CategoryListModal(
          onSelected: (value) {
            ref.read(postCreateProvider.notifier).setCategory(value);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(postCreateProvider).category;

    return TextFormField(
      readOnly: true,
      onTap: () => _showCategoryList(context, ref),
      validator: (value) {
        if (selectedCategory == null) {
          return 'Please select a category.';
        }

        return null;
      },
      decoration: InputDecoration(
        isDense: true,

        hint: const Row(
          children: [
            Text('Select Category'),
            Icon(Icons.chevron_right),
            Spacer(),
          ],
        ),

        helper: selectedCategory != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check, color: AppColors.success, size: 18.0),
                  const SizedBox(width: 8.0),
                  Expanded(child: Text(selectedCategory.displayName)),
                ],
              )
            : null,

        // 필드 활성화 시 테두리 색 지정 - 사실상 기본 테두리 색
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),

        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
