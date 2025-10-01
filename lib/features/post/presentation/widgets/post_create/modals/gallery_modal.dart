// dart
import 'dart:typed_data';

// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// features
import 'package:clozii/features/post/provider/selected_image_ids_provider.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryModal extends ConsumerStatefulWidget {
  const GalleryModal({super.key});

  @override
  ConsumerState<GalleryModal> createState() => _GalleryModalState();
}

class _GalleryModalState extends ConsumerState<GalleryModal> {
  List<AssetEntity> images = []; // 불러온 이미지 리스트
  Map<String, Uint8List?> thumbnailCache = {}; // 썸네일 캐싱용 맵

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  void _loadImages() async {
    final permission = await PhotoManager.requestPermissionExtend();

    if (permission.isAuth) {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );

      if (albums.isNotEmpty) {
        final recentAlbum = albums.first;
        final assetCount = await recentAlbum.assetCountAsync;

        final loadedImages = await recentAlbum.getAssetListRange(
          start: 0,
          end: assetCount,
        );
        debugPrint('images: ${loadedImages.length}');

        // loadedImages 의 각 AssetEntity 에 대해 썸네일 데이터 로드 (Future)
        final futureThumbData = loadedImages
            .map(
              (asset) => asset.thumbnailDataWithSize(ThumbnailSize(100, 100)),
            )
            .toList();

        // 모든 썸네일 로딩 작업을 병렬 처리
        final thumbDataList = await Future.wait(futureThumbData);

        // 로드 된 썸네일 리스트를 thumbnailCache 맵에 저장
        for (int i = 0; i < thumbDataList.length; i++) {
          thumbnailCache[loadedImages[i].id] = thumbDataList[i];
        }

        setState(() {
          images = loadedImages;
        });
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  void _openCamera() async {
    debugPrint('Camera tapped');
    final rawImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (rawImage != null) {
      _loadImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedImageIds = ref.watch(selectedImageIdsProvider);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shape: Border(bottom: BorderSide(color: AppColors.black12)),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
        title: Text('Gallery'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Done'),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemCount: images.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return GestureDetector(
              onTap: _openCamera,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 40.0),
                  Text('Camera', style: context.textTheme.bodyMedium),
                ],
              ),
            );
          } else {
            // 현재 사진
            final asset = images[index - 1];

            // 현재 사진이 선택되었는 지 여부
            final isSelected = ref
                .watch(selectedImageIdsProvider.notifier)
                .isSelected(asset.id);

            final thumbData = thumbnailCache[asset.id];

            if (thumbData == null) {
              return Container(color: AppColors.tertiary);
            }

            return GestureDetector(
              onTap: () {
                ref
                    .read(selectedImageIdsProvider.notifier)
                    .toggleSelection(asset.id);

                debugPrint(selectedImageIds.length.toString());
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.memory(thumbData, fit: BoxFit.cover),
                  ),

                  if (isSelected)
                    Positioned(child: Container(color: AppColors.black26)),

                  if (isSelected)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: context.colors.primary,
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),

                  if (isSelected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colors.primary,
                        ),
                        child: Center(
                          child: Text(
                            '${selectedImageIds.indexOf(asset.id) + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                  if (!isSelected)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Icon(
                        Icons.circle_outlined,
                        color: AppColors.white,
                        size: 28.0,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.7),
                            offset: Offset(0, 0),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
