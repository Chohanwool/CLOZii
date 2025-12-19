import 'package:clozii/core/services/location_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.freezed.dart';
part 'location_provider.g.dart';

// ============================================================================
// State
// ============================================================================

@freezed
sealed class LocationState with _$LocationState {
  const factory LocationState({
    Position? position,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _LocationState;
}

// ============================================================================
// Provider (ViewModel)
// ============================================================================

@riverpod
class Location extends _$Location {
  final _locationService = LocationService();

  @override
  LocationState build() => const LocationState();

  Future<void> fetchCurrentLocation() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final position = await _locationService.getCurrentLocation();

    if (position != null) {
      state = state.copyWith(
        position: position,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '위치 권한이 필요합니다',
      );
    }
  }

  void clearLocation() {
    state = const LocationState();
  }
}
