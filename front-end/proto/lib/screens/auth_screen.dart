// import 'package:flutter/material.dart';
// import 'package:proto/screens/start/auth_page.dart';
// import 'package:proto/screens/start/insert_page.dart';
// import 'package:proto/screens/start/start_page.dart';
//
// class AuthScreen extends StatelessWidget {
//   PageController _pageController = PageController();
//   AuthScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: PageView(
//         controller: _pageController,
//         physics: NeverScrollableScrollPhysics(),
//         children: [
//           StartPage(_pageController), // 0페이지
//         AuthPage(),                   // 1페이지
//       ],),
//     );
//   }
// }
//
// // import 'package:extended_image/extended_image.dart';
// // import 'package:flutter/animation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:proto/states/user_provider.dart';
// // import 'package:proto/utils/logger.dart';
// // import 'package:provider/provider.dart';
// //
// // class StartPage extends StatelessWidget {
// //   PageController controller;
// //
// //   StartPage(this.controller,{Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     logger.d('current user state: ${context.read<UserProvider>().userState}');
// //     return LayoutBuilder(
// //         builder: (context, constraints){
// //           Size size = MediaQuery.of(context).size;
// //           return SafeArea(
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 14.0),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   children: [
// //                     Text('스마트 의류거래함',
// //                         style: TextStyle(
// //                           fontSize: 30,
// //
// //                         ))
// //                   ],
// //                 ),
// //
// //               )
// //           );
// //         });
// //   }
// // }
