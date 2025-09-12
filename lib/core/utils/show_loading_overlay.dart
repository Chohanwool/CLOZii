import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';

OverlayEntry showLoadingOverlay(BuildContext context, {bool dim = false}) {
  final overlay = OverlayEntry(
    builder: (_) => Stack(
      children: [
        if (dim)
          // 화면 입력 막고 반투명 딤 처리
          const ModalBarrier(dismissible: false, color: Colors.black12),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              const SizedBox(height: 6.0),
              Text(
                'loading...',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  Overlay.of(context, rootOverlay: true).insert(overlay);
  return overlay;
}
