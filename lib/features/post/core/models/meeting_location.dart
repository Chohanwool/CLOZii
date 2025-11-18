import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingLocation {
  final LatLng coordinate;
  final String detailAddress;

  const MeetingLocation({
    required this.coordinate,
    required this.detailAddress,
  });

  // JSON 직렬화
  Map<String, dynamic> toJson() {
    return {
      'coordinate': {
        'latitude': coordinate.latitude,
        'longitude': coordinate.longitude,
      },
      'detailAddress': detailAddress,
    };
  }

  // JSON 역직렬화
  factory MeetingLocation.fromJson(Map<String, dynamic> json) {
    return MeetingLocation(
      coordinate: LatLng(
        (json['coordinate'] as Map<String, dynamic>)['latitude'] as double,
        (json['coordinate'] as Map<String, dynamic>)['longitude'] as double,
      ),
      detailAddress: json['detailAddress'] as String,
    );
  }
}
