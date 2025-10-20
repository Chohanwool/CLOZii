import 'package:clozii/features/post/presentation/states/image_state.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/image_preview.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/selectors/image_selector.dart';
import 'package:flutter/material.dart';

class ImageSelectSection extends StatelessWidget {
  const ImageSelectSection({super.key, required this.selectedImages});

  final Map<String, ImageState> selectedImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: selectedImages.length + 1,
        itemBuilder: (context, index) {
          // ImageSelector - 사진 선택 위젯
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ImageSelector(),
            );
          }

          String assetId = selectedImages.keys.elementAt(index - 1);

          return ImagePreview(assetId: assetId);
        },
      ),
    );
  }
}
