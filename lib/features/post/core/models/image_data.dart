// SelectedImageProvider 가 Map<String, ImageData> 형태의 상태를 관리함
import 'dart:convert';
import 'dart:typed_data';

class ImageData {
  Uint8List? originBytes;
  Uint8List? thumbnailBytes;

  ImageData({this.originBytes, this.thumbnailBytes});

  // JSON 직렬화
  Map<String, dynamic> toJson() {
    return {
      'originBytes': originBytes != null
          ? base64Encode(originBytes!)
          : null,
      'thumbnailBytes': thumbnailBytes != null
          ? base64Encode(thumbnailBytes!)
          : null,
    };
  }

  // JSON 역직렬화
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      originBytes: json['originBytes'] != null
          ? base64Decode(json['originBytes'] as String)
          : null,
      thumbnailBytes: json['thumbnailBytes'] != null
          ? base64Decode(json['thumbnailBytes'] as String)
          : null,
    );
  }
}
