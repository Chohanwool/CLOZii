import 'package:flutter/material.dart';

Route<T> fadeInRoute<T>(
  Widget page, {
  Duration d = const Duration(milliseconds: 200),
}) {
  return PageRouteBuilder<T>(
    transitionDuration: d,
    reverseTransitionDuration: d,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
