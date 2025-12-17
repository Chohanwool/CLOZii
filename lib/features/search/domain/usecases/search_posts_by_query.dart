import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/search/domain/repositories/search_repository.dart';

class SearchPostsByQuery {
  final SearchRepository _searchRepository;

  SearchPostsByQuery(this._searchRepository);

  Future<List<Post>> call(String query, {int page = 1, int limit = 20}) async {
    return await _searchRepository.searchPostsByQuery(
      query,
      page: page,
      limit: limit,
    );
  }
}
