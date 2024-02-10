// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../chat/chat_info.dart';
import '../tabs/home_tab.dart';
import '../tabs/mypage.dart';
import '../services/back_to_exit_func.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  State<ChatTab> createState() => _ChatTab();
}

class _ChatTab extends State<ChatTab> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    HomeTab(),
    ChatTab(),
    MyPageTab(),
  ];

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
          title: Text('채팅'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
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
        body: ListView(
          children: [
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatInfo()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                height: 100, // Adjust the height as needed
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    radius: 30, // Adjust the radius as needed
                    child: Image.asset('assets/images/user.png'),
                  ),
                  title: Text('김민준'),
                  subtitle: Text('대면 거래 가능할까요?'),
                  trailing: Text('2분 전'), // 시간을 표시합니다.
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                height: 100, // Adjust the height as needed
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30, // Adjust the radius as needed
                    child: Image.asset('assets/images/man.png'),
                  ),
                  title: Text('재리'),
                  subtitle: Text('안녕하세요 상품에 관심이 있어서 채팅...'),
                  trailing: Text('49분 전'), // 시간을 표시합니다.
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Container(
                height: 100,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Image.asset('assets/images/girl.png'),
                  ),
                  title: Text('쿠크다스'),
                  subtitle: Text('정품인가요?'),
                  trailing: Text('2시간 전'), // 시간을 표시합니다.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
