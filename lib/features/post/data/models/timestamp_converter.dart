import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Firestore Timestamp를 DateTime으로 변환하는 JsonConverter
/// - fromJson: Firestore Timestamp → DateTime 변환 (읽기)
/// - toJson: DateTime → null (쓰기 시 서버에서 FieldValue.serverTimestamp() 사용)
class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? dateTime) {
    // 서버에서 FieldValue.serverTimestamp()를 사용하므로 null 반환
    return null;
  }
}
