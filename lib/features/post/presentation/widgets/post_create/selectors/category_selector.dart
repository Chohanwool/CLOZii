import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  PostCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        debugPrint('category modal pop-up');
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
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

        helper: _selectedCategory != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check, color: AppColors.success, size: 18.0),
                  const SizedBox(width: 8.0),
                  Expanded(child: Text(_selectedCategory!.name)),
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
