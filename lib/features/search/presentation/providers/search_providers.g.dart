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

@ProviderFor(searchPostsByQuery)
const searchPostsByQueryProvider = SearchPostsByQueryProvider._();

final class SearchPostsByQueryProvider extends $FunctionalProvider<
    SearchPostsByQuery,
    SearchPostsByQuery,
    SearchPostsByQuery> with $Provider<SearchPostsByQuery> {
  const SearchPostsByQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchPostsByQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchPostsByQueryHash();

  @$internal
  @override
  $ProviderElement<SearchPostsByQuery> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchPostsByQuery create(Ref ref) {
    return searchPostsByQuery(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchPostsByQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchPostsByQuery>(value),
    );
  }
}

String _$searchPostsByQueryHash() =>
    r'56cae0ae5b921485375a14556e2caa4597f81217';
