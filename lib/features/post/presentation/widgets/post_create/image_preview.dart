import 'package:clozii/features/post/provider/selected_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePreviews extends ConsumerWidget {
  const ImagePreviews({super.key, required this.assetId});

  final String assetId;

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
            Container(
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
            Positioned(
              top: -4.0,
              right: -4.0,
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
          ],
        ),
      ],
    );
  }
}
