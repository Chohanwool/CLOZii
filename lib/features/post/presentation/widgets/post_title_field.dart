// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostTitleField extends StatefulWidget {
  const PostTitleField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<PostTitleField> createState() => _PostTitleFieldState();
}

class _PostTitleFieldState extends State<PostTitleField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      // 자동 완성, 제안, 대문자 자동 변환 비활성화
      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,

      // 유효성 검사
      validator: (value) {
        // 1. 빈 값 체크
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a title';
        }

        // 2. 최대 길이 제한
        if (value.length > 50) {
          return 'Title cannot exceed 50 characters';
        }

        // 3. 허용 문자 체크 (영문/숫자/특수문자)
        if (RegExp(
          r'[^a-zA-Z0-9\s!@#$%^&*()_+\-=\[\]{}|;:,.<>?]',
        ).hasMatch(value)) {
          return 'Use only letters, numbers, or special characters';
        }

        // 4. 비속어/부적절 단어 필터링
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
      keyboardType: TextInputType.text,

      // 영문자, 숫자, 특수문자만 허용
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9\s!@#$%^&*()_+\-=\[\]{}|;:,.<>?]'),
        ),
      ],
      decoration: InputDecoration(
        isDense: true,

        label: Text('Title', style: context.textTheme.titleLarge),
        floatingLabelBehavior: FloatingLabelBehavior.always,

        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),

        // 제목 입력 필드 초기화(지움) 버튼
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

        hintText: 'Post title',
        hintStyle: const TextStyle(color: AppColors.gray300, fontSize: 16),

        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),
      ),
    );
  }
}
