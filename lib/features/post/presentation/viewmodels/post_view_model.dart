import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostViewModel extends Notifier<Post?> {
  Post? initialPost;

  PostViewModel([this.initialPost]); // 생성자에서 초기 post 받기

  @override
  Post? build() {
    return initialPost; // 초기값 세팅
  }
}
