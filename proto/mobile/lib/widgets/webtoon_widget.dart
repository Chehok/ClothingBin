// import 'package:flutter/material.dart';
// import 'package:mobile/screens/detail_screen.dart';
//
// class Webtoon extends StatelessWidget {
//   final String title, thumb, id;
//
//   const Webtoon(
//       {Key? key, required this.title, required this.thumb, required this.id})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       //동작 감지 위젯
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DetailScreen(
//               title: title,
//               thumb: thumb,
//               id: id,
//             ),
//             fullscreenDialog: true, //바닥에서부터 이미지가 올라온다.
//           ),
//         );
//       }, //온 탭 업과 온 탭 다운의 조합
//       child: Column(
//         children: [
//           Hero( // 두 화면 사이에 애니메이션을 주는 컴포넌트
//             tag: id,
//             child: Container(
//               decoration: BoxDecoration(boxShadow: [
//                 //그림자
//                 BoxShadow(
//                     blurRadius: 15, //그림자가 얼마나 멀리까지 드리울지 정함
//                     offset: Offset(10, 10), //그림자의 위치(정확하게 중앙에 위치)
//                     color: Colors.black.withOpacity(0.5) // 그림자의 색상
//
//                 )
//               ], borderRadius: BorderRadius.circular(15)),
//               width: 250,
//               clipBehavior: Clip.hardEdge,
//               child: Image.network(
//                 thumb,
//                 headers: const {
//                   "User-Agent":
//                   "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
//                 },
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             title,
//             style: TextStyle(fontSize: 22),
//           ),
//         ],
//       ),
//     );
//   }
// }
