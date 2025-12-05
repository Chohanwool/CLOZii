// ImageBytes: 게시글 생성 중 선택된 이미지 데이터를 표현하는 클래스
// Presentation Layer에서 사용되며, Firebase Storage 업로드 전 임시 데이터를 나타냄

import 'dart:convert';
import 'dart:typed_data';

class ImageBytes {
  Uint8List? originBytes;
  Uint8List? thumbnailBytes;

  ImageBytes({
    this.originBytes,
    this.thumbnailBytes,
  });

  // JSON 직렬화 (base64 인코딩)
  Map<String, dynamic> toJson() {
    return {
      'originBytes': originBytes != null ? base64Encode(originBytes!) : null,
      'thumbnailBytes': thumbnailBytes != null ? base64Encode(thumbnailBytes!) : null,
    };
  }

  // JSON 역직렬화 (base64 디코딩)
  factory ImageBytes.fromJson(Map<String, dynamic> json) {
    return ImageBytes(
      originBytes: json['originBytes'] != null ? base64Decode(json['originBytes'] as String) : null,
      thumbnailBytes: json['thumbnailBytes'] != null ? base64Decode(json['thumbnailBytes'] as String) : null,
    );
  }

  @override
  String toString() {
    return 'ImageBytes(originBytes: ${originBytes?.length ?? 0} bytes, thumbnailBytes: ${thumbnailBytes?.length ?? 0} bytes)';
  }
}
