import 'package:flutter/material.dart';
import 'package:kiosk/screens/insert_screen.dart';
import 'package:provider/provider.dart';
import 'package:kiosk/states/user_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();

  void sendVerificationCode(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final phoneNumber = phoneNumberController.text;

    try {
      Map<String, dynamic> verificationData =
      await userProvider.sendSMSVerification(phoneNumber);
      String verificationCode = verificationData['result'].toString();
      print('전송된 인증번호: $verificationCode');

      // 서버 응답의 헤더와 바디 값 출력
      print('헤더: ${verificationData}');


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('인증번호가 전송되었습니다.'),
        ),
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('인증번호 전송에 실패했습니다.'),
        ),
      );
    }
  }

  void authenticate(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final phoneNumber = phoneNumberController.text;
    final verificationCode = int.parse(verificationCodeController.text);

    if (verificationCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('인증번호를 입력해주세요.'),
        ),
      );
      return;
    }

    try {
      Map<String, dynamic> verificationData =
      await userProvider.verifySMSCode(phoneNumber, verificationCode);

      // 서버 응답의 헤더와 바디 값 출력

      if (verificationData['isSuccess']) {
        userProvider.setUserAuth(true); // 사용자 인증 성공 시 상태 변경

        // 인증이 완료된 경우 insert 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Insert()),
        );
      } else {
        userProvider.setUserAuth(false); // 사용자 인증 실패 시 상태 변경
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('인증에 실패했습니다.'),
          ),
        );
      }
    } catch (error) {
      userProvider.setUserAuth(false); // 사용자 인증 실패 시 상태 변경
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('인증에 실패했습니다.'),
        ),
      );
      // 에러 처리
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 인증'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: '전화번호',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => sendVerificationCode(context),
              child: Text('인증번호 요청'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: verificationCodeController,
              decoration: InputDecoration(
                labelText: '인증번호',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => authenticate(context),
              child: Text('인증하기'),
            ),
          ],
        ),
      ),
    );
  }
}
