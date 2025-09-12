import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.label = 'Date of Birth',
    this.hintText = 'MM/DD/YYYY',
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<DateTime?>? onChanged;
  final String label;
  final String hintText;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('en', 'US'), // MM/DD/YYYY 형식 강제
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: context.colors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
              // 달력 배경을 완전히 흰색으로 설정
              surfaceContainerHighest: Colors.white,
              surfaceContainerHigh: Colors.white,
              surfaceContainer: Colors.white,
              surfaceContainerLow: Colors.white,
              surfaceContainerLowest: Colors.white,
              surfaceTint: Colors.transparent,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // MM/DD/YYYY 형식으로 텍스트 설정
        widget.controller.text = DateFormat('MM/dd/yyyy').format(picked);
      });

      widget.onChanged?.call(picked);
    }
  }

  void _clearDate() {
    setState(() {
      _selectedDate = null;
      widget.controller.clear();
    });
    widget.onChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      readOnly: true, // 직접 입력 방지
      onTap: _selectDate,
      decoration: InputDecoration(
        isDense: true,

        label: Text(widget.label, style: context.textTheme.labelLarge),
        floatingLabelBehavior: FloatingLabelBehavior.always,

        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),

        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                style: IconButton.styleFrom(overlayColor: Colors.transparent),
                onPressed: _clearDate,
                icon: const Icon(Icons.cancel, color: Colors.grey),
              )
            : const Icon(Icons.calendar_today, color: Colors.grey),

        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
      ),
    );
  }
}
