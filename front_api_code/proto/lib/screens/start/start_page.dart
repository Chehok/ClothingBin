// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/animation.dart';
// import 'package:flutter/material.dart';
// import 'package:proto/states/user_provider.dart';
// import 'package:proto/utils/logger.dart';
// import 'package:provider/provider.dart';
//
// class StartPage extends StatelessWidget {
//   //페이지컨트롤러 적용
//   PageController controller;
//
//   StartPage(this.controller, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     logger.d('current user state: ${context.read<UserProvider>().userState}');
//     return LayoutBuilder(
//       builder: (context, constraints){
//
//         Size size = MediaQuery.of(context).size;
//
//         final imgOne = size.width -32;
//         final imgTwo = imgOne * 0.1;
//
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text('스마트 의류거래함',
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.teal),
//                 ),
//                 SizedBox(
//                   child: Stack(
//                     children: [
//                       ExtendedImage.asset('assets/images/start_logo.png'),
//
//                     ],
//                   ),
//                 ),
//                 Text('비대면 거래 서비스',
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 Text('스마트 의류거래함은 비대면 직거래 서비스에요.\n본인인증을 완료한 뒤, 시작해보세요!',
//                   style: TextStyle(fontSize: 13),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // TextButton(style: TextButton.styleFrom(backgroundColor: Colors.teal,
//                     //     primary: Colors.white),
//                     //     onPressed: (){
//                     //       controller.animateToPage(1, duration: Duration(milliseconds: 700), curve: Curves.easeOut);
//                     //     },
//                     //     child: Text('본인인증하기')
//                     // ),
//                     TextButton(style: TextButton.styleFrom(backgroundColor: Colors.teal,
//                         primary: Colors.white),
//                         onPressed: (){
//                           controller.animateToPage(1, duration: Duration(milliseconds: 700), curve: Curves.easeOut);
//                         },
//                         child: Text('본인인증하기')
//                     ),
//
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }