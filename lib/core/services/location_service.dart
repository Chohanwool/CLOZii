import 'package:geolocator/geolocator.dart';

class LocationService {
  // 현재 위치 가져오기
  Future<Position?> getCurrentLocation() async {
    try {
      // 1. 위치 서비스 활성화 확인
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      // 2. 권한 확인 및 요청
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      // 3. 현재 위치 가져오기
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }

  // 위치 서비스 활성화 여부
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  // 권한 상태 확인
  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  // 권한 요청
  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  // 앱 설정 열기
  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }
}
