import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Around extends StatefulWidget {
  const Around({Key? key}) : super(key: key);

  @override
  State<Around> createState() => _AroundState();
}

class _AroundState extends State<Around> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주변 거래소 조회'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: WebView(
        initialUrl: 'https://map.kakao.com/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:prototype/screens/home.dart';
// import 'package:webview_flutter/platform_interface.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// void main() {
//   runApp(MaterialApp(home:KakaoMapScreen()));
// }
//
// class KakaoMapScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('주변 거래소 조회'),
//       ),
//       body: WebView(
//         initialUrl: 'https://map.kakao.com/',
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }