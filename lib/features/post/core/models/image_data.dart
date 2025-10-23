// SelectedImageProvider 가 Map<String, ImageData> 형태의 상태를 관리함
import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'image_data.g.dart'; // 자동 생성될 파일

@HiveType(typeId: 0)
class ImageData {
  @HiveField(0)
  Uint8List? originBytes;

  @HiveField(1)
  Uint8List? thumbnailBytes;

  ImageData({this.originBytes, this.thumbnailBytes});
}
