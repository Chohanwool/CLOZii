import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';

/// CustomButton
/// 재사용 가능한 커스텀 버튼 위젯
/// - 텍스트와 아이콘, 클릭 이벤트(onTap)를 지정 가능
/// - onTap이 null이면 버튼이 비활성화 상태로 렌더링됨
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text, // 버튼에 표시될 텍스트
    required this.onTap, // 버튼 클릭 시 실행할 콜백 함수
    this.icon,
    this.width = double.infinity,
    this.height = 40.0, // 버튼 왼쪽에 표시할 아이콘 (선택)
  });

  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    // 버튼이 활성 상태인지 여부 판단 (onTap이 null이면 비활성 상태)
    bool isButtonEnabled = onTap != null ? true : false;

    return GestureDetector(
      // 버튼 클릭 시 동작 (null이면 동작하지 않음)
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0), // 버튼 주변 여백
        child: Container(
          width: width, // 가로를 최대 너비로 확장
          height: height, // 버튼 높이
          decoration: BoxDecoration(
            // 버튼 색상
            color: isButtonEnabled
                ? context.colors.primary
                : context.colors.shadow,
            borderRadius: BorderRadius.circular(8.0), // 모서리를 둥글게
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
            children: [
              // 아이콘이 있을 경우에만 표시
              if (icon != null) Icon(icon, color: context.colors.onPrimary),
              const SizedBox(width: 4.0), // 아이콘과 텍스트 사이 간격
              Text(
                text, // 버튼 텍스트
                style: TextStyle(
                  // 버튼 텍스트 색상
                  color: isButtonEnabled
                      ? context.colors.onPrimary
                      : context.colors.scrim,
                  fontWeight: FontWeight.w800, // 굵은 폰트
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
