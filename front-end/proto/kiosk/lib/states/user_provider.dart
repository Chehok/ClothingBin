import 'package:flutter/widgets.dart';

//ChangeNotifier은 위젯의 UI데이터가 변경되게 되면 그 변경값을 자동으로 업데이트 해주는 기능.
class UserProvider extends ChangeNotifier{
  //유저 로그인 여부 프라이빗 변수로 선언(로그인 상태면 true, 아니면 false)
  //프라이빗 변수를 사용해야하는 이유는 외부에서 쉽게 접근하여 로그인과 로그아웃을 할 수 없도록 막기 위함임
  //프라이빗 변수는 반드시 SetUserAuth라는 보이드 함수의 지시만을 따라야함.
  //보이드 함수가 외부로 부터 true(로그인 상태)라고 받아오면 그걸 프라이빗 변수값을 자동으로 변경하도록 지시해준다.
  bool _userLoggedIn = false;
  //프라이빗 변수값 접근 및 변경함수(프라이빗 변수에 유일하게 접근할 수 있는 void타입의 변경함수 선언)
  void SetUserAuth(bool authState){
    _userLoggedIn = authState;
    notifyListeners();//,해당 메소드는 데이터 변경시 관련된 위젯들에게 알려주는 통신소 같은 역할을 갖고 있다고 함.
  }
  //변경함수에 연결될 외부변수 선언(외부 로그인, 로그아웃 정보를 받아올 변수 선언)
  bool get userState => _userLoggedIn;

  final baseUrl = 'http://210.123.255.110:8080/app/';
}