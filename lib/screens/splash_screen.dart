import 'package:flutter/material.dart';
import 'package:frontend/utils/systembar_utils.dart';
import 'package:frontend/utils/checkuser_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  }
  
  class _SplashScreenState extends State<SplashScreen> 
  with SingleTickerProviderStateMixin {

    String fullText = "Lets,eat";
    String displayedText = "";
    int index = 0;

    late AnimationController controller;
    late Animation<double> positionAnimation;
    late Animation<double> opacityAnimation;
      
    @override
    void initState(){
      super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_){
        SystembarUtil.setSystemBar(context);
      });

      controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3),
        );

        positionAnimation = Tween<double>(
          begin: 1,
          end: 0.4)
          .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOut),
        );

        opacityAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeIn),
        );
        controller.forward();

        controller.addStatusListener((status) {
         if (status == AnimationStatus.completed) {
           startTyping();
           WidgetsBinding.instance.addPostFrameCallback((_){
            if(!mounted) return;
            CheckuserUtils.checkUser(context);
           });    // typing animation starts after logo stops
         }
       });


    }
     Future<void> startTyping() async {
       for (int i = 0; i < fullText.length; i++) {
         await Future.delayed(const Duration(milliseconds: 80));
         
          if (!mounted) return;
          setState(() {
             displayedText = fullText.substring(0, i + 1);
            });
       }
      /*  await Future.delayed(const Duration(seconds: 1));

         if (!mounted) return;

         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );*/
     }


    @override
    void dispose(){
      controller.dispose();
      super.dispose();
    }
    
    @override
    Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;


    return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: AnimatedBuilder(
      animation: controller,
      builder: (context , child){
        return Stack(
          children: [
              Positioned(
              top: screenHeight * positionAnimation.value,
              left: screenWidth * 0.35,
              child: SizedBox(
                width: screenWidth *0.3,
                  child: ClipOval(
                  child: Image.asset("assets/images/logo.png",fit: BoxFit.cover,),
                ),
              ),
            ),
          
            Positioned(
             top: (screenHeight * positionAnimation.value) + (screenWidth * 0.3) + 20,
             left: screenWidth * 0.35,
             child: Opacity(
               opacity: opacityAnimation.value,
                child: Text(
                  displayedText, // typing wala text
                   style: TextStyle(
                   fontFamily: "Poppins",
                   fontSize: screenHeight * 0.02,
                   fontWeight: FontWeight.bold,
                   color: Colors.black,
                 ),
               ),
             ),
            ),
          ],
        );
      }),
    ),
   );
  }
}