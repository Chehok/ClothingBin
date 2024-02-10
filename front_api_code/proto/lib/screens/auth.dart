import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:proto/constants/common_size.dart';
import 'package:proto/states/user_provider.dart';
import 'package:provider/provider.dart';

import '../constants/common_size.dart';
import 'insert.dart';

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

const duration = Duration(milliseconds: 300);

class _AuthState extends State<Auth> {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  TextEditingController _phoneNumberController =
      TextEditingController(text: "010");
  TextEditingController _verifiNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  VerificationStatus _verificationStatus = VerificationStatus.none;

//인증하기 버튼 show 애니메이션 변수값
  double getVerificationBtnHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;

      return IgnorePointer(
        ignoring: _verificationStatus == VerificationStatus.verifying,
        child: Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title:
                  Text('사용자 인증'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(common_bg_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Image.asset('assets/images/security.png',),
                          ),
                          Flexible(
                            child: Text(
                                '사용자 인증을 시작합니다.',
                            style: TextStyle(fontSize: 40),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: common_bg_padding),
                  Flexible(
                    child: TextFormField(
                      validator: (phoneNumber) {
                        if (phoneNumber != null && phoneNumber.length == 13) {
                          return null;
                        } else {
                          return '올바른 전화번호를 입력하세요.';
                        }
                      },
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [MaskedInputFormatter("000 0000 0000")],
                      decoration: InputDecoration(
                        border: inputBorder,
                        focusedBorder: inputBorder,
                      ),
                    ),
                  ),
                  SizedBox(height: common_sm_padding),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          bool passed = _formKey.currentState!.validate();
                          print(passed);
                          if (passed)
                            setState(() {
                              _verificationStatus = VerificationStatus.codeSent;
                            });
                        }
                      },
                      child: Text('인증문자 발송'),
                    ),
                  ),
                  SizedBox(height: common_bg_padding),
                  AnimatedOpacity(
                    duration: duration,
                    opacity: (_verificationStatus == VerificationStatus.none)
                        ? 0
                        : 1,
                    child: AnimatedContainer(
                      duration: duration,
                      curve: Curves.easeInOut,
                      height: getVerificationHeight(_verificationStatus),
                      child: TextFormField(
                        controller: _verifiNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [MaskedInputFormatter("000000")],
                        decoration: InputDecoration(
                          border: inputBorder,
                          focusedBorder: inputBorder,
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: duration,
                    height: getVerificationBtnHeight(_verificationStatus),
                    child: ElevatedButton(
                      onPressed: () {
                        attemptVerify();
                      },
                      child:
                          (_verificationStatus == VerificationStatus.verifying)
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('인증하기'),

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

//인증번호 입력필드 show 애니메이션 변수값
  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 60 + common_sm_padding;
    }
  }

// 인증하기 버튼 클릭시 인증중 처리함수
  void attemptVerify() async {
//인증처리 중인 상태관리
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    }
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('인증 완료'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text('인증이 완료 되었습니다.')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Insert(),
                  ),
                );
              },
              child: Center(child: Text('확인')),
            ),
          ],
        );
      },
    );

//퓨처함수로 인증 딜레이 시간 묘사
    await Future.delayed(Duration(seconds: 3));
//인증처리 완료 상태관리
    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
    context.read<UserProvider>().SetUserAuth(true);
  }
}

// 검증상태 관리
enum VerificationStatus { none, codeSent, verifying, verificationDone }
