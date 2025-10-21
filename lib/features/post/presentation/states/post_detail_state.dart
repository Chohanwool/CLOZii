class PostDetailState {
  // 스크롤 관련 상태
  final bool isExpanded;
  final double stretchOffset;

  const PostDetailState({this.isExpanded = true, this.stretchOffset = 0.0});

  PostDetailState copyWith({bool? isExpanded, double? stretchOffset}) {
    return PostDetailState(
      isExpanded: isExpanded ?? this.isExpanded,
      stretchOffset: stretchOffset ?? this.stretchOffset,
    );
  }
}
