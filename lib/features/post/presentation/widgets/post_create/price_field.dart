import 'package:clozii/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceField extends StatefulWidget {
  const PriceField({
    super.key,
    required this.controller,
    required this.isForSale,
  });

  // 컨트롤러
  final TextEditingController controller;

  // 판매인지, 나눔인지 여부
  final bool isForSale;

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

  // 거래방식이 나눔인 경우, 가격 = 0으로 초기화
  @override
  void didUpdateWidget(covariant PriceField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isForSale == false) {
      setState(() {
        widget.controller.text = '0';
        _isFilled = true; // 가격 필드가 0으로 채워져 있으므로, isFilled = true
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.isForSale, // 거래방식이 나눔인 경우, 가격 필드 비활성화

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

        // 판매인 경우, 필드 배경색 흰색
        // 나눔인 경우, 필드 배경색 회색
        filled: true,
        fillColor: widget.isForSale ? AppColors.white : AppColors.disabled,

        prefixText: _isFilled ? '₱ ' : '',
        prefixStyle: TextStyle(
          fontSize: 16,
          color: widget.isForSale
              ? AppColors
                    .textPrimary // 판매인 경우, 화폐 기호 색 검정
              : AppColors.disabledText, // 나눔인 경우, 화폐 기호 색 회색
        ),

        hintText: _isFilled ? '' : '₱ Please set a price.',
        hintStyle: TextStyle(color: AppColors.gray300, fontSize: 16),

        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),

        // 나눔인 경우, 필드 테두리 색 회색
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
      ),
    );
  }
}
