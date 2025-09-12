import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';

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
        if (value != null &&
            !['Male', 'Female', 'Prefer not to say'].contains(value)) {
          return 'Please select gender from provided options!';
        }

        return null;
      },
      onChanged: onChanged,
      items: [
        ...['Male', 'Female', 'Prefer not to say'].map(
          (g) => DropdownMenuItem(
            value: g,
            child: Text(g, style: context.textTheme.bodyLarge),
          ),
        ),
      ],
      decoration: InputDecoration(
        isDense: true,
        label: Text('Gender', style: context.textTheme.labelLarge),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
      ),
    );
  }
}
