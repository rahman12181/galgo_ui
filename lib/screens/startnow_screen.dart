import 'package:flutter/material.dart';

class StartnowScreen extends StatefulWidget {
  const StartnowScreen({super.key});

   @override
  _StartnowScreenState createState()=> _StartnowScreenState();
}

class _StartnowScreenState extends State<StartnowScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        
      ),
    );
  }
}