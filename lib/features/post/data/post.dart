import 'package:image_picker/image_picker.dart';

enum TradeType { sell, share }

class PostDraft {
  PostDraft({
    required this.title,
    this.content,
    List<XFile>? images,
    required this.price,
    required this.tradeType,
  }) : images = images ?? [];

  String title;
  String? content;
  List<XFile> images;
  int price;
  TradeType tradeType;
}

class Post {
  Post({
    required this.id,
    required this.title,
    this.content,
    this.imageUrls = const [],
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.tradeType,
  }) : favorites = 0,
       views = 0;

  final String id;
  final String title;
  final String? content;
  final List<String> imageUrls;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TradeType tradeType;

  int favorites;
  int views;

  Post copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? imageUrls,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    TradeType? tradeType,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tradeType: tradeType ?? this.tradeType,
    );
  }

  void incrementFavorites() => favorites++;
  void incrementViews() => views++;
}
