// ============================================================================
// Service Provider for LocationService
// ============================================================================

import 'package:clozii/core/services/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service_provider.g.dart';

@riverpod
LocationService locationService(Ref ref) {
  return LocationService();
}
