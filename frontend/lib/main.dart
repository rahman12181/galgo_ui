import 'package:flutter/material.dart';
import 'package:frontend/screens/splash_screen.dart';

void main(){
  runApp(GlgoApp());
}

class GlgoApp extends StatelessWidget {
  const GlgoApp({super.key});


  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "GalGo",
    theme: ThemeData(
      primarySwatch: Colors.blue,
      buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
      )
    ),
    home:SplashScreen() ,
   );
  }
}