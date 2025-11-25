import 'dart:async';
import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/features/auth/presentation/screens/auth_gate.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthGate();
  }

  void _navigateToAuthGate() {
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const AuthGate();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  // FadeIn for next screen
                  final fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  );

                  // FadeOut for current screen
                  final fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
                    CurvedAnimation(
                      parent: secondaryAnimation,
                      curve: Curves.easeOut,
                    ),
                  );

                  return FadeTransition(
                    opacity: fadeIn, // LoginScreen: fade in
                    child: FadeTransition(
                      opacity: fadeOut, // OnBoarding: fade out
                      child: child,
                    ),
                  );
                },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.splashGradientStart,
              AppColors.splashGradientMiddle,
              AppColors.splashGradientEnd,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // 로고 이미지 중앙 배치
            Center(
              child: Image.asset(
                AppConstants.appSplashLogo,
                width: MediaQuery.of(context).size.width * 3 / 4,
              ),
            ),

            // 버블 효과 - 오른쪽 상단
            Positioned(
              top: -40,
              right: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),

            // 버블 효과 - 왼쪽 하단
            Positioned(
              bottom: -40,
              left: -40,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
