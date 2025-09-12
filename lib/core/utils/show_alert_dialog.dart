import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';

Future<bool?> showAlertDialog(
  BuildContext context,
  String messageBody, {
  String title = 'Notice',
}) {
  final radius = Radius.circular(12.0);

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(radius),
        ),
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  Text(title, style: context.textTheme.titleMedium),
                  const SizedBox(height: 10.0),
                  Text(
                    messageBody,
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40.0,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.only(
                      bottomLeft: radius,
                      bottomRight: radius,
                    ),
                  ),
                  backgroundColor: context.colors.primary,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  'ok',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colors.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
