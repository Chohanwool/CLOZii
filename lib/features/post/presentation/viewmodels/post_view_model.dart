import 'package:clozii/features/post/domain/entities/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostViewModel extends Notifier<Post?> {
  @override
  build() => null;

  void setPost(Post post) {
    state = post;
  }

  void clearPost() {
    state = null;
  }
}
