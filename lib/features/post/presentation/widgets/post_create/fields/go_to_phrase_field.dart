// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// packages
import 'package:flutter/material.dart';

class GoToPhraseField extends StatefulWidget {
  const GoToPhraseField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<GoToPhraseField> createState() => _GoToPhraseFieldState();
}

class _GoToPhraseFieldState extends State<GoToPhraseField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 게시글 내용 입력 필드 높이 설정
      height: 200,
      child: TextField(
        controller: widget.controller,

        // 텍스트가 위쪽에 붙어서 시작되도록 설정
        textAlignVertical: TextAlignVertical.top,

        maxLength: 300, // 최대 300자 제한
        maxLines: null, // 무제한 줄 수 허용 (여러 줄 입력 가능) - expands: true 설정 시 필요
        expands: true, // 부모 위젯의 높이에 맞춰 확장
        // 자동 완성, 제안, 대문자 자동 변환 비활성화
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,

        // 글자수 카운터
        buildCounter:
            (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) {
              return Text('$currentLength/$maxLength');
            },

        // 여러 줄 입력에 최적화된 키보드 타입
        // 엔터키(줄바꿈)가 "완료" 대신 "줄바꿈"으로 동작
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          isDense: true,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),

          label: Text('Content', style: context.textTheme.titleLarge),
          floatingLabelBehavior: FloatingLabelBehavior.always,

          hintText:
              'Enter your most used phrases. \nex. \n- Discount available for quick deals. \n- Barely used. \n- No issues with functionality. \n- Contact me for more details.',
          hintStyle: const TextStyle(color: AppColors.gray300, fontSize: 16),

          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black54),
          ),
        ),
      ),
    );
  }
}
