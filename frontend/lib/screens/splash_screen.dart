import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
  }
  
  class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
   return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Container(
        width: screenWidth*0.4,
        height: screenHeight*0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          border: Border.all(color: Colors.black,width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              spreadRadius: 3,
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image.asset(
             "assets/images/logo.png",
              fit: BoxFit.cover,
            ),
        ),
      )
    ),
   );
  }
  }