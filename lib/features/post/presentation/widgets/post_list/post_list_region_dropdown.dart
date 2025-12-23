import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/core/constants/regions.dart';
import 'package:clozii/features/post/presentation/providers/post_list/post_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListRegionDropdown extends ConsumerWidget {
  const PostListRegionDropdown({super.key});

  static const double _toolbarHeight = 60.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postListProvider);
    final isOpen = state.isDropdownOpen;

    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !isOpen,
            child: AnimatedOpacity(
              opacity: isOpen ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 180),
              child: GestureDetector(
                onTap: () =>
                    ref.read(postListProvider.notifier).setDropdown(false),
                child: Container(
                  color: AppColors.black26,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: _toolbarHeight + MediaQuery.of(context).padding.top,
          left: 24,
          child: IgnorePointer(
            ignoring: !isOpen,
            child: AnimatedSlide(
              offset: isOpen ? Offset.zero : const Offset(0.0, -0.04),
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: isOpen ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 180),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      const BoxShadow(
                        color: AppColors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: postRegions.map((region) {
                        final isSelected = region == state.selectedRegion;
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            ref
                                .read(postListProvider.notifier)
                                .setRegion(region);
                            ref
                                .read(postListProvider.notifier)
                                .setDropdown(false);
                          },
                          child: Container(
                            width: 150,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.1)
                                  : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    region,
                                    style: TextStyle(
                                      fontSize: isSelected ? 16 : 14,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    CupertinoIcons.checkmark_circle_fill,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
