import 'package:flutter/material.dart';
import 'package:frontend/utils/systembar_utils.dart';

class OnbordingSecondscreen extends StatefulWidget{
  const OnbordingSecondscreen({super.key});

  @override
  State<OnbordingSecondscreen> createState() => _OnbordingSecondscreenState();
}

class _OnbordingSecondscreenState extends State<OnbordingSecondscreen> {

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      SystembarUtil.setSystemBar(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}