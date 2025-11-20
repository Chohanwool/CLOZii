import 'package:freezed_annotation/freezed_annotation.dart';

// feature
import 'package:clozii/features/post/core/enums/trade_type.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
sealed class Post with _$Post {
  const Post._();

  const factory Post({
    required String id,
    required String title,
    required String content,
    required List<String> originImageUrls,
    required List<String> thumbnailImageUrls,
    required int price,
    required DateTime createdAt,
    required DateTime updatedAt,
    required TradeType tradeType,
    String? detailAddress,
    double? meetingPointLat,
    double? meetingPointLong,
    @Default(0) int favorites,
    @Default(0) int views,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);

  // Helper methods
  Post incrementFavorites() => copyWith(favorites: favorites + 1);
  Post incrementViews() => copyWith(views: views + 1);
}
