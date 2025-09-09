import 'package:flutter/material.dart';

const brandPrimary = Color(0xFFFF8585); // CLOZii 메인
const brandSecondary = Color(0xFFFFC9C2); // 보조(살몬 톤)
const brandNeutralSurfaceDark = Color(0xFF1E1E1E);

ColorScheme buildCloziiLightScheme() {
  final base = ColorScheme.fromSeed(
    seedColor: brandPrimary,
    brightness: Brightness.light,
  );

  return base.copyWith(
    primary: brandPrimary,
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFFFD6D0), // 살짝 연한 컨테이너
    onPrimaryContainer: const Color(0xFF5B1A1A),

    secondary: brandSecondary,
    onSecondary: Colors.black,
    secondaryContainer: const Color(0xFFFFE9E5),
    onSecondaryContainer: const Color(0xFF4A2020),

    tertiary: const Color(0xFF607EBC), // 포인트(링크/배지 등)
    onTertiary: Colors.white,
    tertiaryContainer: const Color(0xFFD7E3FF),
    onTertiaryContainer: const Color(0xFF142A50),

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
    seedColor: brandPrimary,
    brightness: Brightness.dark,
  );

  return base.copyWith(
    primary: brandPrimary,
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFF7A2C2C),
    onPrimaryContainer: const Color(0xFFFFE9E7),

    secondary: brandSecondary,
    onSecondary: Colors.black,
    secondaryContainer: const Color(0xFF5A4040),
    onSecondaryContainer: const Color(0xFFFFEAE5),

    tertiary: const Color(0xFF9DB4E5),
    onTertiary: const Color(0xFF10213F),
    tertiaryContainer: const Color(0xFF2C3E64),
    onTertiaryContainer: const Color(0xFFDDE7FF),

    surface: brandNeutralSurfaceDark,
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
