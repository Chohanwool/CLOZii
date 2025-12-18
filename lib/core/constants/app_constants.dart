import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'CLOZii';
  static const String appSlogan = 'Closer People, Closer Deals';
  static const String appMainLogo = 'assets/images/logo/full_logo/default.png';
  static const String appSplashLogo =
      'assets/images/logo/full_logo/vibrant_duo.png';
  static const String appVersion = '1.0.0';

  // Algolia Search
  static const String algoliaApplicationId = '2S2GJPIBHE';
  static const String algoliaSearchApiKey = 'b5bd77ef76f962acba650a49e92ac76e';
  static const String algoliaIndexName = 'posts';
}

class AppColors {
  // 브랜드 색상
  static const Color primary = Color(0xFFFF8585);
  static const Color secondary = Color(0xFFFFC9C2);
  static const Color tertiary = Color(0xFF607EBC);
  static const brandNeutralSurfaceDark = Color(0xFF1E1E1E);

  // 스플래시 화면 배경 색상
  // Vibrant Duo
  static const Color splashGradientStart = Color(0xFFFFB6B9);
  static const Color splashGradientMiddle = Color(0xFFFFA07A);
  static const Color splashGradientEnd = Color(0xFFFF6B9D);

  // 투명
  static const Color transparent = Colors.transparent;

  // 블랙스케일
  static const Color black = Colors.black;
  static const Color black87 = Colors.black87;
  static const Color black54 = Colors.black54;
  static const Color black38 = Colors.black38;
  static const Color black26 = Colors.black26;
  static const Color black12 = Colors.black12;

  // 그레이스케일
  static const Color gray900 = Color(0xFF1A1A1A);
  static const Color gray800 = Color(0xFF2A2A2A);
  static const Color gray700 = Color(0xFF3A3A3A);
  static const Color gray600 = Color(0xFF4A4A4A);
  static const Color gray500 = Color(0xFF6B6B6B);
  static const Color gray400 = Color(0xFF8A8A8A);
  static const Color gray300 = Color(0xFFAAAAAA);
  static const Color gray200 = Color(0xFFCCCCCC);
  static const Color gray100 = Color(0xFFEEEEEE);
  static const Color gray50 = Color(0xFFFAFAFA);

  // 화이트스케일
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color white60 = Colors.white60;
  static const Color white54 = Colors.white54;
  static const Color white38 = Colors.white38;
  static const Color white30 = Colors.white30;
  static const Color white24 = Colors.white24;
  static const Color white12 = Colors.white12;
  static const Color white10 = Colors.white10;

  // 상태 색상
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  static Color disabled = Colors.black.withAlpha(26);
  static Color disabledText = Colors.black.withAlpha(78);

  // 배경 색상
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF6F6F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8F9FA);

  // 텍스트 색상
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFFAAAAAA);
  static const Color textDisabled = Color(0xFFCCCCCC);

  // 테두리 색상
  static const Color border = Color(0xFFDDDDDD);
  static const Color borderLight = Color(0xFFEAEAEA);
  static const Color borderDark = Color(0xFFBBBBBB);

  // 오버레이 색상
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  // 투명도가 있는 색상들
  static Color get primaryWithOpacity => primary.withOpacity(0.1);
  static Color get secondaryWithOpacity => secondary.withOpacity(0.1);
  static Color get errorWithOpacity => error.withOpacity(0.1);
}
