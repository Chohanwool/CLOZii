import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/presentation/states/image_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostCreateState {
  static int get maxImageCount => 5;

  // 사용자 입력 데이터
  final String title;
  final String content;
  final TradeType tradeType;
  final int price;
  final String? detailAddress;
  final LatLng? meetingPoint;
  final Map<String, ImageState> selectedImages;

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
    this.detailAddress,
    this.meetingPoint,
    this.selectedImages = const {},
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
    String? detailAddress,
    LatLng? meetingPoint,
    Map<String, ImageState>? selectedImages,
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
      detailAddress: detailAddress ?? this.detailAddress,
      meetingPoint: meetingPoint ?? this.meetingPoint,
      selectedImages: selectedImages ?? this.selectedImages,
      showGoToPhrases: showGoToPhrases ?? this.showGoToPhrases,
      showAddPhraseModal: showAddPhraseModal ?? this.showAddPhraseModal,
      showMoreOptions: showMoreOptions ?? this.showMoreOptions,
      currentPhraseForEdit: currentPhraseForEdit,
    );
  }
}
