// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
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
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  tradeType: $enumDecode(_$TradeTypeEnumMap, json['tradeType']),
  detailAddress: json['detailAddress'] as String?,
  meetingPointLat: (json['meetingPointLat'] as num?)?.toDouble(),
  meetingPointLong: (json['meetingPointLong'] as num?)?.toDouble(),
  favorites: (json['favorites'] as num?)?.toInt() ?? 0,
  views: (json['views'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'originImageUrls': instance.originImageUrls,
  'thumbnailImageUrls': instance.thumbnailImageUrls,
  'price': instance.price,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'tradeType': _$TradeTypeEnumMap[instance.tradeType]!,
  'detailAddress': instance.detailAddress,
  'meetingPointLat': instance.meetingPointLat,
  'meetingPointLong': instance.meetingPointLong,
  'favorites': instance.favorites,
  'views': instance.views,
};

const _$TradeTypeEnumMap = {TradeType.sell: 'sell', TradeType.share: 'share'};
