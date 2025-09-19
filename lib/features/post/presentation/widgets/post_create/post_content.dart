// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// packages
import 'package:flutter/material.dart';

class PostContentField extends StatefulWidget {
  const PostContentField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<PostContentField> createState() => _PostContentFieldState();
}

class _PostContentFieldState extends State<PostContentField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 게시글 내용 입력 필드 높이 설정
      height: 200,
      child: TextFormField(
        controller: widget.controller,

        // 텍스트가 위쪽에 붙어서 시작되도록 설정
        textAlignVertical: TextAlignVertical.top,

        maxLength: 500, // 최대 500자 제한
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

        // 유효성 검사
        validator: (value) {
          // 1. 빈 값 체크
          if (value == null || value.trim().isEmpty) {
            return 'Please enter content';
          }

          // 2. 최대 길이 제한
          if (value.length > 500) {
            return 'Content cannot exceed 500 characters';
          }

          // 3. 비속어/부적절 단어 필터링
          const blockedWords = [
            'admin',
            'fuck',
            'shit',
            'bitch',
            'putang',
            'putangina',
            'bobo',
            'tarantado',
            'gago',
            'tanga',
            'ulol',
          ];
          final nameLower = value.toLowerCase();
          if (blockedWords.any((badWord) => nameLower.contains(badWord))) {
            return 'Oops! Try something a bit more friendly.';
          }
          return null;
        },
        onChanged: (value) {},

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

          hintText: 'Post Content',
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
