import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// CustomTextLink
/// - 텍스트 안에 특정 부분(링크 텍스트)에만 클릭 이벤트를 줄 수 있는 커스텀 위젯
/// - 예: "이미 계정이 있나요? [로그인]" -> 로그인에만 터치 기능 부여
///
/// - prefixText(선택): 링크 앞에 올 일반 텍스트
/// - linkText(필수): 클릭 가능(링크처럼 보이는) 텍스트
/// - suffixText(선택): 링크 뒤에 올 일반 텍스트
/// - style: 일반 텍스트 스타일
/// - linkTextStyle: 링크 텍스트 스타일
/// - onTap: 링크 클릭 시 실행할 콜백
class CustomTextLink extends StatefulWidget {
  const CustomTextLink({
    super.key,
    required this.linkText, // 클릭 가능한 텍스트
    this.linkTextStyle, // 클릭 텍스트 스타일
    this.prefixText, // 앞에 붙는 일반 텍스트
    this.suffixText, // 뒤에 붙는 일반 텍스트
    this.style, // 일반 텍스트 스타일
    required this.onTap, // 클릭 시 실행할 함수
  });

  final String linkText;
  final TextStyle? linkTextStyle;
  final String? prefixText;
  final String? suffixText;
  final TextStyle? style;
  final VoidCallback onTap;

  @override
  State<CustomTextLink> createState() => _CustomTextLinkState();
}

class _CustomTextLinkState extends State<CustomTextLink> {
  // RichText의 TextSpan에서 onTap 이벤트를 처리하기 위해 사용
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    // recognizer를 초기화하고 onTap 콜백 연결
    _tapRecognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  void dispose() {
    // 메모리 누수 방지를 위해 recognizer 해제
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        // 링크 앞 텍스트 (null이면 표시 안 함)
        text: widget.prefixText,
        style: DefaultTextStyle.of(context).style.merge(widget.style),
        children: [
          // 클릭 가능한 링크 텍스트
          TextSpan(
            text: widget.linkText,
            style: DefaultTextStyle.of(
              context,
            ).style.merge(widget.linkTextStyle),
            recognizer: _tapRecognizer, // 여기서만 클릭 이벤트 활성화
          ),
          // 링크 뒤 텍스트 (null이면 표시 안 함)
          TextSpan(
            text: widget.suffixText,
            style: DefaultTextStyle.of(context).style.merge(widget.style),
          ),
        ],
      ),
    );
  }
}
