import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/animations.dart/slide_animation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emaolController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final  _formkey = GlobalKey<FormState>();
    bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
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
                          "Hello!",
                          style: TextStyle(fontSize: 40, fontFamily: "poppins"),
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Please fill in to sign up new acccount",
                          style: TextStyle(
                            fontSize: 8,
                            fontFamily: "poppins",
                            color: const Color.fromARGB(255, 111, 111, 111),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? "username required"
                            : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emaolController,
                        decoration: const InputDecoration(
                          labelText: "Email address",
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) => (value == null || value.isEmpty)
                            ? "email required"
                            : !value.endsWith("@gmail.com")
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
                                //api call will be their
                                await Future.delayed(Duration(seconds: 2));
                                setState(() {
                                  _isloading = false;
                                });
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                        child: _isloading
                            ? SizedBox(
                                width: screenWidth * 0.08,
                                height: screenHeight * 0.08,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text("Sign Up"),
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
