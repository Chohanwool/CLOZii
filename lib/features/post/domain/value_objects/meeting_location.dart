// MeetingLocation model
// 순수 Dart 클래스 (외부 패키지 의존 없음)

class MeetingLocation {
  final double latitude;
  final double longitude;
  final String detailAddress;

  const MeetingLocation({
    required this.latitude,
    required this.longitude,
    required this.detailAddress,
  });

  // JSON 직렬화
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'detailAddress': detailAddress,
    };
  }

  // JSON 역직렬화
  factory MeetingLocation.fromJson(Map<String, dynamic> json) {
    return MeetingLocation(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      detailAddress: json['detailAddress'] as String,
    );
  }
}
