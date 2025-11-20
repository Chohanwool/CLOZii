// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostDetail)
const postDetailProvider = PostDetailProvider._();

final class PostDetailProvider
    extends $NotifierProvider<PostDetail, PostDetailState> {
  const PostDetailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postDetailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postDetailHash();

  @$internal
  @override
  PostDetail create() => PostDetail();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostDetailState>(value),
    );
  }
}

String _$postDetailHash() => r'e93d6da6ad086a7a0e8892a2f1ba765d408a9e05';

abstract class _$PostDetail extends $Notifier<PostDetailState> {
  PostDetailState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PostDetailState, PostDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostDetailState, PostDetailState>,
              PostDetailState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
