// features
import 'package:clozii/features/post/presentation/viewmodels/meeting_point_view_model.dart';

// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// 거래희망장소 좌표(LatLng)
final meetingPointProvider = NotifierProvider<MeetingPointViewModel, LatLng?>(
  MeetingPointViewModel.new,
);
