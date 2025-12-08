import 'package:clozii/features/post/domain/value_objects/image_urls.dart';

class UploadResult {
  final String id;
  final List<ImageUrls> imageUrls;

  const UploadResult({required this.id, required this.imageUrls});
}
