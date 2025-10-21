// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// features
import 'package:clozii/features/post_old/presentation/widgets/post_create/modals/gallery_modal.dart';
import 'package:clozii/features/post_old/provider/selected_image_provider.dart';

// packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSelector extends ConsumerWidget {
  const ImageSelector({super.key});

  void showGallery(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => Container(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
          bottom: kBottomNavigationBarHeight,
        ),
        child: GalleryModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImageIds = ref.watch(selectedImageProvider);

    return GestureDetector(
      onTap: () => showGallery(context),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.black26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.camera_fill,
              size: 32.0,
              color: AppColors.black54,
            ),
            // 추가된 사진 개수 표시 - 10장까지 추가 가능
            Text(
              '${selectedImageIds.length}/${SelectedImageNotifier.maxLength}',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
