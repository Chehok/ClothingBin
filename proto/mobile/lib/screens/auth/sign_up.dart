import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/screens/auth/auth_screen.dart';
import 'package:provider/provider.dart';

import '../../states/user_provider.dart';
import '../../services/bin_function.dart';

class SignUp extends StatefulWidget {
  //
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _imageUrl = '';

  Future<void> _getImage() async {
    var result = await uploadFile();
    setState(() {
      _imageUrl = result?['result'];
    });
  }

  Future<void> _idCheck() async {
    if (await idCheck(_usernameController.text)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('아이디 중복 확인'),
            content: const Text('사용 불가능한 아이디입니다.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('아이디 중복 확인'),
          content: const Text('사용 가능한 아이디입니다.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signUp(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String phoneNum = _phoneNumController.text;
    String email = _emailController.text;

    try {
      Map<String, dynamic> signUpResult = await signUp(
        username,
        password,
        name,
        phoneNum,
        email,
        _imageUrl,
      );

      if (signUpResult.containsKey('isSuccess') &&
          signUpResult['isSuccess'] == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('회원가입 성공'),
              content: const Text('회원가입이 성공적으로 완료되었습니다.'),
              actions: [
                TextButton(
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AuthScreen()));
                    // 회원가입 완료 후 다른 동작 수행
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('회원가입 실패'),
              content: Text('회원가입에 실패했습니다.'),
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
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('오류'),
            content: const Text('회원가입 중 오류가 발생했습니다.'),
            actions: [
              TextButton(
                child: const Text('확인'),
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
        title: const Text('회원가입'),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 36.0),
              GestureDetector(
                onTap: () => _getImage(),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: _imageUrl != ''
                      ? Image.network(_imageUrl)
                      : Image.asset('assets/images/user.png'),
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: '아이디',
                      ),
                      // decoration: new InputDecoration.collapsed(hintText: "Send a message",),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                    ),
                    onPressed: () => {
                      _idCheck(),
                    },
                    child: Text('중복 확인'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '이름'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  LengthLimitingTextInputFormatter(11),
                ],
                controller: _phoneNumController,
                decoration: const InputDecoration(
                  labelText: '전화번호',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: '이메일',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                ),
                onPressed: () => _signUp(context),
                child: Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
