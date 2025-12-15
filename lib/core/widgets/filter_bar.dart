import 'package:clozii/core/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  // 상수 정의
  static const double _filterSpacing = 12.0;
  static const double _filterBarHeight = 60.0;
  static const double _filterBarVerticalPadding = 8.0;

  int? _selectedIndex = 0;

  // Map으로 필터 버튼 정의 (hasIcon 플래그 사용)
  final List<Map<String, dynamic>> _filterButtons = [
    {'label': 'All', 'hasIcon': false},
    {
      'label': 'Price',
      'hasIcon': true,
      'iconData': CupertinoIcons.chevron_down
    },
    {'label': 'Shares', 'hasIcon': false},
    {'label': 'NearBy', 'hasIcon': false},
    {
      'label': 'Category',
      'hasIcon': true,
      'iconData': CupertinoIcons.arrow_up_right
    },
    {'label': 'Clothes', 'hasIcon': false},
    {'label': 'Shoes', 'hasIcon': false},
    {'label': 'Phone', 'hasIcon': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _filterBarHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: _filterSpacing,
          vertical: _filterBarVerticalPadding,
        ),
        itemCount: _filterButtons.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: _filterSpacing),
        itemBuilder: (context, index) {
          final filterData = _filterButtons[index];
          return _FilterButton(
            label: filterData['label'],
            isSelected: _selectedIndex == index,
            hasIcon: filterData['hasIcon'],
            onTap: () {
              setState(() => _selectedIndex = index);
              debugPrint('Selected filter: ${filterData['label']}');
            },
            iconData: filterData['hasIcon'] ? filterData['iconData'] : null,
          );
        },
      ),
    );
  }
}

// 별도 위젯으로 분리
class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool hasIcon;
  final VoidCallback onTap;
  final IconData? iconData;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.hasIcon,
    required this.onTap,
    this.iconData,
  });

  static const double _filterHeight = 40.0;
  static const double _filterHorizontalPadding = 16.0;
  static const double _iconSize = 16.0;
  static const double _iconSpacing = 4.0;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.white : AppColors.gray800;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _filterHeight,
        padding:
            const EdgeInsets.symmetric(horizontal: _filterHorizontalPadding),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandNeutralSurfaceDark
              : AppColors.gray100,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hasIcon) ...[
              const SizedBox(width: _iconSpacing),
              Icon(
                iconData,
                size: _iconSize,
                color: color,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
