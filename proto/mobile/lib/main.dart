import 'package:flutter/material.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobile/states/user_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        home:SplashScreen(),
        theme: ThemeData(fontFamily: 'DoHyeon'),
        themeMode: ThemeMode.system,
      ),
    );
  }
}

