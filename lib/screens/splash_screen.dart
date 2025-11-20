import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
  }
  
  class _SplashScreenState extends State<SplashScreen> 
  with SingleTickerProviderStateMixin {

    String fullText = "Galgotias..";
    String displayedText = "";
    int index = 0;

    late AnimationController controller;
    late Animation<double> positionAnimation;
    late Animation<double> opacityAnimation;
      
    @override
    void initState(){
      super.initState();

      controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
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
           startTyping(); // typing animation starts after logo stops
         }
       });

    }

    void startTyping() {
      for (int i = 0; i < fullText.length; i++) {
        Future.delayed(Duration(milliseconds: 100 * i), () {
          setState(() {
           displayedText = fullText.substring(0, i + 1);
         });

          if (i == fullText.length - 1) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(context, "/home");
           });
         }
       });
     }
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
    extendBody: true,
    backgroundColor: Colors.white,
    body: SafeArea(
      top: true,
      bottom: false,
      child:SizedBox(
      width: double.infinity,
      height: double.infinity,
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
                   fontSize: screenHeight * 0.03,
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
    ),
   );
  }
}