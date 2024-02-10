import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

DateTime? _currentBackPressTime;

Future<bool> onWillPop() async {
  DateTime _currentTime = DateTime.now();

  if (_currentBackPressTime == null ||
      _currentTime.difference(_currentBackPressTime!) > const Duration(seconds: 1)) {
    _currentBackPressTime = _currentTime;
    Fluttertoast.showToast(
        msg: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xff6E6E6E),
        fontSize: 20,
        toastLength: Toast.LENGTH_SHORT);
    return false;
  }
  return true;
}