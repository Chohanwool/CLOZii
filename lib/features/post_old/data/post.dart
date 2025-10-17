import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';

enum TradeType { sell, share }

class PostDraft {
  PostDraft({
    required this.title,
    required this.content,
    required this.originImages,
    required this.thumbnailImages,
    required this.price,
    required this.tradeType,
    this.detailAddress,
    this.meetingPoint,
  });

  String title;
  String content;
  List<Uint8List?> originImages;
  List<Uint8List?> thumbnailImages;
  int price;
  TradeType tradeType;
  String? detailAddress;
  LatLng? meetingPoint;

  Post toPost(String id, DateTime now) {
    return Post(
      id: id,
      title: title,
      content: content,
      originImageUrls: [],
      thumbnailImageUrls: [],
      price: price,
      createdAt: now,
      updatedAt: now,
      tradeType: tradeType,
      detailAddress: detailAddress,
      meetingPoint: meetingPoint,
    );
  }
}

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
    this.meetingPoint,
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
  final LatLng? meetingPoint;

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
    LatLng? meetingPoint,
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
      meetingPoint: meetingPoint ?? this.meetingPoint,
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
    'meetingPoint': meetingPoint == null
        ? null
        : {
            'latitude': meetingPoint!.latitude,
            'longitude': meetingPoint!.longitude,
          },
    'favorites': favorites,
    'views': views,
  };

  void incrementFavorites() => favorites++;
  void incrementViews() => views++;
}
