// core
import 'package:clozii/core/constants/app_constants.dart';

// packages
import 'package:flutter/material.dart';

class PostContentField extends StatefulWidget {
  const PostContentField({
    super.key,
    required this.controller,
    required this.selectedPhrase,
    this.onPhraseAdded,
  });

  final TextEditingController controller;
  final String? selectedPhrase;
  final VoidCallback? onPhraseAdded;

  @override
  State<PostContentField> createState() => _PostContentFieldState();
}

class _PostContentFieldState extends State<PostContentField> {
  @override
  void didUpdateWidget(PostContentField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 선택된 문구가 null이 아니고 이전 문구와 다르면
    if (widget.selectedPhrase != null &&
        widget.selectedPhrase != oldWidget.selectedPhrase) {
      // build()나 didUpdateWidget() 같은 빌드 중에 setState()를 호출하면 에러 발생 함
      // addPostFrameCallback는 빌드가 모두 끝난 이후에 setState를 안전하게 호출할 수 있게 해줌
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 텍스트가 비어있지 않고, 마지막으로 입력된게 줄바꿈이 아니면, '\n' 추가
        if (widget.controller.text.isNotEmpty &&
            !widget.controller.text.endsWith('\n')) {
          // 자주 쓰는 문구 추가 시, 현재 내용에서 줄바꿈 한 뒤 추가
          // 단, 마지막으로 입력된게 줄바꿈이면 추가하지 않음
          widget.controller.text += '\n';
        }

        // 선택된 문구 추가
        widget.controller.text += widget.selectedPhrase!;
        // 문구가 추가된 이후, selectedPhrase를 null로 리셋 시키는 함수 호출
        widget.onPhraseAdded?.call();
      });
    }
  }

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

        // 여러 줄 입력에 최적화된 키보드 타입
        // 엔터키(줄바꿈)가 "완료" 대신 "줄바꿈"으로 동작
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          isDense: true,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),

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
