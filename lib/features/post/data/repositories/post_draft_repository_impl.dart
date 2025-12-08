import 'dart:convert';
import 'dart:io';

import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/domain/value_objects/meeting_location.dart';
import 'package:clozii/features/post/domain/repositories/post_draft_repository.dart';
import 'package:clozii/features/post/presentation/models/image_bytes.dart';
import 'package:clozii/features/post/presentation/providers/post_create/post_create_provider.dart';
import 'package:path_provider/path_provider.dart';

/// JSON 파일 기반 게시글 임시저장 Repository 구현체 (Data Layer)
class PostDraftRepositoryImpl implements PostDraftRepository {
  static const String _draftFileName = 'post_draft.json';

  /// 임시저장 파일 경로 가져오기
  Future<File> _getDraftFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_draftFileName');
  }

  @override
  Future<void> saveDraft(PostCreateState state) async {
    final file = await _getDraftFile();

    // 저장할 필드만 선택 (UI 상태는 제외)
    final draftData = {
      'title': state.title,
      'content': state.content,
      'tradeType': state.tradeType.name,
      'price': state.price,
      'meetingLocation': state.meetingLocation?.toJson(),
      'selectedImages': state.selectedImages.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };

    await file.writeAsString(jsonEncode(draftData));
  }

  @override
  Future<PostCreateState?> loadDraft() async {
    final file = await _getDraftFile();

    if (!await file.exists()) {
      return null;
    }

    try {
      final jsonString = await file.readAsString();
      final json = jsonDecode(jsonString) as Map<String, dynamic>;

      return PostCreateState(
        title: json['title'] as String? ?? '',
        content: json['content'] as String? ?? '',
        tradeType: TradeType.values.firstWhere(
          (e) => e.name == json['tradeType'],
          orElse: () => TradeType.sell,
        ),
        price: json['price'] as int? ?? 0,
        meetingLocation: json['meetingLocation'] != null
            ? MeetingLocation.fromJson(
                json['meetingLocation'] as Map<String, dynamic>,
              )
            : null,
        selectedImages: json['selectedImages'] != null
            ? (json['selectedImages'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(
                  key,
                  ImageBytes.fromJson(value as Map<String, dynamic>),
                ),
              )
            : const {},
      );
    } catch (e) {
      // JSON 파싱 오류 시 null 반환
      return null;
    }
  }

  @override
  Future<void> deleteDraft() async {
    final file = await _getDraftFile();

    if (await file.exists()) {
      await file.delete();
    }
  }
}
