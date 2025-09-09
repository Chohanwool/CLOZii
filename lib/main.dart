import 'package:flutter/material.dart';
import 'package:clozii/core/theme/theme.dart';

// onBoarding
import 'package:clozii/features/onBoarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(const CLOZii());
}

class CLOZii extends StatelessWidget {
  const CLOZii({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: OnBoardingScreen(),
    );
  }
}
