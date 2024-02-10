import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proto/screens/inquire.dart';
import 'package:proto/screens/post.dart';
import 'package:proto/widgets/around_button.dart';
import 'package:proto/widgets/custom_button.dart';

import 'around.dart';
import 'auth.dart';
import 'insert.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide >= 600;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('스마트 의류 거래소'),
            centerTitle: true,
            backgroundColor: Colors.teal),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Container(
                      child: Center(
                        child: Text(
                          ' 안녕하세요 스마트 의류 거래소 입니다.\n     사용하실 메뉴를 선택해주세요.',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                        ),
                      ))), //안내 텍스트
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomButton(
                        buttonText: "의류 투입",
                        textColor: Colors.white,
                        buttonColor: Colors.redAccent,
                        buttonImage: Image.asset("assets/images/insert.png"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Auth(),
                            ),
                          );
                          // 버튼 클릭시 실행될 코드 작성
                        },
                        width: 200.0,
                        height: 10.0,
                      ),
                    ), // 의류 투입 버튼
                    Flexible(
                      child: CustomButton(
                        buttonText: "의류 등록",
                        textColor: Colors.white,
                        buttonColor: Colors.blueAccent,
                        buttonImage: Image.asset("assets/images/post.png"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Post(),
                            ),
                          );

                          // 버튼 클릭시 실행될 코드 작성
                        },
                        width: 200.0,
                        height: 10.0,
                      ),
                    ), //의류 등록 버튼
                    Flexible(
                      child: CustomButton(
                        buttonText: "의류 조회",
                        textColor: Colors.white,
                        buttonColor: Colors.amber,
                        buttonImage: Image.asset("assets/images/inquire.png"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InquireScreen(),
                            ),
                          );
                          // 버튼 클릭시 실행될 코드 작성
                        },
                        width: 200.0,
                        height: 10.0,
                      ),
                    ), //의류 조회 버튼
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ), //하단의 3개 버튼
              Flexible(
                flex: 1,
                child: Column(children: [
                  AroundButton(
                    buttonText:
                    " 주변 의류 거래소 조회\n\n 주변에 있는 다른 의류 거래소를 조회 \n 할 수 있습니다.",
                    textColor: Colors.white,
                    buttonColor: Colors.green,
                    buttonImage: Image.asset("assets/images/map.png"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Around(),
                        ),
                      ); // 버튼 클릭시 실행될 코드 작성
                    },
                    width: 800.0,
                    height: 10.0,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}


