import 'package:flutter/widgets.dart';
import 'package:kiosk/api/bin_function.dart';

class UserProvider extends ChangeNotifier {
  bool _userLoggedIn = false;
  String _sentVerificationCode = '';

  bool get userState => _userLoggedIn;

  void setUserAuth(bool authState) {
    _userLoggedIn = authState;
    notifyListeners();
  }

  final String baseUrl = 'http://210.123.255.110:8080/app/';

  Future<void> authenticate(String phoneNumber, int code) async {
    try {
      await sendSMSVerification(phoneNumber);
      await verifySMSCode(phoneNumber, code);
      setUserAuth(true); // 사용자 인증 성공 시 상태 변경
    } catch (error) {
      setUserAuth(false); // 사용자 인증 실패 시 상태 변경
      throw error;
    }
  }

  Future<Map<String, dynamic>> sendSMSVerification(String phoneNumber) async {
    final res = await dio.get('/users/phone', queryParameters: {
      'phoneNum': phoneNumber,
    });

    if (res.data.containsKey('isSuccess') == true) {
      _sentVerificationCode = res.data['code'].toString();
      return res.data;
    } else {
      throw Exception('SMS 인증 요청 실패');
    }
  }

  Future<Map<String, dynamic>> verifySMSCode(String phoneNumber,
      int code) async {
    try {
      final res = await dio.post('/users/phone', data: {
        'phoneNum': phoneNumber,
        'certificationNum': code,
      });

      if (res.data.containsKey('isSuccess') == true) {
        return res.data;
      } else {
        throw Exception('SMS 코드 확인 실패');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}