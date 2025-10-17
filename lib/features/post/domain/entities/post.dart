// feature
import 'package:clozii/features/post/core/enums/trade_type.dart';

class Post {
  Post({
    required this.id,
    required this.title,
    required this.content,
    required List<String> originImageUrls,
    required List<String> thumbnailImageUrls,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.tradeType,
    this.detailAddress,
    this.meetingPointLat,
    this.meetingPointLong,
  }) : originImageUrls = List.unmodifiable(originImageUrls),
       thumbnailImageUrls = List.unmodifiable(thumbnailImageUrls),
       favorites = 0,
       views = 0;

  final String id;
  final String title;
  final String content;
  final List<String> originImageUrls;
  final List<String> thumbnailImageUrls;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TradeType tradeType;
  final String? detailAddress;
  final double? meetingPointLat;
  final double? meetingPointLong;

  int favorites;
  int views;

  Post copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? originImageUrls,
    List<String>? thumbnailImageUrls,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    TradeType? tradeType,
    String? detailAddress,
    double? meetingPointLat,
    double? meetingPointLong,
    int? favorites,
    int? views,
  }) {
    final post = Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      originImageUrls: originImageUrls ?? this.originImageUrls,
      thumbnailImageUrls: thumbnailImageUrls ?? this.thumbnailImageUrls,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tradeType: tradeType ?? this.tradeType,
      detailAddress: detailAddress ?? this.detailAddress,
      meetingPointLat: meetingPointLat ?? this.meetingPointLat,
      meetingPointLong: meetingPointLong ?? this.meetingPointLong,
    );
    post.favorites = favorites ?? this.favorites;
    post.views = views ?? this.views;
    return post;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'originImageUrls': originImageUrls,
    'thumbnailImageUrls': thumbnailImageUrls,
    'price': price,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'tradeType': tradeType.name,
    'detailAddress': detailAddress,
    'meetingPointLat': meetingPointLat,
    'meetingPointLong': meetingPointLong,
    'favorites': favorites,
    'views': views,
  };

  void incrementFavorites() => favorites++;
  void incrementViews() => views++;
}
