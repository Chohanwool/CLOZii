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
    // required this.onChanged,
    required this.controller,
    required this.focusNode,
  });

  /// 입력값 변경 시 호출되는 콜백
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
    return TextField(
      autofocus: true,
      focusNode: widget.focusNode,
      controller: widget.controller,
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

        prefixStyle: TextStyle(
          /// 필드 활성화 시 - 숫자색 검정 / 필드 비활성화 시 - 숫자색 회색
          color: Colors.black,
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
        hintStyle: TextStyle(color: Colors.grey),

        border: OutlineInputBorder(),

        // 포커스 상태 필드 테두리 색 지정
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
      ),
    );
  }
}
