// import 'package:flutter/material.dart';
//
// class InsertPage extends StatelessWidget {
//   PageController controller;
//   InsertPage(this.controller, {Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('의류 수거 서비스 '),
//           elevation: 2, //그림자 효과
//           backgroundColor: Colors.teal,
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               SizedBox(height: 50,),
//               Text("의류 수거 서비스에 오신 것을 환영 합니다.",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w800
//               ),),
//               Text("수거가 필요한 의류를 투입하세요.",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w800
//               ),),
//               SizedBox(height: 60,),
//               TextButton(style:TextButton.styleFrom(
//                 backgroundColor:Colors.teal,
//                 primary: Colors.white,
//               ),
//                   onPressed: (){
//                     controller.animateToPage(2, duration: Duration(milliseconds: 700), curve: Curves.easeOut);
//                   }, child: Text("본인 인증하기"))
//
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }
