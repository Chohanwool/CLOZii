import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/price_slider.dart';
import 'package:flutter/material.dart';

Future<bool?> showPriceRangeDialog({
  required BuildContext context,
  required double minValue,
  required double maxValue,
}) {
  return showDialog<bool>(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Price range',
                  style: context.textTheme.titleSmall,
                ),
              ),
              const Divider(),
              const SizedBox(height: 8.0),
              Text(
                'Select your price range',
                style: context.textTheme.bodyMedium,
              ),
              PriceSlider(
                minValue: minValue,
                maxValue: maxValue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('CANCEL'),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('APPLY'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
