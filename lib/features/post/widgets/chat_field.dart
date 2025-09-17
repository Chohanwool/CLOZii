import 'package:clozii/core/theme/context_extension.dart';
import 'package:flutter/material.dart';

class ChatField extends StatefulWidget {
  const ChatField({super.key});

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  bool _readOnly = true;

  void _onTap() {
    setState(() {
      _readOnly = false;
    });
  }

  void _onTapOutside(PointerDownEvent _) {
    setState(() {
      _readOnly = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: _readOnly,
      onTap: _onTap,
      onTapOutside: _onTapOutside,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: context.colors.shadow,
        hintText: 'Chat message',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
