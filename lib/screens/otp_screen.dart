import 'package:flutter/material.dart';
import 'package:frontend/animations.dart/slide_animation.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:frontend/screens/resetpassword_screen.dart';
import 'package:frontend/services/auth_service.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String currentOTP = "";
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SlideAnimation(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Galgo",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenHeight * 0.15),
                      Text(
                        textAlign: TextAlign.center,
                        "Verify Account",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          fontFamily: "poppins",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: ScreenHeight * 0.02),
                      Text(
                        textAlign: TextAlign.center,
                        "Enter the code sent to your\nemail to verify.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "poppins",
                          color: const Color.fromARGB(255, 134, 133, 133),
                        ),
                      ),
                      SizedBox(height: ScreenHeight * 0.04),
                      OtpTextField(
                        numberOfFields: 6,
                        showFieldAsBox: true,
                        borderColor: const Color.fromARGB(255, 52, 169, 232),
                        fieldWidth: ScreenWidth * 0.12,
                        borderRadius: BorderRadius.circular(15),
                        onCodeChanged: (String code) {
                          setState(() {
                            currentOTP = code;
                          });
                        },
                        onSubmit: (String varificationCode) async {
                          setState(() {
                            _isloading = true;
                          });
                          try {
                            if(!mounted) return;
                            final auth = AuthService();
                            final success = await auth.verifyOtp(
                              email: widget.email,
                              otp: varificationCode,
                            );

                            setState(() {
                              _isloading = false;
                            });
                   
                            if (success["status"] == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ResetpasswordScreen(email: widget.email),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    success["message"] ?? "failed to reset",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "poppins",
                                    ),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(17),
                                  backgroundColor: const Color.fromARGB(255,52,169, 232,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      17,
                                    ),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          } catch (e) {
                            if(!mounted)return;
                            
                            setState(() {
                              _isloading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Error $e",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "poppins",
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(17),
                                backgroundColor: const Color.fromARGB(255,52,169, 232, ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    17,
                                  ),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: ScreenHeight*0.05,),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Didn't recive code?",style: TextStyle(
                                fontSize: 12,
                                fontFamily: "poppina",
                                color: Colors.black,
                              )
                            ),
                            TextSpan(
                              text: "Resend Now",style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: "poppins",
                                color: const Color.fromARGB(255, 52, 169, 232),
                              )
                            )
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
