import 'package:flutter/material.dart';

// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

class GenderDropdownField extends StatelessWidget {
  final FocusNode focusNode;
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderDropdownField({
    super.key,
    required this.focusNode,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusNode: focusNode,
      value: selectedGender,
      hint: Text(
        'Select Gender',
        style: context.textTheme.bodyLarge!.copyWith(color: Colors.grey),
      ),
      validator: (value) {
        // 값이 비어있거나 제공된 옵션 목록에 없는 경우 에러
        if (value == null || !['M', 'F', 'N'].contains(value)) {
          return 'Please select gender from provided options!';
        }

        return null;
      },
      onChanged: onChanged,
      items: [
        ...{'Male': 'M', 'Female': 'F', 'Prefer not to say': 'N'}.entries.map(
          (entry) => DropdownMenuItem(
            value: entry.value,
            child: Text(entry.key, style: context.textTheme.bodyLarge),
          ),
        ),
      ],
      decoration: InputDecoration(
        isDense: true,
        label: Text('Gender', style: context.textTheme.labelLarge),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),
      ),
    );
  }
}
