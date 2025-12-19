// Post model for data layer
// Data Layer: JSON 직렬화를 담당하는 모델

import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clozii/features/post/core/enums/post_category.dart';
import 'package:clozii/features/post/core/enums/post_status.dart';
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/domain/value_objects/image_urls.dart';
import 'package:clozii/features/post/domain/value_objects/meeting_location.dart';
import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:clozii/features/post/data/models/timestamp_converter.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
sealed class PostModel with _$PostModel {
  const PostModel._();

  factory PostModel({
    required String id,
    required String title,
    required String content,
    required List<String> originImageUrls, // Firebase Storage URLs
    required List<String> thumbnailImageUrls, // Firebase Storage URLs
    required int price,
    required String tradeType, // enum을 string으로 저장
    required String postStatus, // enum을 string으로 저장
    required String category, // enum을 string으로 저장
    double? meetingLatitude,
    double? meetingLongitude,
    String? meetingDetailAddress,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @Default(0) int favorites,
    @Default(0) int views,
    required String authorUid,
    required String authorNickname,
    String? authorProfileImageUrl, // Firebase Storage URL
  }) = _PostModel;

  // JSON 직렬화 (freezed가 자동 생성: fromJson, toJson)
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  // Algolia용 JSON 변환 (_geoloc 포함)
  Map<String, dynamic> toJsonWithGeoloc() {
    final json = toJson(); // freezed가 생성한 toJson() 호출

    // Algolia 지오 검색을 위한 _geoloc 필드 추가
    if (meetingLatitude != null && meetingLongitude != null) {
      json['_geoloc'] = {
        'lat': meetingLatitude,
        'lng': meetingLongitude,
      };
    }

    return json;
  }

  // Domain Entity → Data Model 변환 (수동 작성)
  factory PostModel.fromEntity(
    Post entity, {
    String? authorProfileImageUrl,
  }) {
    // Post의 ImageUrls에서 URL 추출
    final originUrls = entity.images.map((img) => img.originUrl).toList();
    final thumbnailUrls = entity.images.map((img) => img.thumbnailUrl).toList();

    return PostModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      originImageUrls: originUrls,
      thumbnailImageUrls: thumbnailUrls,
      price: entity.price,
      tradeType: entity.tradeType.name,
      postStatus: entity.postStatus.name,
      category: entity.category.name,
      meetingLatitude: entity.meetingLocation?.latitude,
      meetingLongitude: entity.meetingLocation?.longitude,
      meetingDetailAddress: entity.meetingLocation?.detailAddress,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      favorites: entity.favorites,
      views: entity.views,
      authorUid: entity.authorUid,
      authorNickname: entity.authorNickname,
      authorProfileImageUrl: authorProfileImageUrl,
    );
  }

  // Data Model → Domain Entity 변환
  Post toEntity({
    Uint8List? authorProfileImage,
  }) {
    // PostModel의 URL 리스트에서 ImageUrls 객체 생성
    final images = List.generate(
      originImageUrls.length,
      (i) => ImageUrls(
        originUrl: originImageUrls[i],
        thumbnailUrl: thumbnailImageUrls[i],
      ),
    );

    // MeetingLocation 객체 재구성 (모든 필드가 있을 때만)
    MeetingLocation? meetingLocation;
    if (meetingLatitude != null &&
        meetingLongitude != null &&
        meetingDetailAddress != null) {
      meetingLocation = MeetingLocation(
        latitude: meetingLatitude!,
        longitude: meetingLongitude!,
        detailAddress: meetingDetailAddress!,
      );
    }

    return Post(
      id: id,
      title: title,
      content: content,
      images: images,
      price: price,
      tradeType: TradeType.values.firstWhere((e) => e.name == tradeType),
      postStatus: PostStatus.values.firstWhere((e) => e.name == postStatus),
      category: PostCategory.values.firstWhere((e) => e.name == category),
      meetingLocation: meetingLocation,
      createdAt: createdAt,
      updatedAt: updatedAt,
      favorites: favorites,
      views: views,
      authorUid: authorUid,
      authorNickname: authorNickname,
      authorProfileImage: authorProfileImage,
    );
  }
}
