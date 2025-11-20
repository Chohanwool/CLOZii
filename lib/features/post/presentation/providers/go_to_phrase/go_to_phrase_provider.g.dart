// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_to_phrase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoToPhrases)
const goToPhrasesProvider = GoToPhrasesProvider._();

final class GoToPhrasesProvider
    extends $NotifierProvider<GoToPhrases, GoToPhraseState> {
  const GoToPhrasesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goToPhrasesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goToPhrasesHash();

  @$internal
  @override
  GoToPhrases create() => GoToPhrases();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoToPhraseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoToPhraseState>(value),
    );
  }
}

String _$goToPhrasesHash() => r'b7690aecc25eb62356aa2cbe09e8d104a42c21e5';

abstract class _$GoToPhrases extends $Notifier<GoToPhraseState> {
  GoToPhraseState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GoToPhraseState, GoToPhraseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoToPhraseState, GoToPhraseState>,
              GoToPhraseState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
