import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/post/provider/selected_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FullScreenImageViewer extends ConsumerWidget {
  const FullScreenImageViewer({super.key, required this.assetId});

  final String assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final originBytes = ref
        .read(selectedImageProvider.notifier)
        .getOrigin(assetId);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Center(
        child: originBytes != null
            ? Image.memory(originBytes, fit: BoxFit.contain)
            : Placeholder(),
      ),
    );
  }
}
