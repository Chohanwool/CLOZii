import 'package:flutter/material.dart';

class TabPageConfig {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const TabPageConfig({
    required this.appBar,
    required this.body,
  });
}
