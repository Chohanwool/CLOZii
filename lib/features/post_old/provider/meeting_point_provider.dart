import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// 거래희망장소 좌표(LatLng)
final meetingPointProvider = NotifierProvider<MeetingPointNotifier, LatLng?>(
  MeetingPointNotifier.new,
);

class MeetingPointNotifier extends Notifier<LatLng?> {
  @override
  LatLng? build() => null;

  void setMeetingPoint(LatLng meetingPoint) {
    state = meetingPoint;
  }

  LatLng? getMeetingPoint() {
    return state;
  }
}
