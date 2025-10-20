// SelectedImageProvider 가 Map<String, ImageData> 형태의 상태를 관리함
import 'dart:typed_data';

class ImageState {
  Uint8List? originBytes;
  Uint8List? thumbnailBytes;
}
