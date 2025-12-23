import 'package:flutter/material.dart';

class ChatTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatTabAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('Chat'));
  }
}
