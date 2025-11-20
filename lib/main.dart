import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setEnabledSystemUIMode(
  SystemUiMode.edgeToEdge
  );
SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ),
);


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
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.indigo,
      buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
      )
    ),
    home:SplashScreen() ,
   );
  }
}