// Post entity
// Domain Layer: 순수한 비즈니스 엔티티 (외부 패키지 의존 없음)

import 'dart:typed_data';

import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/core/enums/post_status.dart';
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/core/models/image_data.dart';
import 'package:clozii/features/post/core/models/meeting_location.dart';

class Post {
  // 기본 정보
  final String id;
  final String title;
  final String content;
  final List<ImageData> images;

  // 거래 정보
  final int price;
  final TradeType tradeType;
  final PostStatus postStatus;
  final PostCategory category;

  // 위치 정보
  final MeetingLocation? meetingLocation;

  // 메타 정보
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int favorites;
  final int views;

  // 사용자 정보
  final String authorUid;
  final String authorNickname;
  final Uint8List? authorProfileImage;

  const Post({
    required this.id,
    required this.title,
    required this.content,
    required this.images,
    required this.price,
    required this.tradeType,
    required this.postStatus,
    required this.category,
    this.meetingLocation,
    required this.createdAt,
    this.updatedAt,
    this.favorites = 0,
    this.views = 0,
    required this.authorUid,
    required this.authorNickname,
    this.authorProfileImage,
  });

  // toString (디버깅용)
  @override
  String toString() {
    return 'Post(id: $id, title: $title, price: $price, tradeType: $tradeType, '
        'postStatus: $postStatus, category: $category, authorUid: $authorUid, '
        'authorNickname: $authorNickname, favorites: $favorites, views: $views, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
