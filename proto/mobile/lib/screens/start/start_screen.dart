import 'package:flutter/material.dart';

import '../../services/back_to_exit_func.dart';
import '../auth/auth_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  '스마트 의류 거래소',
                  style: TextStyle(fontSize: 30, color: Colors.indigoAccent),
                ),
              ),
            ), // "스마트 의류 거래소"
            SizedBox(
              height: 30,
            ), // (빈칸)
            Flexible(
              flex: 4,
              child: Image.asset('assets/images/logobox.png'),
            ), // 의류거래소 사진
            Flexible(
              flex: 2,
              child: Container(
                child: Center(
                  child: Text(
                    '중고의류 비대면 거래',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ), // "중고의류 비대면 거래"
            SizedBox(
              height: 20,
            ), // (빈칸)
            Flexible(
              flex: 1,
              child: Container(
                child: Text(
                  '스마트 의류 거래소는 비대면 의류거래 서비스에요\n 필요 없는 옷을 팔거나 기부하는건 어떠신가요?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ), // 설명
            SizedBox(
              height: 80,
            ), // 빈칸
            Flexible(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // 버튼 너비 설정
                height: MediaQuery.of(context).size.height * 0.05, // 버튼 높이 설정
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AuthScreen()),
                      (route) => false,
                    );
                    // 버튼을 클릭했을 때 실행되는 코드 작성
                    // 본인 인증 및 시작하기 동작 구현
                  },
                  child: Text('본인 인증하고 시작하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14), // 버튼의 모서리를 둥글게 설정
                    ),
                  ),
                ),
              ),
            ) // 인증버튼
          ],
        ),
      ),
    );
  }
}

// 기존의 키오스크 스타트 스크린
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// import 'home.dart';
//
// class StartScreen extends StatelessWidget {
//   const StartScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.teal,
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Flexible(
//                   flex: 2,
//                   child:
//                   Center(child: Image.asset("assets/images/donation.png")),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '스마트 의류 거래소',
//                         style: TextStyle(
//                             fontSize: 55,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap:  (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(),));},
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.4,
//                         height: MediaQuery.of(context).size.height * 0.1,
//                         decoration: BoxDecoration(
//                           color: Colors.amber,
//                           borderRadius: BorderRadius.circular(60),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "시작하기",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 40,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
//   }
// }
