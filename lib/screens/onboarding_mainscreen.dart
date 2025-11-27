import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/signup_screen.dart';

class OnboardingMainScreen extends StatefulWidget {
  const OnboardingMainScreen({super.key});

  @override
  State<OnboardingMainScreen> createState() => _OnboardingMainScreenState();
}

class _OnboardingMainScreenState extends State<OnboardingMainScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "All You Need, One App",
      "subtitle":
          "From fresh food to daily must-have GalGO brings everything to you-quickly and reliably",
      "image": "assets/images/carticons.png",
    },
    {
      "title": "Fast Delivery, Anytime",
      "subtitle":
          "Get meals and essentials delivered to your door-12/7, in under 10 minutes",
      "image": "assets/images/delivaryboy.png",
    },
    {
      "title": "Discover App GalGo",
      "subtitle":
          "GalGO is the fast 12/7 delivery app for food in Galgotias university.",
      "image": "assets/images/bag.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: onboardingData.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final data = onboardingData[index];
            return Column(
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
                              colors: [
                                Color.fromARGB(255, 106, 234, 243),
                                Colors.transparent
                              ],
                              stops: [0.0, 1.0]),
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
                          data["image"]!,
                          width: screenWidth * 0.7,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Transform.translate(
                    offset: Offset(0, -25),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.08,
                        vertical: screenHeight * 0.04,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data["title"]!,
                            style: TextStyle(
                              fontSize: screenWidth * 0.068,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.018),
                          Text(
                            data["subtitle"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
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
                                  fixedSize: Size(
                                      screenWidth * 0.35, screenHeight * 0.06),
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
                                  ),
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
                                onPressed: () {
                                  if (index < onboardingData.length - 1) {
                                    _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SignupScreen()));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      screenWidth * 0.35, screenHeight * 0.06),
                                  backgroundColor:
                                      const Color.fromARGB(255, 112, 231, 245),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.06,
                                    vertical: screenHeight * 0.015,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                child: Text(
                                  index == onboardingData.length - 1
                                      ? "Skip"
                                      : "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
