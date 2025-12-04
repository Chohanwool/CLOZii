// ImageData: 단일 이미지의 원본/썸네일 URL을 표현하는 Value Object
// Domain Layer에서 사용되며, Firestore에 저장된 이미지 URL을 나타냄

class ImageData {
  final String originUrl;
  final String thumbnailUrl;

  const ImageData({
    required this.originUrl,
    required this.thumbnailUrl,
  });

  // JSON 직렬화
  Map<String, dynamic> toJson() {
    return {
      'originUrl': originUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  // JSON 역직렬화
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      originUrl: json['originUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'ImageData(originUrl: $originUrl, thumbnailUrl: $thumbnailUrl)';
  }
}
