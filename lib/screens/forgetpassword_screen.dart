import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/animations.dart/slide_animation.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/otp_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:http/http.dart';

class ForgetpasswordScreen extends StatefulWidget {
  const ForgetpasswordScreen({super.key});

  @override
  State<ForgetpasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetpasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isloading=false;
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SlideAnimation(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "GalGo",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: "poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.15),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                       Text(
                        textAlign: TextAlign.center,
                          "Enter your email to reset your \naccount password",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "poppins",
                            color: const Color.fromARGB(255, 134, 133, 133),
                          ),
                        ),
                      
                      SizedBox(height: screenHeight*0.06,),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 12,
                                ),
                                prefix: Icon(Icons.email_rounded,size: 17,),
                                labelText: "email",
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "poppins",
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 52, 169, 232),
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                  ? "email required"
                                  : !value.endsWith("@gmail.com")
                                  ? "invalid email address"
                                  : null,
                            ),
                            SizedBox(height: screenHeight*0.04),
                            ElevatedButton(
                              onPressed: _isloading 
                              ? null :()async{

                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                setState(() {
                                  _isloading=true;
                                });
                                try {
                                  final auth =AuthService();
                                  final forgetPasswordResponse=await auth.forgotPassword(
                                    email: _emailController.text.trim(),
                                  );
                                  if(!mounted) return;
                                  if (forgetPasswordResponse["status"]==true) {
                                    setState(() {
                                      _isloading=true;
                                    });
                                    if(!mounted) return;
                                    final email=_emailController.text.trim();
                                    Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => OtpScreen(email: email)),
                                    (route) =>false);

                                  }else{
                                    if(!mounted) return;
                                    setState(() {
                                      _isloading=false;
                                    });
                                    if(!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(forgetPasswordResponse["message"] ?? "failed to reset",style: TextStyle(fontSize: 14,fontFamily: "poppins"),),
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(17),
                                      backgroundColor: const Color.fromARGB(255, 52, 169, 232),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusGeometry.circular(17)
                                      ),
                                      duration: Duration(seconds: 2),
                                      )
                                    );
                                  }
                                  
                                } catch (e) {
                                   setState(() {
                                     _isloading=false;
                                   });

                                   if(!mounted) return;

                                   ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error :$e",style: TextStyle(fontSize: 15, fontFamily: "poppins"),),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(17),
                                    backgroundColor: const Color.fromARGB(255, 52, 169, 232),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(17),
                                    ),
                                    duration: Duration(seconds: 2),
                                    )
                                   );
                                }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 52, 169, 232),
                              minimumSize: Size(screenWidth*0.9, screenHeight*0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15), 
                              )
                            ),
                             child: _isloading ? CircularProgressIndicator(color: Colors.white,) 
                             :Text(
                              "continue",
                               style: TextStyle(
                                fontSize: 15,
                                fontFamily: "poppins",
                                color: Colors.black,
                                ),
                              )
                            ),
                            SizedBox(height: screenHeight*0.05,),
                            Align(
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Remember Password?",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "poppins",
                                        color: Colors.black,
                                      ), 
                                    ),
                                    TextSpan(
                                      text: "Log In",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "poppins",
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(255, 52, 169, 232),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                      ..onTap=(){
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginScreen()));
                                      }
                                    )
                                  ]
                                )),
                            )
                          ],
                        ),
                      ),
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
