import 'package:flutter/material.dart';

class ResetpasswordScreen  extends StatefulWidget{
  final String email;
  const ResetpasswordScreen({super.key, required this.email});
  @override
  State<ResetpasswordScreen> createState() => _ResetpasswordScreenState();
}

class _ResetpasswordScreenState extends State<ResetpasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("this is the resetpassword screen"),
    );
  }
}