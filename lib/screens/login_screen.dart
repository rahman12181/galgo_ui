import 'package:flutter/material.dart';
import 'package:frontend/animations.dart/slide_animation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;
    double screenWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SlideAnimation(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Welcome back!",
                            style: TextStyle(
                              fontSize: screenWidth * 0.4,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login to your account now",
                            style: TextStyle(
                              fontSize: 8,
                              fontFamily: "poppins",
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "email address",
                            border: UnderlineInputBorder(),
                          ),

                          validator: (value) => (value == null || value.isEmpty)
                              ? "email required"
                              : value.endsWith("@gmail.com")
                              ? "invalid email address"
                              : null,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) => (value == null || value.isEmpty)
                              ? "password required"
                              : value.length >= 6
                              ? "invalid password,length should be greater then 6 charecter."
                              : !RegExp(r'[A-Z]').hasMatch(value)
                              ? "At least one uppercase letter required"
                              : !RegExp(
                                  r'[!@#\$&*~%^()_+\-=\[\]{};:"\\|,.<>\/?]',
                                ).hasMatch(value)
                              ? "At least one special character required"
                              : null,
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: _isloading
                              ? null
                              : () async {
                                  setState(() {
                                    _isloading = true;
                                  });
                                  await Future.delayed(Duration(seconds: 2));
                                  setState(() {
                                    _isloading = false;
                                  });
                                },
                          child: _isloading
                              ? SizedBox(
                                  height: screenHeight * 0.08,
                                  width: screenWidth * 0.08,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text("Log In"),
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
