import 'package:clozii/features/home/presentation/screens/home_screen.dart';
import 'package:clozii/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:clozii/core/theme/theme.dart';

// onBoarding
import 'package:clozii/features/onBoarding/presentation/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          debugPrint('StreamBuilder 상태: ${snapshot.connectionState}');
          debugPrint('StreamBuilder 데이터: ${snapshot.hasData}');
          debugPrint('StreamBuilder 에러: ${snapshot.hasError}');

          if (snapshot.hasData) {
            debugPrint('로그인 상태 - HomeScreen으로 이동');
            return HomeScreen();
          } else {
            debugPrint('비로그인 상태 - OnBoardingScreen으로 이동');
            return OnBoardingScreen();
          }
        },
      ),
    );
  }
}
