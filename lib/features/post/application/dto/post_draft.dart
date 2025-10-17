// dart
import 'dart:typed_data';

// feature
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/domain/entities/post.dart';

// packages
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      meetingPointLat: meetingPoint?.latitude,
      meetingPointLong: meetingPoint?.longitude,
    );
  }
}
