// core
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/presentation/provider/post_create_provider.dart';

// feature

// package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MeetingPointMap extends ConsumerStatefulWidget {
  const MeetingPointMap({
    super.key,
    required this.onCameraIdle,
    required this.onCameraMove,
  });

  final ValueChanged<LatLng> onCameraIdle;
  final VoidCallback onCameraMove;

  @override
  ConsumerState<MeetingPointMap> createState() => _MeetingPointSelectorState();
}

class _MeetingPointSelectorState extends ConsumerState<MeetingPointMap> {
  GoogleMapController? _controller;
  late final CameraPosition initialPosition;

  static const CameraPosition defaultPosition = CameraPosition(
    target: LatLng(14.264076669634353, 121.074357368052),
    zoom: 17.0,
  );

  @override
  void initState() {
    super.initState();

    // 사용자가 이전에 설정한 거래희망장소 좌표가 있으면 그 좌표를 사용, 없으면 기본 좌표를 사용
    final stateLatLng = ref
        .read(postCreateProvider)
        .meetingLocation
        ?.coordinate;

    initialPosition = stateLatLng != null
        ? CameraPosition(target: stateLatLng, zoom: 17.0)
        : defaultPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 올라와도 UI가 움직이지 않도록 설정
      resizeToAvoidBottomInset: false,

      // LayoutBuilder를 사용하여 지도 영역의 실제 크기를 가져옴
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 지도 영역의 실제 크기
          final mapWidth = constraints.maxWidth;
          final mapHeight = constraints.maxHeight;

          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: initialPosition,
                onMapCreated: (controller) {
                  _controller = controller;
                },
                onCameraMove: (_) {
                  widget.onCameraMove();
                },
                onCameraIdle: () async {
                  if (_controller == null) return;

                  // 지도 영역의 중앙 좌표
                  final centerX = (mapWidth / 2).round();
                  final centerY = (mapHeight / 2).round();

                  // 지도 영역 중앙의 실제 위경도 좌표
                  final markerLatLng = await _controller!.getLatLng(
                    ScreenCoordinate(x: centerX, y: centerY),
                  );

                  widget.onCameraIdle(markerLatLng);
                },
              ),

              Center(
                child: IgnorePointer(
                  ignoring: true,
                  child: Transform.translate(
                    // 살짝 위로 커스텀 마커를 올림 - 화면 중앙 좌표를 정확히 가르키기 위함
                    offset: const Offset(0, -25),
                    child: Icon(
                      Icons.place,
                      size: 60,
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
