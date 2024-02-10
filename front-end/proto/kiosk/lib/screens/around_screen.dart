import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class AroundScreen extends StatefulWidget {
  const AroundScreen({Key? key}) : super(key: key);

  @override
  State<AroundScreen> createState() => _AroundScreenState();
}

class _AroundScreenState extends State<AroundScreen> {
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
