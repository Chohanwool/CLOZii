//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingPointViewModel extends Notifier<LatLng?> {
  @override
  LatLng? build() => null;

  void setMeetingPoint(LatLng meetingPoint) {
    state = meetingPoint;
  }

  LatLng? getMeetingPoint() {
    return state;
  }
}
