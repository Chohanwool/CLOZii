import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';

class CustomChoiceChips extends StatelessWidget {
  const CustomChoiceChips({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.showCheckmark = true,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final bool showCheckmark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      splashColor: Colors.transparent, // ripple 제거
      highlightColor: Colors.transparent, // highlight 제거
      // ChoiceChip처럼 사용하기 위한 컨테이너
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // 선택 O : secondaryContainer (연한 핑크)
          // 선택 X : surface (흰색)
          color: selected
              ? context.colors.secondaryContainer
              : context.colors.surface,

          // 모서리 둥글게
          borderRadius: BorderRadius.circular(8),

          // 버튼 테두리 색상
          // 선택 O : secondaryContainer (연한 핑크)
          // 선택 X : border (회색)
          border: Border.all(
            color: selected
                ? context.colors.secondaryContainer
                : AppColors.border,
          ),
        ),

        // 컨테이너 내부 컴포넌트
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 선택 되었을 경우에만, 체크 아이콘 표시
            if (selected)
              Icon(
                Icons.check,
                color: context.colors.onPrimaryContainer,
                size: 16,
              ),
            const SizedBox(width: 8),

            // 버튼 라벨
            Text(
              label,
              // 버튼 라벨 색상
              // 선택 O : onPrimaryContainer (진한 갈색)
              // 선택 X : onSurfaceVariant (회색)
              style: context.textTheme.labelLarge?.copyWith(
                color: selected
                    ? context.colors.onPrimaryContainer
                    : context.colors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
