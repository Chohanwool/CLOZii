// ImageBytes: 게시글 생성 중 선택된 이미지 데이터를 표현하는 클래스
// Presentation Layer에서 사용되며, Firebase Storage 업로드 전 임시 데이터를 나타냄

import 'dart:convert';
import 'dart:typed_data';

class ImageBytes {
  final Uint8List thumbnailBytes;
  final Uint8List? originBytes;

  const ImageBytes({
    required this.thumbnailBytes,
    this.originBytes,
  });

  // copyWith 메서드
  ImageBytes copyWith({
    Uint8List? thumbnailBytes,
    Uint8List? originBytes,
  }) {
    return ImageBytes(
      thumbnailBytes: thumbnailBytes ?? this.thumbnailBytes,
      originBytes: originBytes ?? this.originBytes,
    );
  }

  // JSON 직렬화 (base64 인코딩)
  Map<String, dynamic> toJson() {
    return {
      'originBytes': originBytes != null ? base64Encode(originBytes!) : null,
      'thumbnailBytes': base64Encode(thumbnailBytes),
    };
  }

  // JSON 역직렬화 (base64 디코딩)
  factory ImageBytes.fromJson(Map<String, dynamic> json) {
    return ImageBytes(
      thumbnailBytes: base64Decode(json['thumbnailBytes'] as String),
      originBytes: json['originBytes'] != null
          ? base64Decode(json['originBytes'] as String)
          : null,
    );
  }

  @override
  String toString() {
    return 'ImageBytes(originBytes: ${originBytes?.length ?? 0} bytes, thumbnailBytes: ${thumbnailBytes.length} bytes)';
  }
}
