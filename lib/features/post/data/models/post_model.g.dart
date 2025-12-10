// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      originImageUrls: (json['originImageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      thumbnailImageUrls: (json['thumbnailImageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      price: (json['price'] as num).toInt(),
      tradeType: json['tradeType'] as String,
      postStatus: json['postStatus'] as String,
      category: json['category'] as String,
      meetingLatitude: (json['meetingLatitude'] as num?)?.toDouble(),
      meetingLongitude: (json['meetingLongitude'] as num?)?.toDouble(),
      meetingDetailAddress: json['meetingDetailAddress'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      favorites: (json['favorites'] as num?)?.toInt() ?? 0,
      views: (json['views'] as num?)?.toInt() ?? 0,
      authorUid: json['authorUid'] as String,
      authorNickname: json['authorNickname'] as String,
      authorProfileImageUrl: json['authorProfileImageUrl'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'originImageUrls': instance.originImageUrls,
      'thumbnailImageUrls': instance.thumbnailImageUrls,
      'price': instance.price,
      'tradeType': instance.tradeType,
      'postStatus': instance.postStatus,
      'category': instance.category,
      'meetingLatitude': instance.meetingLatitude,
      'meetingLongitude': instance.meetingLongitude,
      'meetingDetailAddress': instance.meetingDetailAddress,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'favorites': instance.favorites,
      'views': instance.views,
      'authorUid': instance.authorUid,
      'authorNickname': instance.authorNickname,
      'authorProfileImageUrl': instance.authorProfileImageUrl,
    };
