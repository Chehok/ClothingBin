import 'package:flutter/material.dart';
import 'package:mobile/screens/auth/auth_screen.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobile/states/user_provider.dart';

class JoinScreen extends StatefulWidget {
  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void signUp(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final id = idController.text;
    final password = passwordController.text;
    final phoneNumber = phoneNumberController.text;

    // 회원가입 처리 로직 구현
    // 예를 들면 userProvider.signUp(id, password, phoneNumber);

    userProvider.setUserAuth(true); // 사용자 인증 성공 시 상태 변경

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: '아이디',
                ),
              ),
              SizedBox(height: 16.0),
          TextField(
            controller: passwordController,
            obscureText: true, // 비밀번호 텍스트를 가려줌
            decoration: InputDecoration(
              labelText: '비밀번호',
              filled: true,
              fillColor: Colors.white.withOpacity(0.5), // 투명도를 적용한 백그라운드 컬러
            ),
          ),
              SizedBox(height: 16.0),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: '전화번호',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => signUp(context),
                child: Text('회원가입'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigoAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
