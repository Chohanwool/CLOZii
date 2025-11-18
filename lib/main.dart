// core
import 'package:clozii/core/data/adapters/lat_lng_adapters.dart';
import 'package:clozii/core/theme/theme.dart';
import 'package:clozii/features/post/core/enums/trade_type.dart';
import 'package:clozii/features/post/core/models/image_data.dart';
import 'package:clozii/features/post/core/models/meeting_location.dart';
import 'package:clozii/features/post/presentation/states/post_create_state.dart';

// APIs
import 'package:flutter_riverpod/flutter_riverpod.dart';

// firebase
import 'package:clozii/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// screens
import 'package:clozii/presentation/screens/home_screen.dart';
import 'package:clozii/features/onBoarding/presentation/screens/onboarding_screen.dart';

// packages
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialize Hive
  await Hive.initFlutter();

  // register adapters
  Hive.registerAdapter(ImageDataAdapter());
  Hive.registerAdapter(MeetingLocationAdapter());
  Hive.registerAdapter(LatLngAdapter());
  Hive.registerAdapter(PostCreateStateAdapter());
  Hive.registerAdapter(TradeTypeAdapter());

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
            // return HomeScreen();
            return OnBoardingScreen();
          }
        },
      ),
    );
  }
}
