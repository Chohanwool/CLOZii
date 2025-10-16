import 'package:clozii/features/post/presentation/widgets/post_create/full_screen_image_viewer.dart';
import 'package:clozii/features/post/provider/selected_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePreview extends ConsumerWidget {
  const ImagePreview({super.key, required this.assetId});

  final String assetId;

  void showFullImage(BuildContext context, WidgetRef ref) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),

      // “화면에 어떤 위젯을 그릴지” 정의 (보통 매개변수를 사용하진 않음)
      pageBuilder: (_, __, ___) {
        return FullScreenImageViewer(assetId: assetId);
      },
      // “등장/퇴장 애니메이션” 정의
      transitionBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // 아래에서 시작
            end: Offset.zero, // 제자리 도착
          ).animate(curved),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnailData = ref
        .read(selectedImageProvider.notifier)
        .getThumbnail(assetId);

    return Row(
      children: [
        const SizedBox(width: 12.0),
        Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () => showFullImage(context, ref),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: thumbnailData != null
                    ? Image.memory(
                        width: 80,
                        height: 80,
                        thumbnailData,
                        fit: BoxFit.cover,
                      )
                    : const Placeholder(fallbackWidth: 80, fallbackHeight: 80),
              ),
            ),
            Positioned(
              top: -4.0,
              right: -4.0,
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedImageProvider.notifier).removeImage(assetId);
                },
                child: Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // 불투명 배경
                  ),
                  child: const Icon(Icons.close, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
