import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiosk/screens/around_screen.dart';
import 'package:kiosk/screens/auth_screen.dart';
import 'package:kiosk/screens/product_screen.dart';
import 'package:kiosk/widgets/around_button.dart';
import 'package:kiosk/widgets/custom_button.dart';
import 'package:kiosk/api/bin_function.dart';

import 'information.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide >= 600;
      return Scaffold(
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
                              builder: (context) => AuthScreen(),
                            ),
                          );
                          // 버튼 클릭시 실행될 코드 작성
                        },
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ), // 의류 투입 버튼
                    //의류 등록 버튼
                    Flexible(
                      child: CustomButton(
                        buttonText: "의류 조회",
                        textColor: Colors.white,
                        buttonColor: Colors.amber,
                        buttonImage: Image.asset("assets/images/inquire.png"),
                        onPressed: () async {
                          var clothesList = await getAllClothesInfo(1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Product(clothesList: clothesList,),
                            ),
                          );
                        },

                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    Flexible(
                      child: CustomButton(
                        buttonText: "이용 안내",
                        textColor: Colors.white,
                        buttonColor: Colors.blue,
                        buttonImage: Image.asset("assets/images/use.png"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Information(),fullscreenDialog: true,
                            ),
                          );
                        },

                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),//의류 조회 버튼
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
                          builder: (context) => AroundScreen(),
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
    );
  }
}


