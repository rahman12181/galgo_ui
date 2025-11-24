import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/onbording_second_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OnboardingScreen(),
  ));
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(1.2, -1.2),
                        radius: 1.2,
                        colors: [
                          Color.fromARGB(255, 106, 234, 243),
                          Colors.transparent,
                        ],
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0.0, 1.5),
                        radius: 1.4,
                        colors:[
                          Color.fromARGB(255, 106, 234, 243),
                          Colors.transparent
                        ], 
                        stops: [0.0, 1.0]
                      )
                    ),
                  ),

                  Positioned(
                    top: 30,
                    left: 20,
                    child: Text(
                      "GalGo",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: "poppins",
                      ),
                    ),
                  ),

                  Center(
                    child: Image.asset(
                      "assets/images/onboardingfirst.png",
                      width: screenWidth * 0.65,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 4,
              child: Transform.translate(                 // CHANGED: overlap effect
                offset: Offset(0, -45),                  // move container up by radius
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.04,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        "All You Need,One App",
                        style: TextStyle(
                          fontSize: screenWidth * 0.068,
                          fontFamily: "poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.018),

                      // Subtitle
                      Text(
                        "From fresh food to daily must-have GalGO brings everything to you-quickly and reliably",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.030,
                          fontFamily: "poppins",
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.06,
                                vertical: screenHeight * 0.015,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15), 
                              ),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 184, 184, 184),
                                width: 1,
                              )
                            ),
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "poppins",
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OnbordingSecondscreen()
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 112, 231, 245),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth*0.06,
                                vertical: screenHeight*0.015,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                              )
                            ),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "poppins"
                              ),
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
