import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // 전화번호 입력 포맷팅에 필요한 패키지

/// 전화번호 입력 필드 위젯
/// - 기본적으로 읽기 전용(readOnly) 상태로 시작
///   - 탭하면 입력 가능 상태로 전환
///   - 외부를 탭하면 다시 읽기 전용으로 전환
/// - 전화번호 입력 시 '09' 프리픽스 자동 추가
/// - 하이픈(-) 자동 포맷 적용
class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  /// 전화번호 포맷 (예: 09##-###-###)
  /// - '#' 자리에 숫자만 입력 가능
  /// - MaskAutoCompletionType.lazy → 입력한 숫자에 맞춰 자동으로 하이픈(-) 삽입
  final _phoneNumberFomatter = MaskTextInputFormatter(
    mask: '####-###-####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

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
      autofocus: true,
      focusNode: widget.focusNode,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Oops! Don\'t forget your phone number.';
        }

        // 하이픈 제거 후 순수 숫자
        final digits = value.replaceAll('-', '').replaceAll(' ', '');

        // 숫자만 확인
        if (int.tryParse(digits) == null) {
          return 'Only numbers allowed — no letters or symbols!';
        }

        // 길이 체크
        if (digits.length != 11) {
          return 'Phone number should have exactly 11 digits.';
        }

        // 시작 번호 체크
        if (!digits.startsWith('09')) {
          return 'Philippine phone numbers should start with "09".';
        }

        // +63 입력 방지
        if (value.startsWith('+63')) {
          return 'Please enter your number starting with "09", not "+63".';
        }

        // 공백 포함 방지
        if (value.contains(' ')) {
          return 'Please remove any spaces from your number.';
        }

        // TODO: 중복 체크
        // if (await isPhoneNumberRegistered(value)) {
        //   return 'This number is already registered.';
        // }

        return null;
      },
      maxLength: 13, // "09##-###-####" 형식 최대 길이
      buildCounter: _hideCounter, // 글자수 카운터 숨김
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 허용
        _phoneNumberFomatter, // 하이픈 자동 포맷 적용
      ],
      decoration: InputDecoration(
        isDense: true,

        label: Text('Phone number', style: context.textTheme.labelLarge),
        floatingLabelBehavior: FloatingLabelBehavior.always,

        prefixStyle: const TextStyle(
          /// 필드 활성화 시 - 숫자색 검정 / 필드 비활성화 시 - 숫자색 회색
          color: AppColors.black,
          fontSize: 16,
        ),

        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                style: IconButton.styleFrom(overlayColor: Colors.transparent),
                onPressed: () {
                  setState(() {
                    widget.controller.clear();
                  });
                },
                icon: Icon(Icons.cancel, color: context.colors.scrim),
              )
            : null,

        hintText: '0900-000-0000',
        hintStyle: const TextStyle(color: AppColors.gray300, fontSize: 16),

        border: OutlineInputBorder(),

        // 포커스 상태 필드 테두리 색 지정
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),
      ),
    );
  }
}
