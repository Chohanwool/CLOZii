// core
import 'package:clozii/core/theme/theme.dart';
// import 'package:clozii/features/post/application/seed_dummy_posts.dart';

// APIs
import 'package:flutter_riverpod/flutter_riverpod.dart';

// firebase
import 'package:clozii/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:clozii/features/onBoarding/presentation/screens/splash_screen.dart';

// packages
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// 🌱 더미 데이터 업로드 (필요할 때만 주석 해제)
  // await seedDummyPostsToFirestore();

  runApp(const ProviderScope(child: CLOZii()));
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
      home: SplashScreen(),
    );
  }
}
