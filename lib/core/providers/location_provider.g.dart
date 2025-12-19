// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Location)
const locationProvider = LocationProvider._();

final class LocationProvider
    extends $NotifierProvider<Location, LocationState> {
  const LocationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'locationProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$locationHash();

  @$internal
  @override
  Location create() => Location();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationState>(value),
    );
  }
}

String _$locationHash() => r'd5cfcf7dd7ac33e1d41b3f3aae918a50204665bc';

abstract class _$Location extends $Notifier<LocationState> {
  LocationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LocationState, LocationState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<LocationState, LocationState>,
        LocationState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
