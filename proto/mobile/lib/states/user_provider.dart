import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/services/bin_function.dart';

class UserProvider extends ChangeNotifier {
  Dio dio = Dio(options);
  bool _userLoggedIn = false;
  // String _username = '';
  // String _phoneNumber = '';
  // String _sentVerificationCode = '';

  // bool get userState => _userLoggedIn;

  // String get username => _username;
  //
  // String get phoneNumber => _phoneNumber;

  void setUserAuth(bool authState) {
    _userLoggedIn = authState;
    notifyListeners();
  }

  bool getUserAuth() {
    return _userLoggedIn;
  }

  // Future<void> authenticate(String phoneNumber, int code) async {
  //   try {
  //     await sendSMSVerification(phoneNumber);
  //     await verifySMSCode(phoneNumber, code);
  //     setUserAuth(true); // 사용자 인증 성공 시 상태 변경
  //   } catch (error) {
  //     setUserAuth(false); // 사용자 인증 실패 시 상태 변경
  //     throw error;
  //   }
  // }

  // Future<Map<String, dynamic>> sendSMSVerification(String phoneNumber) async {
  //   final res = await dio.get('/users/phone', queryParameters: {
  //     'phoneNum': phoneNumber,
  //   });
  //
  //   if (res.data.containsKey('isSuccess') == true) {
  //     // _sentVerificationCode = res.data['code'].toString();
  //     return res.data;
  //   } else {
  //     throw Exception('SMS 인증 요청 실패');
  //   }
  // }

  // Future<Map<String, dynamic>> verifySMSCode(String phoneNumber,
  //     int code) async {
  //   try {
  //     final res = await dio.post('/users/phone', data: {
  //       'phoneNum': phoneNumber,
  //       'certificationNum': code,
  //     });
  //
  //     if (res.data.containsKey('isSuccess') == true) {
  //       return res.data;
  //     } else {
  //       throw Exception('SMS 코드 확인 실패');
  //     }
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

//회원가입
//   Future<Map<String, dynamic>> signUp(String username,
//       String password,
//       String name,
//       String phoneNum,
//       String email,
//       String profileImg,) async {
//     try {
//       final response = await dio.post('/users/sign-up', data: {
//         'username': username,
//         'password': password,
//         'name': name,
//         'phoneNum': phoneNum,
//         'email': email,
//         'profileImg': profileImg,
//       });
//
//       if (response.statusCode == 200 &&
//           response.data.containsKey('isSuccess') &&
//           response.data['isSuccess'] == true) {
//         return response.data;
//       } else {
//         throw Exception('회원가입 실패');
//       }
//     } catch (e) {
//       print(e);
//       throw Exception('회원가입 실패');
//     }
//   }

//로그인 함수


  // //사진 업로드
  // Future<dynamic> uploadFile() async {
  //   // file picker를 통해 파일 선택
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  //   if (result != null) {
  //     final filePath = result.files.single.path;
  //
  //     // 파일 경로를 통해 formData 생성
  //     var formData = FormData.fromMap({
  //       'image' : await MultipartFile.fromFile(filePath!)
  //     });
  //
  //     // 업로드 요청
  //     final response = await dio.post('/files/upload', data: formData);
  //     return response;
  //   } else {
  //     // 아무런 파일도 선택되지 않음.
  //   }
  // }
}