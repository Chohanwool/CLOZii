// core
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/keyboard_aware_button.dart';

// features
import 'package:clozii/features/post_old/presentation/widgets/post_create/fields/detail_address_field.dart';

// packages
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class DetailAddressModal extends StatefulWidget {
  const DetailAddressModal({super.key});

  @override
  State<DetailAddressModal> createState() => _DetailAddressModalState();
}

class _DetailAddressModalState extends State<DetailAddressModal> {
  final TextEditingController _controller = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () => setState(() {
        _isButtonEnabled = _controller.text.trim().isNotEmpty;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter the selected place name.',
                    style: context.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'ex. infront of McDonald\'s Laguna Bel-Air',
                    style: context.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16.0),
                  DetailAddressField(controller: _controller),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),

            KeyboardAwareButton(
              text: 'Save Meeting Point',
              onTap: _isButtonEnabled
                  ? () => Navigator.of(context).pop(_controller.text.trim())
                  : null,
            ),
            if (!isKeyboardVisible) const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
