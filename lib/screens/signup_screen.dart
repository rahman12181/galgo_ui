import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/animations.dart/slide_animation.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 120, 20, 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SlideAnimation(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hello!",
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: "poppins",
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Please fill in to sign up new acccount",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "poppins",
                              color: const Color.fromARGB(255, 134, 133, 133),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),

                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            labelText: "Username",
                            prefixIcon: Icon(Icons.person, size: 20),
                            labelStyle: TextStyle(fontSize: 14),
                            floatingLabelStyle: TextStyle(color: Colors.black),
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
                          validator: (value) => (value == null || value.isEmpty)
                              ? "username required"
                              : null,
                        ),
                        SizedBox(height: 35),
                        
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            labelText: "Email address",
                            prefixIcon: Icon(Icons.email_rounded, size: 17),
                            labelStyle: TextStyle(fontSize: 14),
                            floatingLabelStyle: TextStyle(color: Colors.black),
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
                          validator: (value) => (value == null || value.isEmpty)
                              ? "email required"
                              : !value.endsWith("@gmail.com")
                              ? "invalid email address"
                              : null,
                        ),
                        SizedBox(height: 35),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock, size: 18),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            labelStyle: TextStyle(fontSize: 14),
                            floatingLabelStyle: TextStyle(color: Colors.black),
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
                          validator: (value) => (value == null || value.isEmpty)
                              ? "password required"
                              : value.length <= 6
                              ? "invalid password,length should be greater then 6 charecter."
                              : !RegExp(r'[A-Z]').hasMatch(value)
                              ? "At least one uppercase letter required"
                              : !RegExp(
                                  r'[!@#\$&*~%^()_+\-=\[\]{};:"\\|,.<>\/?]',
                                ).hasMatch(value)
                              ? "At least one special character required"
                              : null,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "I Have Read And Agree To User Agrement Privacy Policy",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: "poppins",
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isloading
                              ? null
                              : () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  setState(() {
                                    _isloading = true;
                                  });

                                  try {
                                    final auth = AuthService();

                                    final response = await auth.signupUser(
                                      username: _usernameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );

                                    if(!mounted) return;

                                    if (response["status"] == "success") {
                                      setState(() {
                                        _isloading = false;
                                      });

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    } else {
                                      setState(() {
                                        _isloading = false;
                                      });

                                      ScaffoldMessenger.of(context,).showSnackBar(
                                        SnackBar(content: Text(response["message"] ??"Signup failed",style: TextStyle(fontFamily: "poppins",fontSize: 15,fontWeight: FontWeight.bold),),
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(17),
                                        backgroundColor: const Color.fromARGB(255, 52, 169, 232),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if(!mounted) return;
                                    setState(() {
                                      _isloading = false;
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error: $e",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "poppins"),),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color.fromARGB(255, 52, 169, 232),
                                      margin: EdgeInsets.all(17),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 52, 169, 232),
                            minimumSize: Size(
                              screenWidth * 0.9,
                              screenHeight * 0.05,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),

                          child: _isloading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: const Color.fromARGB(255, 202, 200, 199),
                              ), 
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 10,
                              ),
                              child: Text("OR"),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: const Color.fromARGB(255, 202, 200, 199),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: BoxBorder.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/google.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: BoxBorder.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/facebookk.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: BoxBorder.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/twitter.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Joined us before?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "poppins",
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "Log In",
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 52, 169, 232),
                                    fontFamily: "poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
