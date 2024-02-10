// import 'dart:convert';
//
// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
// import 'package:proto/constants/common_size.dart';
// import 'package:proto/screens/start/start_page.dart';
// import 'package:proto/states/user_provider.dart'; // BaseUrl 가져오기.
// import 'package:provider/provider.dart';
// import 'package:dio/dio.dart'; // http 통신할 때 씀.
//
// import '../../utils/logger.dart';
//
// class AuthPage extends StatefulWidget {
//   AuthPage({Key? key}) : super(key: key);
//
//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }
//
// const duration = Duration(milliseconds: 300);
//
// class _AuthPageState extends State<AuthPage> {
//   final inputBorder = OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.grey),
//   );
//   TextEditingController _phoneNumberController =
//       TextEditingController(text: "010");
//   TextEditingController _verifiNumberController = TextEditingController();
//
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   String phoneNumber = '010 0000 0000';
//
//   VerificationStatus _verificationStatus = VerificationStatus.none;
//
//   @override
//   Widget build(BuildContext context) {
//     logger.d('current user state: ${context.read<UserProvider>().userState}');
//     return LayoutBuilder(builder: (context, constraints) {
//       Size size = MediaQuery.of(context).size;
//       return IgnorePointer(
//         ignoring: _verificationStatus == VerificationStatus.verifying,
//         child: Form(
//           key: _formKey,
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text('본인인증 하기'),
//               elevation: AppBarTheme.of(context).elevation,
//               backgroundColor: Colors.teal,
//             ),
//             body: SingleChildScrollView(
//               child:Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     children: [
//                       ExtendedImage.asset(
//                         'assets/images/security.png',
//                         width: size.width * 0.25,
//                         height: size.width * 0.25,
//                       ),
//                       SizedBox(width: common_sm_padding),
//                       Text(
//                           '스마트 의류거래함은 전화번호로 인증합니다. \n여러분의 개인정보는 안전하게 보관되며,\n외부에 노출되지 않습니다.'),
//                     ],
//                   ),
//                   SizedBox(height: common_bg_padding),
//                   TextFormField(
//                     validator: (value) {
//                       phoneNumber = value.toString();
//                       if (value != null && value.length == 13) {
//                         return null;
//                       } else {
//                         return '올바른 전화번호를 입력하세요.';
//                       }
//                     },
//                     controller: _phoneNumberController,
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: [MaskedInputFormatter("000 0000 0000")],
//                     decoration: InputDecoration(
//                       border: inputBorder,
//                       focusedBorder: inputBorder,
//                     ),
//                   ),
//                   SizedBox(height: common_sm_padding),
//                   TextButton(
//
//                     // onPressed: () async {
//                     //   // dio 기초 설정. 잘 써~
//                     //   var dio = Dio();
//                     //   var options = BaseOptions(
//                     //     baseUrl: UserProvider().baseUrl,
//                     //     connectTimeout: 3000,
//                     //     receiveTimeout: 1000,
//                     //   );
//                     //   dio = Dio(options);
//                     //
//                     //   // 버튼이 눌리는 조건(_formKey.currentState)가 값이 null이 아니고,
//                     //   // validate()가 true (전화번호 값이 정상적) 이면 넘어간다.
//                     //   if (_formKey.currentState != null &&
//                     //       _formKey.currentState!.validate()) {
//                     //     setState(() {
//                     //       // 이건 뭐야?
//                     //       _verificationStatus = VerificationStatus.codeSent;
//                     //     });
//                     //     // response
//                     //     final res = await dio.post(
//                     //         'bins/phoneNum', // 주소 uri
//                     //         queryParameters: {'phoneNum': phoneNumber}// 쿼리스트링: ?phoneNum={phoneNumber}
//                     //     );
//                     //
//                     //     // Response인 jsonString을 dart의 객체 자료형으로 바꿈
//                     //     // key: String, value: dynamic(아무거나)
//                     //     Map<String, dynamic> object = jsonDecode(res.toString());
//                     //
//                     //     // 객체 키 값을 통해 접근하는 방법.
//                     //     print(object.containsKey('isSuccess'));
//                     //     print(object['isSuccess']);
//                     //
//                     //     // Map<String, dynamic> hello = {
//                     //     //   "clothingBinId": 1,
//                     //     //   "address":  "주소",
//                     //     // };
//                     //     // print(jsonEncode(hello));
//                     //   }
//                     // },
//                     onPressed: () async {
//                       Map data = {
//                         "type": "SMS",
//                         "contentType": "COMM",
//                         "countryCode":"82",
//                         "from":"1234567890",
//                         "content" : "ABCD",
//                         "messages":[
//                         {
//                           "to":phoneNumber,
//                           "content":"EFGH"
//                         }
//                         ],
//                       };
//                         var result = await http.post(
//       "https://sens.apigw.ntruss.com/sms/v2/services/$%7BUri.encodeComponent(%27SecretKey%27)%7D/messages",
//       headers: <String, String>{
//       "accept" : "application/json",
//       'content-Type': 'application/json; charset=UTF-8',
//       'x-ncp-apigw-timestamp' :timeStamp,
//       'x-ncp-iam-access-key': AccessKey,
//       'x-ncp-apigw-signature-v2' : getSignature(Uri.encodeComponent(OpenAPIKey-ID),timeStamp,
//       AccessKey, SecretKey)
//       },
//       body: json.encode(data)
//       );
//       print(result.body);
//                       }
//                     },
//                     child: Text('인증문자 발송'),
//                   ),
//                   SizedBox(height: common_bg_padding),
//                   AnimatedOpacity(
//                     duration: duration,
//                     opacity: (_verificationStatus == VerificationStatus.none)
//                         ? 0
//                         : 1,
//                     child: AnimatedContainer(
//                       duration: duration,
//                       curve: Curves.easeInOut,
//                       height: getVerificationHeight(_verificationStatus),
//                       child: TextFormField(
//                         controller: _verifiNumberController,
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [MaskedInputFormatter("000000")],
//                         decoration: InputDecoration(
//                           border: inputBorder,
//                           focusedBorder: inputBorder,
//                         ),
//                       ),
//                     ),
//                   ),
//                   AnimatedContainer(
//                     duration: duration,
//                     height: getVerificationBtnHeight(_verificationStatus),
//                     child: TextButton(
//                       onPressed: () {
//                         showDialog(
//                             context: context,
//                             barrierDismissible: false,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text('안내문'),
//                                 content: SingleChildScrollView(
//                                   child: ListBody(
//                                     children: <Widget>[
//                                       Text('본인 인증이 완료되었습니다.'),
//                                       Text('3초 이내에 홈 화면으로 이동합니다..'),
//                                     ],
//                                   ),
//                                 ),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     child: Text('ok'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                       // Navigator.push(context,MaterialPageRoute(builder:(context)=>MainPage()));
//                                     },
//                                   ),
//                                 ],
//                               );
//                             });
//                         attemptVerify();
//                       },
//                       child:
//                           (_verificationStatus == VerificationStatus.verifying)
//                               ? CircularProgressIndicator(
//                                   color: Colors.redAccent,
//                                 )
//                               : Text('인증하기'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
//
//   double getVerificationHeight(VerificationStatus status) {
//     switch (status) {
//       case VerificationStatus.none:
//         return 0;
//       case VerificationStatus.codeSent:
//       case VerificationStatus.verifying:
//       case VerificationStatus.verificationDone:
//         return 60 + common_sm_padding;
//     }
//   }
//
//   void attemptVerify() async {
//     setState(() {
//       _verificationStatus = VerificationStatus.verifying;
//     });
//     //퓨처함수로 인증 딜레이 시간 묘사
//     await Future.delayed(Duration(seconds: 3));
//     //인증처리 완료 상태관리
//
//     setState(() {
//       _verificationStatus = VerificationStatus.verificationDone;
//     });
//     context.read<UserProvider>().SetUserAuth(true);
//   }
//
//   double getVerificationBtnHeight(VerificationStatus status) {
//     switch (status) {
//       case VerificationStatus.none:
//         return 0;
//       case VerificationStatus.codeSent:
//       case VerificationStatus.verifying:
//       case VerificationStatus.verificationDone:
//         return 48;
//     }
//   }
// }
//
// enum VerificationStatus { none, codeSent, verifying, verificationDone }
