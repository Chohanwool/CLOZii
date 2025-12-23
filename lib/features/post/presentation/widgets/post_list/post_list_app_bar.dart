import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/widgets/filter_bar.dart';
import 'package:clozii/features/post/core/constants/post_filter_sets.dart';
import 'package:clozii/features/post/core/constants/regions.dart';
import 'package:clozii/features/post/presentation/providers/post_list/post_list_provider.dart';
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
          onFilterSelected: (filter) {
            ref.read(postListProvider.notifier).updateSelectedFilter(filter);
          },
        ),
      ),
    );
  }
}
