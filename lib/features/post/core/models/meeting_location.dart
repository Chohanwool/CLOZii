import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingLocation {
  final LatLng coordinate;
  final String detailAddress;

  const MeetingLocation({
    required this.coordinate,
    required this.detailAddress,
  });
}
