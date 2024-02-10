import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이용 안내'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Flexible(
              child: Image.asset("assets/images/sce.png"),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Flexible(
            child: Text(
              '스마트 의류 거래소',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Center(
              child: Text(
                '스마트 의류거래소는 비대면 직거래 서비스에요.\n      본인인증을 완료한 뒤, 시작해보세요!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
