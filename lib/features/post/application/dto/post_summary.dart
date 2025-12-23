import 'package:clozii/features/post/domain/entities/post.dart';

class PostSummary {
  final String id;
  final String title;
  final int price;
  final DateTime? createdAt;
  final String? thumbnailUrl;

  const PostSummary({
    required this.id,
    required this.title,
    required this.price,
    required this.createdAt,
    required this.thumbnailUrl,
  });

  factory PostSummary.fromPost(Post post) {
    final thumbnailUrl =
        post.images.isNotEmpty ? post.images.first.thumbnailUrl : null;
    return PostSummary(
      id: post.id,
      title: post.title,
      price: post.price,
      createdAt: post.createdAt,
      thumbnailUrl: thumbnailUrl,
    );
  }
}
