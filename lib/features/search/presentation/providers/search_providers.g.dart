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
    r'c06cbbe5a9331b3a38af7b7af969ba056d5a5393';
