import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:flutter/cupertino.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
    this.selectedFilter,
    this.onFilterSelected,
  });

  // 상수 정의
  static const double _filterSpacing = 12.0;
  static const double _filterBarHeight = 60.0;
  static const double _filterBarVerticalPadding = 8.0;

  final PostFilter? selectedFilter;
  final ValueChanged<PostFilter>? onFilterSelected;

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
        itemCount: PostFilter.values.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: _filterSpacing),
        itemBuilder: (context, index) {
          final filterData = PostFilter.values[index];
          return _FilterButton(
            label: filterData.displayName,
            isSelected: selectedFilter == filterData,
            hasIcon: filterData.hasIcon,
            onTap: () {
              onFilterSelected?.call(filterData);
            },
            iconData: filterData.hasIcon ? filterData.iconData : null,
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
