import 'package:flutter/material.dart';
import 'package:mobile/screens/auth/sign_in.dart';
import 'package:mobile/screens/auth/sign_up.dart';
import 'package:mobile/screens/home/home_screeen_non_member.dart';
import 'package:mobile/services/bin_function.dart';
import 'package:provider/provider.dart';

import '../../states/user_provider.dart';
import '../home/home_screen.dart';
import 'package:flutter/services.dart';
import '../../services/back_to_exit_func.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneNumberController =
      TextEditingController(); // 핸드폰 번호 입력 칸
  final TextEditingController verificationCodeController =
      TextEditingController(); // 인증번호 입력 칸

  @override
  void dispose() {
    super.dispose();
  }

  void sendVerificationCode(BuildContext context) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    final phoneNumber = phoneNumberController.text;

    try {
      Map<String, dynamic> verificationData =
          await sendSMSVerification(phoneNumber);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${verificationData['result']}'),
        ),
      );
    } catch (error) {
      print('오류 발생: $error'); // 추가된 코드: 오류 메시지 출력
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('오류가 발생했습니다: $error'),
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
        const SnackBar(
          content: Text('인증번호를 입력해주세요.'),
        ),
      );
      return;
    }

    try {
      Map<String, dynamic> verificationData =
          await verifySMSCode(phoneNumber, verificationCode);

      if (verificationData['isSuccess']) {
        // userProvider.setUserAuth(true); // 사용자 인증 성공 시 상태 변경

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home_NonMember()),
          (route) => false,
        );
      } else {
        userProvider.setUserAuth(false); // 사용자 인증 실패 시 상태 변경
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('인증에 실패했습니다.'),
          ),
        );
      }
    } catch (error) {
      userProvider.setUserAuth(false); // 사용자 인증 실패 시 상태 변경
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('인증에 실패했습니다.'),
        ),
      );
      // 에러 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('전화번호 인증'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigoAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    '스마트 의류 거래소는 본인 인증을 완료하면 이용이 가능합니다.\n회원의 개인 정보는 안전히 보관되며, 외부에 노출되지 않습니다.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                const SizedBox(height: 50.0),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                    // 둘 중에 하나 써도 상관없음
                  ],
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: '전화번호',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => sendVerificationCode(context),
                  child: Text('인증번호 요청'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigoAccent, // 원하는 색상으로 변경
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  controller: verificationCodeController,
                  decoration: InputDecoration(
                    labelText: '인증번호',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => authenticate(context),
                  child: Text('인증하기'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigoAccent, // 원하는 색상으로 변경
                  ),
                ),
                const SizedBox(height: 150.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                    // 버튼을 클릭했을 때 실행되는 코드 작성
                    // 회원가입 동작 구현
                  },
                  child: Text('로그인 하기'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber, // 원하는 색상으로 변경
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                    // 버튼을 클릭했을 때 실행되는 코드 작성
                    // 회원가입 동작 구현
                  },
                  child: Text('회원가입'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen // 원하는 색상으로 변경
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
