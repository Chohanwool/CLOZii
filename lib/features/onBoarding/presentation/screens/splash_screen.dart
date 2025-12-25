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
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // 1. 최소 대기 시간 (브랜딩/애니메이션 노출용)
    final minSplashTime = Future.delayed(const Duration(seconds: 1));

    // 2. 실제 앱 초기화 로직 (여기서는 시뮬레이션)
    // 실제로는 API 호출, 버전 체크, SharedPrefs 로드, Firebase 설정 등이 들어갑니다.
    final appInit = _performInitialization();

    // 두 작업이 모두 끝날 때까지 대기
    await Future.wait([minSplashTime, appInit]);

    if (mounted) {
      _navigateToAuthGate();
    }
  }

  Future<void> _performInitialization() async {
    // TODO: 실제 초기화 로직이 있다면 여기서 수행 (예: await checkAppVersion();)
    return;
  }

  void _navigateToAuthGate() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const AuthGate();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
