import 'package:flutter/material.dart';
import 'package:kiosk/screens/start_screen.dart';
import 'package:kiosk/states/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: '스마트 의류 거래소',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: StartScreen(),
      ),
    );
  }
}
