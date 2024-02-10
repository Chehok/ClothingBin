import 'package:flutter/material.dart';
import 'package:mobile/screens/auth/auth_screen.dart';
import 'package:mobile/screens/start/start_screen.dart';
import 'package:mobile/tabs/profile.dart';
import 'package:mobile/services/bin_function.dart';
import '../tabs/home_tab.dart';
import '../tabs/chat_tab.dart';
import '../services/back_to_exit_func.dart';

class MyPageTab extends StatefulWidget {
  // final Map<String, dynamic> userInfo;
  // final Future<Map<String, dynamic>> userInfo = getUserInfo();

  // const MyPageTab({Key? key, required this.userInfo}) : super(key: key);

  @override
  _MyPageTab createState() => _MyPageTab();
}

class _MyPageTab extends State<MyPageTab> {
  dynamic _name = 0;
  dynamic _email;
  dynamic _phoneNum;
  dynamic _profileImg;
  final _modifyProfile = "프로필 수정";
  final _logout = "로그아웃";
  Map<String, dynamic> _userInfo = {};

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    HomeTab(),
    ChatTab(),
    MyPageTab(),
  ];

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    //
    final userInfo = await getUserInfo();
    setState(() {
      _userInfo = userInfo['result'];
      _name = userInfo['result']['name'];
      _email = userInfo['result']['email'];
      _phoneNum = userInfo['result']['phoneNum'];
      _profileImg = userInfo['result']['profileImg'];
    });
  }

  Future<void> _onItemTapped(int index) async {
    // 로그인 안되면 로그인 페이지로 넘어가는 로직
    // if (!isLoggedIn()) MaterialPageRoute(builder: (context) => AuthScreen());

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
        appBar: AppBar(
          title: Text('마이 페이지'),
          backgroundColor: Colors.indigoAccent,
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
        body: _userInfo.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      // Image.asset('assets/images/user.png')
                      backgroundColor: Colors.white,
                      child: _profileImg == ""
                          ? Image.asset('assets/images/user.png')
                          : Image.network(_profileImg), // 프로필 사진 이미지 경로
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _name, // 이름
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '이메일: $_email', // 이메일
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '전화번호: $_phoneNum', // 전화번호
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                      userInfo: _userInfo,
                                    )));
                        // 프로필 수정 기능 구현
                        // 버튼을 눌렀을 때 수행되어야 하는 동작을 작성하세요.
                      },
                      child: Text(
                        _modifyProfile,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      // 로그아웃
                      onPressed: () {
                        logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => StartScreen()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        _logout,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
