import 'package:flutter/material.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    toHomeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Center(
        child: SizedBox(
          child: Image(
            width: 150,
            image: AssetImage("assets/icon_image.png"),
          ),
        ),
      ),
    );
  }

  Future<void> toHomeScreen() async{
    await Future.delayed(const Duration(seconds: 3),()
    {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
}