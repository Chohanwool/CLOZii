import 'package:flutter/material.dart';

class MyTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('My'));
  }
}
