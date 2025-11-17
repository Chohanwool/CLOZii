import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  String? message,
  String? extraMessage,
  Widget? customContent,
}) {
  final defaultContent = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (message != null) Text(message),
      if (extraMessage != null) ...[
        const SizedBox(height: 5.0),
        Text(extraMessage),
      ],
    ],
  );

  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: customContent ?? defaultContent,
      ),
    );
}
