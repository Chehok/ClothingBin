// import 'package:flutter/material.dart';
// import 'package:proto/screens/home_screen.dart';
//
// class InsertScreen extends StatelessWidget {
//   const InsertScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('의류 수거 서비스'),
//           backgroundColor: Colors.teal,
//         ),
//         body:Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(style:TextButton.styleFrom(backgroundColor: Colors.teal, primary: Colors.white),
//                     onPressed: (){
//     showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//     return AlertDialog(
//     title: Text('안내문'),
//     content: SingleChildScrollView(
//     child: ListBody(
//     children: <Widget>[
//     Text('의류를 투입해주세요.'),
//     Text('수거함은 10초가 지나면 닫힙니다.'),
//     ],
//     ),
//     ),
//     actions: <Widget>[
//     TextButton(
//     child: Text('ok'),
//     onPressed: () {
//     Navigator.of(context).pop();
//     Navigator.push(context,MaterialPageRoute(builder:(context)=>HomeScreen()));
//     },
//     ),
//     TextButton(
//     child: Text('cancle'),
//     onPressed: () {
//     Navigator.of(context).pop();
//     },
//     ),
//     ],
//     );});
//                 }, child: Text('의류 투입하기'))
//               ],
//             )
//           ],
//
//           ),
//
//         ),
//       );
//   }
// }
// // return LayoutBuilder(
// // builder: (context, constraints){
// //
// // Size size = MediaQuery.of(context).size;
// //
// // final imgOne = size.width -32;
// // final imgTwo = imgOne * 0.1;
// //
// // return SafeArea(
// // child: Padding(
// // padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // child: Column(
// // mainAxisAlignment: MainAxisAlignment.spaceAround,
// // children: [
// // Text('스마트 의류거래함',
// // style: TextStyle(
// // fontSize: 30,
// // fontWeight: FontWeight.bold,
// // color: Colors.teal),
// // ),
// // SizedBox(
// // child: Stack(
// // children: [
// // ExtendedImage.asset('assets/images/start_logo.png'),
// //
// // ],
// // ),
// // ),
// // Text('비대면 거래 서비스',
// // style: TextStyle(
// // fontSize: 24,
// // fontWeight: FontWeight.w500),
// // ),
// // Text('스마트 의류거래함은 비대면 직거래 서비스에요.\n본인인증을 완료한 뒤, 시작해보세요!',
// // style: TextStyle(fontSize: 13),
// // ),
// // Column(
// // crossAxisAlignment: CrossAxisAlignment.stretch,
// // children: [
// // TextButton(style: TextButton.styleFrom(backgroundColor: Colors.teal,
// // primary: Colors.white),
// // onPressed: (){
// // controller.animateToPage(1, duration: Duration(milliseconds: 700), curve: Curves.easeOut);
// // },
// // child: Text('본인인증하기')
// // ),
// //
// // ],
// // ),
// // ],
// // ),
// // ),
// // );
// // },
// // );