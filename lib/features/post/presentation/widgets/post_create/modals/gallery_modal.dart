import 'dart:typed_data';

import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryModal extends StatefulWidget {
  const GalleryModal({super.key});

  @override
  State<GalleryModal> createState() => _GalleryModalState();
}

class _GalleryModalState extends State<GalleryModal> {
  List<AssetEntity> images = [];

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
        for (var album in albums) {
          debugPrint(album.name);
        }

        final recentAlbum = albums.first;
        final assetCount = await recentAlbum.assetCountAsync;

        final images = await recentAlbum.getAssetListRange(
          start: 0,
          end: assetCount,
        );
        debugPrint('images: ${images.length}');

        setState(() => this.images = images);
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
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shape: Border(bottom: BorderSide(color: AppColors.black12)),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
        title: Text('Gallery'),
        actions: [TextButton(onPressed: () {}, child: Text('Done'))],
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
            // 갤러리 사진
            return FutureBuilder<Uint8List?>(
              future: images[index - 1].thumbnailDataWithSize(
                ThumbnailSize(200, 200),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final img = Image.memory(
                    snapshot.data!, // Uint8List 바이트 데이터를 이미지로 변환
                    fit: BoxFit.cover,
                  );

                  return GestureDetector(
                    onTap: () => debugPrint('image tapped'),
                    child: Stack(
                      children: [
                        Positioned.fill(child: img),
                        Positioned(
                          top: 5,
                          right: 5,
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
                return Container(color: Colors.red[200]);
              },
            );
          }
        },
      ),
    );
  }
}
