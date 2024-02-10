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
import 'notification_screen.dart';
import '../../constants/variable.dart';
import '../../services/back_to_exit_func.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [
    HomeTab(),
    ChatTab(),
    MyPageTab(),
  ];

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    // 화면 이동 로직 추가
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => _widgetOptions[index],
      ),
      (route) => false,
    );
  }

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
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsScreen(),
                  ),
                );
                // 알림 버튼이 눌렸을 때 실행될 코드 작성
                // 예를 들어, 알림 페이지로 이동하는 코드를 작성
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: '채팅',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
        ),
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
                      '사용하실 메뉴를 선택해주세요.',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ),
                ),
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
                    Flexible(
                      flex: 1,
                      child: CustomButton(
                        buttonText: "의류 판매",
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
                        },
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomButton(
                        buttonText: "의류 조회",
                        textColor: Colors.white,
                        buttonColor: Colors.amber,
                        buttonImage: Image.asset("assets/images/inquire.png"),
                        onPressed: () async {
                          var clothesList =
                              await getAllClothesInfo(clothingBinId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Inquire(clothesInfoList: clothesList),
                            ),
                          );
                        },
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
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
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
