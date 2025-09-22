import 'package:clozii/core/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeyboardAwareButton extends StatelessWidget {
  const KeyboardAwareButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height,
    this.width,
  });

  final String text;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        Widget? button = CustomButton(
          text: text,
          onTap: onTap,
          height: height ?? 50.0, // 높이가 지정되지 않으면 50.0으로 설정
          width: width ?? double.infinity, // 너비가 지정되지 않으면 double.infinity으로 설정
          isKeyboardVisible: isKeyboardVisible,
        );

        return Material(
          child: Container(
            padding: !isKeyboardVisible
                ? EdgeInsets.symmetric(horizontal: 16.0)
                : null,
            color: Colors.transparent,
            child: button,
          ),
        );
      },
    );
  }
}
