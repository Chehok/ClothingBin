import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();

}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    // 3초 후에 MainScreen으로 이동하는 코드
    Timer(Duration(seconds: 0), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
