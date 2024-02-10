import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:mobile/constants/variable.dart';

import '../../states/user_provider.dart';
import '../home/home_screen.dart';
import '../../services/bin_function.dart';

class SignIn extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Map<String, dynamic> loginResult = await login(username, password);

      if (loginResult['isSuccess'] == true) {
        // 로그인 성공 시 처리
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          (route) => false,
        );
        return;
      }

      // 로그인 실패 시 경고 대화상자 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 실패'),
            content: Text('아이디 또는 비밀번호가 잘못되었습니다.'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('로그인 실패 에러: $error'); // 에러 메시지를 콘솔에 출력

      // 로그인 실패 시 경고 대화상자 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 실패'),
            content: Text('로그인 중 오류가 발생했습니다.'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: '아이디',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                onPressed: () => _login(context),
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
