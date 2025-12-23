// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchRepository)
const searchRepositoryProvider = SearchRepositoryProvider._();

final class SearchRepositoryProvider extends $FunctionalProvider<
    SearchRepository,
    SearchRepository,
    SearchRepository> with $Provider<SearchRepository> {
  const SearchRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchRepositoryHash();

  @$internal
  @override
  $ProviderElement<SearchRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchRepository create(Ref ref) {
    return searchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchRepository>(value),
    );
  }
}

String _$searchRepositoryHash() => r'3c39bcb03c498707a420a3885d2a8592616730f4';

@ProviderFor(searchPostsByFilter)
const searchPostsByFilterProvider = SearchPostsByFilterProvider._();

final class SearchPostsByFilterProvider extends $FunctionalProvider<
    SearchPostsWithFilter,
    SearchPostsWithFilter,
    SearchPostsWithFilter> with $Provider<SearchPostsWithFilter> {
  const SearchPostsByFilterProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchPostsByFilterProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchPostsByFilterHash();

  @$internal
  @override
  $ProviderElement<SearchPostsWithFilter> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchPostsWithFilter create(Ref ref) {
    return searchPostsByFilter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchPostsWithFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchPostsWithFilter>(value),
    );
  }
}

String _$searchPostsByFilterHash() =>
    r'460e066e42629162b76471fd4f175a4635257a36';

@ProviderFor(loadPostsByFilter)
const loadPostsByFilterProvider = LoadPostsByFilterProvider._();

final class LoadPostsByFilterProvider extends $FunctionalProvider<
    LoadPostsWithFilter,
    LoadPostsWithFilter,
    LoadPostsWithFilter> with $Provider<LoadPostsWithFilter> {
  const LoadPostsByFilterProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'loadPostsByFilterProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$loadPostsByFilterHash();

  @$internal
  @override
  $ProviderElement<LoadPostsWithFilter> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LoadPostsWithFilter create(Ref ref) {
    return loadPostsByFilter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoadPostsWithFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoadPostsWithFilter>(value),
    );
  }
}

String _$loadPostsByFilterHash() => r'321e5888fdf8e9854a4f42be21f919a10e0ee889';
