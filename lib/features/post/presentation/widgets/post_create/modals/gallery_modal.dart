// dart
import 'dart:typed_data';

// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';

// features
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';
import 'package:clozii/features/post/presentation/models/image_bytes.dart';

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
  List<String> imageIds = []; // 불러온 이미디(AssetEntity) id 리스트
  Map<String, Uint8List?> thumbnailCache = {}; // 썸네일 캐싱용 맵

  late Map<String, ImageBytes>
      previousState; // 이전 선택 상태 저장용 - 갤러리 모달에서 X 누르면 이전 상태로 복원

  late Map<String, ImageBytes>
      newState; // 현재 선택하는 사진 상태 저장용 - 갤러리 모달에서 Done 버튼 누르면 프로바이더에 이 상태 저장

  int _loadedImageCount = 0; // 로드된 이미지 개수
  final int _loadLimit = 2; // 한 번에 로드할 이미지 개수

  bool _isLoading = false; // 로딩 상태
  bool _allImagesLoaded = false; // 모든 이미지가 로드되었는지 여부

  @override
  void initState() {
    super.initState();
    previousState = ref.read(postCreateProvider).selectedImages;
    newState = Map<String, ImageBytes>.from(previousState);
    _loadImages();
  }

  void _loadImages() async {
    _isLoading = true;

    try {
      // 사진 접근 권한 요청
      // 매번 권한을 물어보지 않고, 이미 권한이 허용되어 있으면 바로 결과를 반환
      final permission = await PhotoManager.requestPermissionExtend();

      if (!permission.isAuth) {
        PhotoManager.openSetting();
        return;
      }

      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );

      if (albums.isEmpty) {
        debugPrint('앨범이 없음');
        return;
      }

      final recentAlbum = albums.first;
      final assetCount = await recentAlbum.assetCountAsync;

      final start = _loadedImageCount;
      final end = (_loadedImageCount + _loadLimit).clamp(0, assetCount);

      if (start >= end) {
        _allImagesLoaded = true;
        return;
      }

      final loadedImages = await recentAlbum.getAssetListRange(
        start: start,
        end: end,
      );

      // loadedImages 의 각 AssetEntity 에 대해 썸네일 데이터 로드 (Future)
      final futureThumbData = loadedImages
          .map((asset) =>
              asset.thumbnailDataWithSize(const ThumbnailSize(100, 100)))
          .toList();

      // 모든 썸네일 로딩 작업을 병렬 처리
      final thumbDataList = await Future.wait(futureThumbData);

      // 로드 된 썸네일 리스트를 thumbnailCache 맵에 저장
      for (int i = 0; i < thumbDataList.length; i++) {
        thumbnailCache[loadedImages[i].id] = thumbDataList[i];
      }

      setState(() {
        imageIds.addAll(loadedImages.map((asset) => asset.id).toList());
        _loadedImageCount = end;
      });
    } finally {
      _isLoading = false;
    }
  }

  void _loadOriginalImages(Map<String, ImageBytes> newState) async {
    for (final entry in newState.entries) {
      String assetId = entry.key;
      ImageBytes imageData = entry.value;

      // 이미 원본 이미지가 로드된 경우는 스킵
      if (imageData.originBytes != null) continue;

      final asset = await AssetEntity.fromId(assetId);
      final originalImage = await asset?.originBytes;

      if (originalImage != null) {
        imageData.originBytes = originalImage;
      }
    }
  }

  void _openCamera() async {
    debugPrint('Camera tapped');
    final rawImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (rawImage != null) {
      _loadImages();
    }
  }

  // 이미지 선택 여부 확인
  bool isSelected(String id) {
    return newState.containsKey(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shape: const Border(bottom: BorderSide(color: AppColors.black12)),
        leading: IconButton(
          onPressed: () {
            ref.read(postCreateProvider.notifier).undoChanges(previousState);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text('Gallery'),
        actions: [
          TextButton(
            onPressed: () {
              _loadOriginalImages(newState);
              ref.read(postCreateProvider.notifier).saveImages(newState);
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!_isLoading &&
              !_allImagesLoaded &&
              scrollInfo.metrics.pixels >
                  scrollInfo.metrics.maxScrollExtent - 200) {
            _loadImages();
          }
          return false;
        },
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemCount: imageIds.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return GestureDetector(
                onTap: _openCamera,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt, size: 40.0),
                    Text('Camera', style: context.textTheme.bodyMedium),
                  ],
                ),
              );
            } else {
              // 현재 사진
              final assetId = imageIds[index - 1];

              final thumbData = thumbnailCache[assetId];

              if (thumbData == null) {
                return Container(color: AppColors.tertiary);
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (newState.containsKey(assetId)) {
                      newState.remove(assetId);
                    } else {
                      if (newState.length < PostCreateState.maxImageCount) {
                        final imageData = ImageBytes();
                        imageData.thumbnailBytes = thumbData;
                        newState[assetId] = imageData;
                      }
                    }
                  });
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.memory(thumbData, fit: BoxFit.cover),
                    ),
                    if (isSelected(assetId))
                      Positioned(child: Container(color: AppColors.black26)),
                    if (isSelected(assetId))
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
                    if (isSelected(assetId))
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
                              '${newState.keys.toList().indexOf(assetId) + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!isSelected(assetId))
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
                              offset: const Offset(0, 0),
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
      ),
    );
  }
}
