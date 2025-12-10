import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clozii/features/post/application/dummies/dummy_posts.dart';
import 'package:clozii/features/post/data/models/post_model.dart';

/// 더미 게시글 데이터를 Firestore에 업로드하는 함수
///
/// 개발/테스트 용도로만 사용하세요.
/// 이미 존재하는 게시글 ID는 덮어쓰게 됩니다.
Future<void> seedDummyPostsToFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();

  print('🌱 Seeding ${dummyPosts.length} dummy posts to Firestore...');

  for (final post in dummyPosts) {
    final postModel = PostModel.fromEntity(post);
    final jsonPost = postModel.toJson();

    // 더미 데이터의 createdAt, updatedAt을 그대로 사용
    // (서버 타임스탬프 대신 더미 데이터의 시간 유지)
    jsonPost['createdAt'] = Timestamp.fromDate(post.createdAt!);
    jsonPost['updatedAt'] = Timestamp.fromDate(post.updatedAt!);

    final docRef = firestore.collection('posts').doc(post.id);
    batch.set(docRef, jsonPost);

    print('  ✓ Adding post: ${post.id} - ${post.title}');
  }

  try {
    await batch.commit();
    print('✅ Successfully seeded ${dummyPosts.length} posts!');
  } catch (e) {
    print('❌ Failed to seed posts: $e');
    rethrow;
  }
}
