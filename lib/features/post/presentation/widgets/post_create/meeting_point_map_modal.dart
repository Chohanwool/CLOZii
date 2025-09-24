import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/features/post/presentation/widgets/post_create/apple_map.dart';
import 'package:flutter/material.dart';

class MeetingPointMapModal extends StatelessWidget {
  const MeetingPointMapModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(child: AppleMap()),
        ],
      ),
    );
  }
}
