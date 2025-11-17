import 'package:flutter/material.dart';
import 'package:clozii/core/constants/app_constants.dart';

ColorScheme buildCloziiLightScheme() {
  final base = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  );

  return base.copyWith(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFFFD6D0), // 살짝 연한 컨테이너
    onPrimaryContainer: const Color(0xFF5B1A1A),

    secondary: const Color.fromARGB(255, 255, 230, 226),
    onSecondary: const Color(0xFF4A2020), // 어두운 갈색/빨강 - 더 나은 대비
    secondaryContainer: const Color.fromARGB(255, 255, 244, 244),
    onSecondaryContainer: const Color(0xFF4A2020),

    tertiary: const Color.fromARGB(255, 116, 255, 121), // 포인트(링크/배지 등)
    onTertiary: Colors.white,
    tertiaryContainer: const Color.fromARGB(255, 176, 251, 199),
    onTertiaryContainer: const Color.fromARGB(255, 20, 80, 63),

    surface: Colors.white,
    onSurface: Colors.black87,
    surfaceContainerHighest: const Color(0xFFF6F6F6), // 카드/시트 배경에 쓰기 좋음
    onSurfaceVariant: Colors.black54,

    outline: const Color(0xFFDDDDDD),
    outlineVariant: const Color(0xFFEAEAEA),

    error: const Color(0xFFBA1A1A),
    onError: Colors.white,

    // 토스트/스낵바 대비용
    inverseSurface: const Color(0xFF121212),
    onInverseSurface: Colors.white,

    shadow: Colors.black.withOpacity(0.1),
    scrim: Colors.black.withOpacity(0.3),
  );
}

ColorScheme buildCloziiDarkScheme() {
  final base = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
  );

  return base.copyWith(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFF7A2C2C),
    onPrimaryContainer: const Color(0xFFFFE9E7),

    secondary: AppColors.secondary,
    onSecondary: Colors.black,
    secondaryContainer: const Color(0xFF5A4040),
    onSecondaryContainer: const Color(0xFFFFEAE5),

    tertiary: const Color(0xFF9DB4E5),
    onTertiary: const Color(0xFF10213F),
    tertiaryContainer: const Color(0xFF2C3E64),
    onTertiaryContainer: const Color(0xFFDDE7FF),

    surface: AppColors.brandNeutralSurfaceDark,
    onSurface: Colors.white70,
    surfaceContainerHighest: const Color(0xFF2A2A2A),
    onSurfaceVariant: Colors.white60,

    outline: const Color(0xFF3A3A3A),
    outlineVariant: const Color(0xFF2E2E2E),

    error: const Color(0xFFFF5449),
    onError: Colors.black,

    inverseSurface: Colors.white,
    onInverseSurface: Colors.black,

    shadow: Colors.black.withOpacity(0.6),
    scrim: Colors.black.withOpacity(0.5),
  );
}
