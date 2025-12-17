// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// post 도메인의 DI provider 모음
/// - PostRepository -> postRepositoryProvider (Firebase 저장소)
/// - PostDraftRepository -> postDraftRepositoryProvider
/// - CreatePost -> createPostProvider
/// - ManageDraft -> manageDraftProvider
/// - GetAllPosts -> getAllPostsProvider
// ============================================================================
// Repositories
// ============================================================================

@ProviderFor(postRepository)
const postRepositoryProvider = PostRepositoryProvider._();

/// post 도메인의 DI provider 모음
/// - PostRepository -> postRepositoryProvider (Firebase 저장소)
/// - PostDraftRepository -> postDraftRepositoryProvider
/// - CreatePost -> createPostProvider
/// - ManageDraft -> manageDraftProvider
/// - GetAllPosts -> getAllPostsProvider
// ============================================================================
// Repositories
// ============================================================================

final class PostRepositoryProvider
    extends $FunctionalProvider<PostRepository, PostRepository, PostRepository>
    with $Provider<PostRepository> {
  /// post 도메인의 DI provider 모음
  /// - PostRepository -> postRepositoryProvider (Firebase 저장소)
  /// - PostDraftRepository -> postDraftRepositoryProvider
  /// - CreatePost -> createPostProvider
  /// - ManageDraft -> manageDraftProvider
  /// - GetAllPosts -> getAllPostsProvider
// ============================================================================
// Repositories
// ============================================================================
  const PostRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'postRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postRepositoryHash();

  @$internal
  @override
  $ProviderElement<PostRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostRepository create(Ref ref) {
    return postRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostRepository>(value),
    );
  }
}

String _$postRepositoryHash() => r'ef37f529fdb7c718870e77166055c0e87d450585';

@ProviderFor(postDraftRepository)
const postDraftRepositoryProvider = PostDraftRepositoryProvider._();

final class PostDraftRepositoryProvider extends $FunctionalProvider<
    PostDraftRepository,
    PostDraftRepository,
    PostDraftRepository> with $Provider<PostDraftRepository> {
  const PostDraftRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'postDraftRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$postDraftRepositoryHash();

  @$internal
  @override
  $ProviderElement<PostDraftRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostDraftRepository create(Ref ref) {
    return postDraftRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostDraftRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostDraftRepository>(value),
    );
  }
}

String _$postDraftRepositoryHash() =>
    r'02e7d745a302c38dba5617e794d4ac33b36228d3';

@ProviderFor(createPost)
const createPostProvider = CreatePostProvider._();

final class CreatePostProvider
    extends $FunctionalProvider<CreatePost, CreatePost, CreatePost>
    with $Provider<CreatePost> {
  const CreatePostProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'createPostProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$createPostHash();

  @$internal
  @override
  $ProviderElement<CreatePost> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreatePost create(Ref ref) {
    return createPost(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreatePost value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreatePost>(value),
    );
  }
}

String _$createPostHash() => r'48f57f2e48973530c699ccf2b98589feac121d85';

@ProviderFor(manageDraft)
const manageDraftProvider = ManageDraftProvider._();

final class ManageDraftProvider
    extends $FunctionalProvider<ManageDraft, ManageDraft, ManageDraft>
    with $Provider<ManageDraft> {
  const ManageDraftProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'manageDraftProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$manageDraftHash();

  @$internal
  @override
  $ProviderElement<ManageDraft> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ManageDraft create(Ref ref) {
    return manageDraft(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ManageDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ManageDraft>(value),
    );
  }
}

String _$manageDraftHash() => r'905fd157236a680b5ed42e1b4c9e9eb9ad9770e7';

@ProviderFor(findAllPosts)
const findAllPostsProvider = FindAllPostsProvider._();

final class FindAllPostsProvider
    extends $FunctionalProvider<FindAllPosts, FindAllPosts, FindAllPosts>
    with $Provider<FindAllPosts> {
  const FindAllPostsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'findAllPostsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$findAllPostsHash();

  @$internal
  @override
  $ProviderElement<FindAllPosts> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FindAllPosts create(Ref ref) {
    return findAllPosts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FindAllPosts value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FindAllPosts>(value),
    );
  }
}

String _$findAllPostsHash() => r'39f1073f7468df1278b266b58429ee1381f4b883';
