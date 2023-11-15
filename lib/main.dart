import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/services/navigation_services.dart';
import 'core/utils/colors.dart';
import 'core/utils/routes.dart';
import 'core/utils/strings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Device can only stay in portrait mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: UCPSApp()));
}

class UCPSApp extends HookConsumerWidget {
  const UCPSApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: UCPSColors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        primarySwatch: UCPSColors.primarysWatch,
        scaffoldBackgroundColor: UCPSColors.white,
        splashColor: UCPSColors.lightGrey,
      ),
      // home: const HomePage(
      //   title: 'Home',
      // ),
      initialRoute: () {
        if (FirebaseAuth.instance.currentUser != null) {
          // FlutterNativeSplash.remove();
          return Routes.sideNavPages;
        } else {
          // FlutterNativeSplash.remove();
          return Routes.login;
        }
      }(),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: ref.read(navigationService).navigatorKey,
    );
  }
}
