// SelectedImageProvider 가 Map<String, ImageData> 형태의 상태를 관리하도록 변경
import 'dart:typed_data';

class ImageData {
  Uint8List? originBytes;
  Uint8List? thumbnailBytes;
}
