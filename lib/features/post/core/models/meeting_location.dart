import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'meeting_location.g.dart';

@HiveType(typeId: 1)
class MeetingLocation {
  @HiveField(0)
  final LatLng coordinate;

  @HiveField(1)
  final String detailAddress;

  const MeetingLocation({
    required this.coordinate,
    required this.detailAddress,
  });
}
