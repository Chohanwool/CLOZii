// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Home)
const homeProvider = HomeProvider._();

final class HomeProvider extends $NotifierProvider<Home, HomeState> {
  const HomeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'homeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$homeHash();

  @$internal
  @override
  Home create() => Home();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeState>(value),
    );
  }
}

String _$homeHash() => r'e6be43f2a0fb6241dcf440a3f51e0e8daa088f99';

abstract class _$Home extends $Notifier<HomeState> {
  HomeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HomeState, HomeState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<HomeState, HomeState>, HomeState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
