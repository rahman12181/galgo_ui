import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/onboarding_mainscreen.dart';
import 'package:frontend/screens/splash_screen.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const GlgoApp());
}



class GlgoApp extends StatelessWidget {
  const GlgoApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "GalGo",
    theme: ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,                      //light-> dark icon
          systemNavigationBarIconBrightness: Brightness.dark,   
        ),
      )
    ),

    darkTheme: ThemeData(
      brightness: Brightness.dark,

      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      )
    ),

    routes: {
      '/home' : (context) => OnboardingMainScreen(),
    },

    themeMode: ThemeMode.system,
    home: SplashScreen(),

   );
  }
}