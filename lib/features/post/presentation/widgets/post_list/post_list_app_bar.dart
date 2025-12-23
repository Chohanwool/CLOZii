import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/widgets/filter_bar.dart';
import 'package:clozii/features/post/core/constants/post_filter_sets.dart';
import 'package:clozii/features/post/core/constants/regions.dart';
import 'package:clozii/features/post/core/enums/post_filter.dart';
import 'package:clozii/features/post/presentation/providers/post_list/post_list_provider.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modals/category_list_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PostListAppBar({
    super.key,
    required this.onSearchTap,
  });

  final VoidCallback onSearchTap;

  static const double _toolbarHeight = 60.0;
  static const double _filterBarHeight = 60.0;

  @override
  Size get preferredSize =>
      const Size.fromHeight(_toolbarHeight + _filterBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postListProvider);
    final titleRegion =
        state.selectedRegion.isNotEmpty ? state.selectedRegion : postRegions[0];

    return AppBar(
      toolbarHeight: _toolbarHeight,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 24.0,
      title: GestureDetector(
        onTap: () => ref.read(postListProvider.notifier).toggleDropdown(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(titleRegion),
            const SizedBox(width: 8),
            Icon(
              state.isDropdownOpen
                  ? CupertinoIcons.chevron_up
                  : CupertinoIcons.chevron_down,
              size: 28,
            ),
          ],
        ),
      ),
      centerTitle: false,
      elevation: 6.0,
      scrolledUnderElevation: 6.0,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.borderLight),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      actionsPadding: const EdgeInsets.only(right: 16.0),
      actions: [
        IconButton(
          onPressed: onSearchTap,
          icon: const Icon(Icons.search),
          iconSize: 28,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.bell),
          iconSize: 28,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.heart),
          iconSize: 28,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(_filterBarHeight),
        child: FilterBar(
          filters: homePostFilters,
          selectedFilter: state.selectedFilter,
          onFilterSelected: (filter) async {
            final currentFilter = ref.read(postListProvider).selectedFilter;
            ref.read(postListProvider.notifier).updateSelectedFilter(filter);

            // 카테고리 리스트 모달
            if (filter == PostFilter.category) {
              final result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                enableDrag: false,
                backgroundColor: AppColors.white,
                builder: (BuildContext context) => Container(
                  padding: const EdgeInsets.only(top: kToolbarHeight),
                  child: CategoryListModal(
                    onSelected: (value) {
                      ref.read(postListProvider.notifier).setCategory(value);
                    },
                  ),
                ),
              );

              // 카테고리 선택 하지 않으면 이전 필터 유지 (예: Shares -> Category 선택 후 상단 X 버튼으로 pop 하면 다시 필터는 Shares)
              if (result == null || !result) {
                ref
                    .read(postListProvider.notifier)
                    .updateSelectedFilter(currentFilter);
              }
            }
          },
        ),
      ),
    );
  }
}
