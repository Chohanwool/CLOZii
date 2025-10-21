class PostUpdate {
  // optional 필드 사용으로 부분 수정 가능
  // TODO: 필요시 이미지, 가격 등 수정할 필드 추가
  final String? title;
  final String? content;

  PostUpdate({this.title, this.content});
}
