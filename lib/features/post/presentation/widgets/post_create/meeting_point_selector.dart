// core
// package
import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingPointSelector extends StatefulWidget {
  const MeetingPointSelector({super.key});

  @override
  State<MeetingPointSelector> createState() => _MeetingPointSelectorState();
}

class _MeetingPointSelectorState extends State<MeetingPointSelector> {
  late final GoogleMapController? _controller;
  LatLng centerLatLng = LatLng(14.2639, 121.0742);

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

              setState(() {
                centerLatLng = markerLatLng;
              });

              debugPrint("마커가 가리키는 지도 좌표: $markerLatLng");
            },
            // markers: {
            //   Marker(
            //     markerId: MarkerId('center_marker'),
            //     position: centerLatLng,
            //   ),
            // },
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
