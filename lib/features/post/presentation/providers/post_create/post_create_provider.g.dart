// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_create_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostCreate)
const postCreateProvider = PostCreateProvider._();

final class PostCreateProvider
    extends $NotifierProvider<PostCreate, PostCreateState> {
  const PostCreateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'postCreateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postCreateHash();

  @$internal
  @override
  PostCreate create() => PostCreate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostCreateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostCreateState>(value),
    );
  }
}

String _$postCreateHash() => r'de9ecf9240966e95abd3455c028239819a14c185';

abstract class _$PostCreate extends $Notifier<PostCreateState> {
  PostCreateState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PostCreateState, PostCreateState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PostCreateState, PostCreateState>,
        PostCreateState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
