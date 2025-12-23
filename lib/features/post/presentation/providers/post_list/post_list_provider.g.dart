// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostList)
const postListProvider = PostListProvider._();

final class PostListProvider
    extends $NotifierProvider<PostList, PostListState> {
  const PostListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'postListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postListHash();

  @$internal
  @override
  PostList create() => PostList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostListState>(value),
    );
  }
}

String _$postListHash() => r'd480adb273737b72416d708631553f67a06a5f19';

abstract class _$PostList extends $Notifier<PostListState> {
  PostListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PostListState, PostListState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<PostListState, PostListState>,
        PostListState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
