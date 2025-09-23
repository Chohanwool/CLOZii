import 'package:clozii/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceField extends StatefulWidget {
  const PriceField({super.key, required this.controller});

  // 컨트롤러
  final TextEditingController controller;

  @override
  State<PriceField> createState() => _PriceFieldState();
}

class _PriceFieldState extends State<PriceField> {
  final priceFormatter = NumberFormat('#,###');

  // 가격 입력 필드 채워져 있는지 여부
  bool _isFilled = false;

  /// TextField의 기본 글자수 카운터 숨기기
  Widget? _hideCounter(
    BuildContext context, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  }) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please set a price.';
        }

        if (int.tryParse(value) == null) {
          return 'Please enter a valid price.';
        }

        return null;
      },

      onChanged: (value) {
        setState(() {
          _isFilled = value.isNotEmpty;
        });

        if (value.isEmpty) return;
        widget.controller.text = priceFormatter.format(int.parse(value));
      },

      maxLength: 9,
      buildCounter: _hideCounter,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        isDense: true,

        prefixText: _isFilled ? '₱ ' : '',
        prefixStyle: const TextStyle(
          /// 필드 활성화 시 - 숫자색 검정 / 필드 비활성화 시 - 숫자색 회색
          fontSize: 16,
          color: AppColors.black,
        ),

        hintText: _isFilled ? '' : '₱ Please set a price.',
        hintStyle: TextStyle(color: AppColors.gray300, fontSize: 16),

        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),
      ),
    );
  }
}
