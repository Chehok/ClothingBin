// import 'package:flutter/material.dart';
// import 'package:mobile/constants/variable.dart';
// import 'package:mobile/services/bin_function.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:mobile/states/user_provider.dart';
//
// class Insert extends StatefulWidget {
//   const Insert({Key? key}) : super(key: key);
//
//   @override
//   _InsertState createState() => _InsertState();
// }
//
// class _InsertState extends State<Insert> {
//   final _formKey = GlobalKey<FormState>();
//   int _lockerNum = 1;
//
//   void _throwCloth() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await throwCloth(
//           clothingBinId,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('의류 투입이 완료되었습니다.')),
//         );
//       } catch (e) {
//         print(e);
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   SnackBar(content: Text('오류가 발생하였습니다.')),
//         // );
//       }
//     }
//   }
//
//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('의류 투입 신청'),
//           content: Text('의류 투입 신청이 완료되었습니다.\n발급된 인증 번호를 수거함에 입력해주세요!\n\n수거함 인증번호: 9572'),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('확인'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('의류투입 신청'),
//         centerTitle: true,
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.redAccent,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(labelText: '의류명'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return '의류명을 입력해주세요.';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => _clothName = value,
//                 ),
//                 SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: _category,
//                   decoration: InputDecoration(labelText: '카테고리'),
//                   items: clothingCategories
//                       .map((category) => DropdownMenuItem(
//                             child: Text(category),
//                             value: category,
//                           ))
//                       .toList(),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return '카테고리를 선택해주세요.';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       _category = value!;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _getImage,
//                   child: Text('이미지 선택'),
//                 ),
//                 if (_imageLink != null)
//                   Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         fit: BoxFit.fitWidth,
//                         image: NetworkImage(
//                           _imageLink!,
//                         ),
//                       ),
//                     ),
//                   ),
//                 SizedBox(height: 40),
//                 ElevatedButton(
//                   onPressed: () {
//                     _inputCloth();
//                     _showConfirmationDialog(); // Show the confirmation dialog
//                   },
//                   child: Text('투입하기'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //기존 의류 수거기능 코드, 현재는 주석 처리
// // import 'package:flutter/material.dart';
// // import 'dart:async';
// //
// // import 'package:mobile/screens/home/home_screen.dart';
// //
// // class Insert extends StatefulWidget {
// //   const Insert({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Insert> createState() => _InsertState();
// // }
// //
// // class _InsertState extends State<Insert> {
// //   static const TenSeconds = 10;
// //   int totalSeconds = TenSeconds;
// //   bool isRunning = false;
// //   bool isOpen = false;
// //   late Timer timer;
// //
// //   void onTick(Timer timer) {
// //     if (totalSeconds == 0) {
// //       setState(() {
// //         isOpen = false;
// //         isRunning = false;
// //         totalSeconds = TenSeconds;
// //       });
// //       showDialog(
// //         context: context,
// //         barrierDismissible: false,
// //         builder: (BuildContext context) {
// //           return AlertDialog(
// //             title: Center(
// //               child: Text('시간 초과'),
// //             ),
// //             content: SingleChildScrollView(
// //               child: ListBody(
// //                 children: <Widget>[
// //                   Center(child: Text('사물함이 닫혔습니다.')),
// //                 ],
// //               ),
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) => Home(),
// //                     ),
// //                   );
// //                 },
// //                 child: Center(child: Text('확인')),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //       timer.cancel();
// //     } else {
// //       setState(() {
// //         totalSeconds = totalSeconds - 1;
// //       });
// //     }
// //   }
// //
// //   void onStartPressed() {
// //     timer = Timer.periodic(
// //       //주기마다 실행하게해줌 periodic
// //       const Duration(seconds: 1),
// //       onTick,
// //     );
// //     setState(() {
// //       isRunning = true;
// //       isOpen = true;
// //     });
// //   }
// //
// //   void onPausedPressed() {
// //     timer.cancel();
// //     setState(() {
// //       isRunning = false;
// //       isOpen = false;
// //     });
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false, //팝업창 밖의 영역 터치해도 반응없음
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Center(
// //             child: Text('안내문'),
// //           ),
// //           content: SingleChildScrollView(
// //             child: ListBody(
// //               children: <Widget>[
// //                 Center(child: Text('사물함이 닫혔습니다.')),
// //               ],
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => Home(),
// //                   ),
// //                 );
// //               },
// //               child: Center(child: Text('확인')),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   String format(int seconds) {
// //     var duration = Duration(seconds: seconds);
// //     return duration.toString().split(".").first.substring(2, 7);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         foregroundColor: Colors.white,
// //         backgroundColor: Colors.redAccent,
// //         title: Text('의류 투입하기'),
// //       ),
// //       backgroundColor: Theme.of(context).backgroundColor,
// //       body: Column(
// //         children: [
// //           Flexible(
// //             flex: 1,
// //             child: Container(
// //               alignment: Alignment.bottomCenter,
// //               child: Text(
// //                 format(totalSeconds),
// //                 style: TextStyle(
// //                     color: Theme.of(context).cardColor,
// //                     fontSize: 89,
// //                     fontWeight: FontWeight.w600),
// //               ),
// //             ),
// //           ), //시간표시
// //           Flexible(
// //             flex: 3,
// //             child: Container(
// //               child: Center(
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     IconButton(
// //                         iconSize: 120,
// //                         color: Theme.of(context).cardColor,
// //                         onPressed: isRunning ? onPausedPressed : onStartPressed,
// //                         icon: Icon(isRunning ? Icons.lock_open : Icons.lock)),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ), //동작 버튼
// //           Flexible(
// //             flex: 1,
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       color: Theme.of(context).cardColor,
// //                       borderRadius: BorderRadius.circular(50),
// //                     ),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Text(
// //                           '수거함 상태',
// //                           style: TextStyle(
// //                               fontSize: 20,
// //                               fontWeight: FontWeight.w600,
// //                               color:
// //                               Theme.of(context).textTheme.headline1!.color),
// //                         ),
// //                         Text(
// //                           isOpen ? "open" : "closed",
// //                           style: TextStyle(
// //                               fontSize: 58,
// //                               fontWeight: FontWeight.w600,
// //                               color:
// //                               Theme.of(context).textTheme.headline1!.color),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ), //하단 포모도로 횟수 표시
// //         ],
// //       ),
// //     );
// //   }
// // }
