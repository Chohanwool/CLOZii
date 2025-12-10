import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/domain/repositories/post_repository.dart';

/// 게시글 목록 조회 UseCase
class GetAllPosts {
  final PostRepository _postRepository;

  const GetAllPosts(this._postRepository);

  /// 게시글 목록 조회
  ///
  /// [page]: 페이지 번호 (기본값: 1)
  /// [limit]: 조회할 게시글 수 (기본값: 20)
  Future<List<Post>> call({int page = 1, int limit = 20}) async {
    return await _postRepository.findAllPosts(page: page, limit: limit);
  }
}
