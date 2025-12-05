// dart
import 'dart:typed_data';

// feature
import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/core/enums/post_status.dart';
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/core/models/meeting_location.dart';
import 'package:clozii/features/post/domain/entities/post.dart';

class PostDraft {
  PostDraft({
    required this.title,
    required this.content,
    required this.originImages,
    required this.thumbnailImages,
    required this.price,
    required this.tradeType,
    this.meetingLocation,
  });

  String title;
  String content;
  List<Uint8List?> originImages;
  List<Uint8List?> thumbnailImages;
  int price;
  TradeType tradeType;
  MeetingLocation? meetingLocation;

  Post toPost({
    required String id,
    required DateTime now,
    required String authorUid,
    required String authorNickname,
    Uint8List? authorProfileImage,
  }) {
    return Post(
      id: id,
      title: title,
      content: content,
      images: [], // 빈 리스트 (실제 업로드 후 URL로 채워짐)
      price: price,
      createdAt: now,
      updatedAt: now,
      tradeType: tradeType,
      postStatus: PostStatus.selling,
      category: PostCategory.freeGiveaway,
      meetingLocation: meetingLocation,
      authorUid: authorUid,
      authorNickname: authorNickname,
      authorProfileImage: authorProfileImage,
    );
  }
}
