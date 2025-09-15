import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameField extends StatefulWidget {
  const NameField({
    super.key,
    required this.focusNode,
    required this.controller,
  });

  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        // 1. 빈 값 체크
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a name to continue.';
        }

        // 2. 첫 글자가 영문자인지 체크
        if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
          return 'Please start your name with a letter.';
        }

        // 3. 최소 길이 체크
        if (value.trim().length < 3) {
          return 'Your name should be at least 3 characters.';
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

        // 5. 허용 문자 체크 (영문/숫자/언더스코어)
        if (RegExp(r'[^a-zA-Z0-9_]').hasMatch(value)) {
          return 'Use only letters, numbers, or underscores.';
        }

        // 6. 이모지 입력 방지
        if (RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true).hasMatch(value)) {
          return 'Emojis are fun, but let\'s keep them out of your name.';
        }

        // 7. 연속 언더스코어 제한
        if (RegExp(r'[_]{2,}').hasMatch(value)) {
          return 'Avoid using too many underscores in a row.';
        }

        // 8. 최대 길이 제한
        if (value.trim().length > 20) {
          return 'That\'s a bit long — keep it under 20 characters.';
        }

        // TODO: 닉네임 중복 검증
        // final isDuplicate = await nicknameExistsInServer(value);
        // if (isDuplicate) return 'That name is already taken.';

        return null;
      },
      onChanged: (value) {},
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9_]'), // 영문자, 숫자, 언더스코어만 허용
        ),
      ],
      decoration: InputDecoration(
        isDense: true,

        label: Text('Name', style: context.textTheme.labelLarge),
        floatingLabelBehavior: FloatingLabelBehavior.always,

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

        hintText: 'Your name or nickname (ex: abc_123)',
        hintStyle: TextStyle(color: Colors.grey),

        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
      ),
    );
  }
}
