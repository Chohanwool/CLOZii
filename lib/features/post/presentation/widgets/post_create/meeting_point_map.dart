// core
import 'package:clozii/core/theme/context_extension.dart';

// feature

// package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingPointMap extends ConsumerStatefulWidget {
  const MeetingPointMap({super.key, required this.onCameraIdle});

  final ValueChanged<LatLng> onCameraIdle;

  @override
  ConsumerState<MeetingPointMap> createState() => _MeetingPointSelectorState();
}

class _MeetingPointSelectorState extends ConsumerState<MeetingPointMap> {
  late final GoogleMapController? _controller;

  static const CameraPosition kInitialPosition = CameraPosition(
    target: LatLng(14.2639, 121.0742),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 올라와도 UI가 움직이지 않도록 설정
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: kInitialPosition,
            onMapCreated: (controller) {
              _controller = controller;
            },
            onCameraIdle: () async {
              if (_controller == null) return;

              // 화면 크기 (픽셀 단위)
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;

              // 중앙 좌표
              final centerX = (screenWidth / 2).round();
              final centerY = (screenHeight / 2).round();

              // 실제로 마커가 가리키는 좌표
              // centerX, centerY 만으로는 아래의 마커가 가르키는 지점과 일치하지 않음 따라서 centerY에 135를 빼줌
              LatLng markerLatLng = await _controller.getLatLng(
                ScreenCoordinate(x: centerX, y: centerY - 135),
              );

              widget.onCameraIdle(markerLatLng);
            },
          ),

          Center(
            child: IgnorePointer(
              ignoring: true,
              child: Transform.translate(
                offset: const Offset(0, -20), // 살짝 위/아래로 조정 가능
                child: Icon(
                  Icons.place,
                  size: 60,
                  color: context.colors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
