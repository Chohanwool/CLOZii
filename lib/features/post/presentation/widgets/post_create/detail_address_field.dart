import 'package:clozii/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DetailAddressField extends StatelessWidget {
  const DetailAddressField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,

      autofocus: true,
      decoration: InputDecoration(
        hintText: 'ex. infront of McDonald\'s Laguna Bel-Air',

        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black54),
        ),
      ),
    );
  }
}
