// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PriceField extends ConsumerStatefulWidget {
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
  ConsumerState<PriceField> createState() => _PriceFieldState();
}

class _PriceFieldState extends ConsumerState<PriceField> {
  final priceFormatter = NumberFormat('#,###');

  // 가격 입력 필드 채워져 있는지 여부
  bool _isFilled = true;

  @override
  void initState() {
    super.initState();

    widget.controller.text = priceFormatter.format(
      int.tryParse(widget.controller.text) ?? 0,
    );
  }

  // 거래방식이 나눔인 경우, 가격 = 0으로 초기화
  @override
  void didUpdateWidget(covariant PriceField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 거래방식이 실제로 변경되었을 때만 값 초기화
    if (oldWidget.isForSale != widget.isForSale) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.isForSale == false) {
          setState(() {
            widget.controller.text = '0';
            _isFilled = true; // 가격 필드가 0으로 채워져 있으므로, isFilled = true
          });
        } else {
          setState(() {
            widget.controller.clear();
            _isFilled = false;
          });
        }
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

        // 숫자만 남기기
        final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
        if (int.tryParse(cleanValue) == null) {
          return 'Please enter a valid price.';
        }

        if (int.parse(cleanValue) < 0) {
          return "Price cannot be negative.";
        }

        if (widget.isForSale && int.parse(cleanValue) == 0) {
          return 'Please set a price. If you want to give it away, select "For Share".';
        }

        return null;
      },

      onChanged: (value) {
        // 가격 저장 - 입력 값에 숫자 이외의 문자가 있으면 제거하고 숫자로 변환
        final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
        final price = int.tryParse(cleanValue) ?? 0;
        ref.read(postCreateProvider.notifier).setPrice(price);

        // 가격 필드가 채워져 있는지 여부 업데이트
        _isFilled = value.isNotEmpty;

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

  /// TextField의 기본 글자수 카운터 숨기기
  Widget? _hideCounter(
    BuildContext context, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  }) {
    return null;
  }
}
