// core
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';

// features
import 'package:clozii/features/post/presentation/widgets/post_create/apple_map.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/modal/detail_address_modal.dart';

// packages
import 'package:flutter/material.dart';

class MeetingPointMapModal extends StatelessWidget {
  const MeetingPointMapModal({super.key});

  void _showDetailAddressModal(BuildContext context) async {
    final detailAddress = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      builder: (context) => DetailAddressModal(),
    );

    if (detailAddress != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          Navigator.of(context).pop(detailAddress);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 올라와도 UI가 움직이지 않도록 설정
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Drag and locate the marker \nto where you want to meet the buyer.',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Choose an accessible, visible location \nfor a safe transaction.',
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),

          // Map
          Expanded(
            child: Stack(
              children: [
                AppleMap(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 48.0,
                    ),
                    child: CustomButton(
                      text: 'Save',
                      onTap: () => _showDetailAddressModal(context),
                      height: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
