import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/core/models/image_data.dart';
import 'package:clozii/features/post/core/models/meeting_location.dart';
import 'package:hive/hive.dart';

part 'post_create_state.g.dart';

@HiveType(typeId: 3)
class PostCreateState {
  static int get maxImageCount => 5;

  // 사용자 입력 데이터
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final TradeType tradeType;

  @HiveField(3)
  final int price;

  @HiveField(4)
  final MeetingLocation? meetingLocation;

  @HiveField(5)
  final Map<String, ImageData> selectedImages;

  // 모든 필드 입력에 대한 검증 성공 여부
  final bool isAllValid;

  // 모달 상태
  final bool showGoToPhrases;
  final bool showAddPhraseModal;
  final bool showMoreOptions;
  final String? currentPhraseForEdit;

  const PostCreateState({
    this.title = '',
    this.content = '',
    this.tradeType = TradeType.sell,
    this.price = 0,
    this.meetingLocation,
    this.selectedImages = const {},
    this.isAllValid = false,
    this.showGoToPhrases = false,
    this.showAddPhraseModal = false,
    this.showMoreOptions = false,
    this.currentPhraseForEdit,
  });

  PostCreateState copyWith({
    String? title,
    String? content,
    TradeType? tradeType,
    int? price,
    MeetingLocation? meetingLocation,
    Map<String, ImageData>? selectedImages,
    bool? isAllValid,
    bool? showGoToPhrases,
    bool? showAddPhraseModal,
    bool? showMoreOptions,
    String? currentPhraseForEdit,
  }) {
    return PostCreateState(
      title: title ?? this.title,
      content: content ?? this.content,
      tradeType: tradeType ?? this.tradeType,
      price: price ?? this.price,
      meetingLocation: meetingLocation ?? this.meetingLocation,
      selectedImages: selectedImages ?? this.selectedImages,
      isAllValid: isAllValid ?? this.isAllValid,
      showGoToPhrases: showGoToPhrases ?? this.showGoToPhrases,
      showAddPhraseModal: showAddPhraseModal ?? this.showAddPhraseModal,
      showMoreOptions: showMoreOptions ?? this.showMoreOptions,
      currentPhraseForEdit: currentPhraseForEdit,
    );
  }
}
