import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePreviews extends StatefulWidget {
  const ImagePreviews({super.key, required this.assetId});

  final String assetId;

  @override
  State<ImagePreviews> createState() => _ImagePreviewsState();
}

class _ImagePreviewsState extends State<ImagePreviews> {
  Future<Uint8List?> _getThumbnailData(String assetId) async {
    final asset = await AssetEntity.fromId(assetId);
    if (asset == null) return null;

    return await asset.thumbnailDataWithSize(const ThumbnailSize(200, 200));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _getThumbnailData(widget.assetId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Icon(Icons.error));
        }

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
                  child: Image.memory(
                    width: 80,
                    height: 80,
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
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
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
