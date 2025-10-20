import 'package:flutter/material.dart';

// core
import 'package:clozii/core/theme/theme.dart';

// APIs
import 'package:flutter_riverpod/flutter_riverpod.dart';

// firebase
import 'package:clozii/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// screens
import 'package:clozii/features/home/presentation/screens/home_screen.dart';
import 'package:clozii/features/onBoarding/presentation/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            // return OnBoardingScreen();
            // 로그인 구현 전 임시로 항상 메인 화면에 접근 가능하도록 설정
            return HomeScreen();
          }
        },
      ),
    );
  }
}
