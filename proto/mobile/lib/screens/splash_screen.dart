import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/screens/start/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3초 후에 MainScreen으로 이동하는 코드
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Center(
        child: Text(
          '스마트 의류 거래소',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
