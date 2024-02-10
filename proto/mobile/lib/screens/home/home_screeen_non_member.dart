import 'package:flutter/material.dart';
import '../../services/bin_function.dart';
import '../../tabs/mypage.dart';
import '../../tabs/home_tab.dart';
import '../../tabs/chat_tab.dart';
import '../../widgets/buttons/custom_button.dart';
import '../Around/around_screen.dart';
import '../Product/product.dart';
import '../auth/auth_screen.dart';
import '../insert/insert_screen.dart';
import '../post/register.dart';
import '../start/start_screen.dart';
import 'notification_screen.dart';
import '../../constants/variable.dart';
import '../../services/back_to_exit_func.dart';

class Home_NonMember extends StatefulWidget {
  Home_NonMember({Key? key}) : super(key: key);

  @override
  State<Home_NonMember> createState() => _Home_NonMemberState();
}

class _Home_NonMemberState extends State<Home_NonMember> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            "스마트 의류 거래소",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('로그아웃'),
                      content: const Text('정말 로그아웃하시겠습니까?'),
                      actions: <Widget> [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('취소')
                        ),
                        ElevatedButton(
                          onPressed: () {
                            logout();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => StartScreen()),
                                  (route) => false,
                            );
                          },
                          child: const Text('나가기'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.08,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text(
                      '사용하실 메뉴를 선택해주세요.',
                      style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.12,
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: CustomButton(
                        buttonText: "의류 투입",
                        textColor: Colors.white,
                        buttonColor: Colors.redAccent,
                        buttonImage: Image.asset("assets/images/insert.png"),
                        onPressed: () async {
                          await throwCloth(clothingBinId);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('의류 투입'),
                                content: const Text('의류 수거가 완료 되었습니다.'),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('확인')),
                                ],
                              );
                            },
                          );
                        },
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height*0.25,
                      height: 20,
                    ),
                    // Flexible(
                    //   flex: 1,
                    //   child: CustomButton(
                    //     buttonText: "의류 판매",
                    //     textColor: Colors.white,
                    //     buttonColor: Colors.blueAccent,
                    //     buttonImage: Image.asset("assets/images/post.png"),
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => Post(),
                    //         ),
                    //       );
                    //     },
                    //     width: MediaQuery.of(context).size.width * 0.3,
                    //     height: MediaQuery.of(context).size.height * 0.3,
                    //   ),
                    // ),
                    // Flexible(
                    //   flex: 1,
                    //   child: CustomButton(
                    //     buttonText: "의류 조회",
                    //     textColor: Colors.white,
                    //     buttonColor: Colors.amber,
                    //     buttonImage: Image.asset("assets/images/inquire.png"),
                    //     onPressed: () async {
                    //       var clothesList =
                    //       await getAllClothesInfo(clothingBinId);
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => Inquire(
                    //             clothesList: clothesList,
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     width: MediaQuery.of(context).size.width * 0.3,
                    //     height: MediaQuery.of(context).size.height * 0.3,
                    //   ),
                    // ),
                    Flexible(
                      flex: 1,
                      child: CustomButton(
                        buttonText: "주변 거래소",
                        textColor: Colors.white,
                        buttonColor: Colors.green,
                        buttonImage: Image.asset("assets/images/map.png"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Around(),
                            ),
                          );
                        },
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}