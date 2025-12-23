import 'package:flutter/material.dart';

class MapTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MapTabAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('Map'));
  }
}
