import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobile/constants/variable.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobile/states/user_provider.dart';

bool _userLoggedIn = false;

var options = BaseOptions(
  baseUrl: serverUrl,
  connectTimeout: 5000,
  receiveTimeout: 5000,
);

Dio dio = Dio(options);

// 테스트 완.
// Future<Map<String, dynamic>> getAllAddress() async {
Future<List<dynamic>> getAllAddress() async {
  try {
    final res = await dio.get('/bins/address');

    if (res.data['isSuccess'] == true) {
      // API에서 반환된 JSON 데이터를 디코딩합니다.
      return res.data['result'];
    } else {
      throw Exception('Failed to load API data');
    }
  } catch (e) {
    throw Exception('서버 연결 오류');
  }
}

Future<List<dynamic>> getAllClothesInfo(int clothingBinId) async {
  List list = [];
  try {
    final res = await dio
        .get('/cloth', queryParameters: {'clothingBinId': '$clothingBinId'});

    if (res.data['isSuccess'] == true) {
      // API에서 반환된 JSON 데이터를 디코딩합니다.
      if(res.data['message'] == "옷이 없습니다."){
        // list.add({'message': res.data['message']});
        return list;
      }
      return res.data['result'];
    } else {
      throw Exception('Failed to load API data');
    }
  } catch (e) {
    throw Exception('서버 연결 오류');
  }
}

Future<Map<String, dynamic>> getClothInfo(int clothId) async {
  try {
    final res =
        await dio.get('/cloth/get', queryParameters: {'clothId': '${clothId}'});

    if (res.data.containsKey('isSuccess') == true) {
      // API에서 반환된 JSON 데이터를 디코딩합니다.
      return res.data['result'];
    } else {
      throw Exception('Failed to load API data');
    }
  } catch (e) {
    throw Exception('서버 연결 오류');
  }
}

// 테스트 NO
Future<Map<String, dynamic>> throwCloth(clothingBinId) async {
  // locker Num을 가져오기 위한 api가 있어야 겠네

  if (!_userLoggedIn) throw Exception('로그인이 필요합니다.');

  dio.options.headers["X-ACCESS-TOKEN"] = userId;

  try {
    final res = await dio.post('/cloth/throw', data: {
      "clothingBinId": clothingBinId,
    });

    if (res.data['isSuccess'] == true) {
      // API에서 반환된 JSON 데이터를 디코딩합니다.
      return res.data;
    } else {
      throw Exception('Failed to load API data');
    }
  } catch (e) {
    throw Exception('서버 연결 오류');
  }
}

Future<Map<String, dynamic>> inputCloth(clothName, category, price, description,
    imgLink, clothingBinId, lockerNum) async {
  // locker Num을 가져오기 위한 api가 있어야 겠네

  if (!_userLoggedIn) throw Exception('로그인이 필요합니다.');

  dio.options.headers["X-ACCESS-TOKEN"] = userId;

  try {
    final res = await dio.post('/cloth/input', data: {
      "clothName": clothName,
      "category": category,
      "price": price,
      "description": description,
      "imgLink": imgLink,
      "clothingBinId": clothingBinId,
      "lockerNum": lockerNum,
      // "userId" : userId
    });

    if (res.data['isSuccess'] == true) {
      // API에서 반환된 JSON 데이터를 디코딩합니다.
      return res.data;
    } else {
      throw Exception('Failed to load API data');
    }
  } catch (e) {
    throw Exception('서버 연결 오류');
  }
}

//========================================================================================
// 테스트 NO
//서버에 sms 인증 요청을 보내는 함수
Future<Map<String, dynamic>> sendSMSVerification(String phoneNumber) async {
  try {
    final res = await dio.get('/users/phone', queryParameters: {
      'phoneNum': phoneNumber,
    });

    if (res.data.containsKey('isSuccess') == true) {
      return res.data;
    } else {
      throw Exception('SMS 인증 요청 실패');
    }
  } catch (error) {
    throw Exception('서버 연결 오류');
  }
}

//사용자로부터 받은 sms 코드를 확인하는 함수
Future<Map<String, dynamic>> verifySMSCode(String phoneNumber, int code) async {
  try {
    final res = await dio.post('/users/phone', data: {
      'phoneNum': phoneNumber,
      'certificationNum': code,
    });
    if (res.data.containsKey('isSuccess') == true) {
      _userLoggedIn = true;
      userId = res.data['result']['userId'];
      certifyMember = res.data['result']['certifyMember'];
      return res.data;
    } else {
      _userLoggedIn = false;
      throw Exception('인증번호가 틀렸습니다.');
    }
  } catch (error) {
    throw Exception('서버 연결 오류');
  }
}

Future<Map<String, dynamic>> login(String username, String password) async {
  try {
    final res = await dio.post('/users/sign-in', data: {
      'username': username,
      'password': password,
    });

    // res.data 출력
    print("Response data: ${res.data}");

    if (res.data['isSuccess'] == true) {
      // 로그인 성공 시 서버 응답 데이터를 반환합니다.
      _userLoggedIn = true;
      userId = res.data['result']['userId']; // userId의 jwt 값
      certifyMember = res.data['result']['certifyMember'];
      return res.data;
    } else {
      _userLoggedIn = false;
      throw Exception('로그인 실패');
    }
  } catch (e) {
    _userLoggedIn = false;
    // print(e);
    throw Exception('서버 연결 오류');
  }
}

void logout() {
  userId = "";
  certifyMember = 'N';
  _userLoggedIn = false;
}
//의류 구매 및 삭제 함수

// Future<void> purchaseCloth(String clothId) async {
//   try {
//     // 의류 구매 API 호출
//     final res = await dio.post('/purchase', data: {
//       "clothId": clothId,
//     });
//
//     if (res.data.containsKey('isSuccess') && res.data['isSuccess'] == true) {
//       // 의류 구매 성공 시, 삭제 API 호출
//       await deleteCloth(clothId);
//     } else {
//       throw Exception('Failed to purchase cloth');
//     }
//   } catch (e) {
//     print(e);
//     throw Exception('Failed to purchase cloth');
//   }
// }

// 의류 삭제 함수
Future<void> deleteCloth(int clothId) async {
  if (!_userLoggedIn) {
    throw Exception('로그인이 필요합니다.');
  }
  try {
    // 의류 삭제 API 호출
    final res =
        await dio.delete('/cloth', queryParameters: {'clothId': clothId});

    if (res.data.containsKey('isSuccess') && res.data['isSuccess'] == true) {
      print('Cloth deleted successfully');
    } else {
      throw Exception('옷 삭제 실패');
    }
  } catch (e) {
    print(e);
    throw Exception('서버 연결 오류');
  }
}

//회원가입 함수

Future<Map<String, dynamic>> signUp(String username, String password,
    String name, String phoneNum, String email, String profileImg,) async {
  try {
    final res = await dio.post('/users/sign-up', data: {
      'username': username,
      'password': password,
      'name': name,
      'phoneNum': phoneNum,
      'email': email,
      'profileImg': profileImg,
    });

    if (res.data.containsKey('isSuccess') == true) {
      return res.data;
    } else {
      throw Exception('회원가입 실패');
    }
  } catch (e) {
    print(e);
    throw Exception('서버 연결 오류');
  }
}

Future<bool> idCheck(String username) async {
  try {
    final res = await dio.get('/users/id-Check', queryParameters: {"username": username});

    if (res.data.containsKey('isSuccess') == true) {
      return res.data['result'];
    } else {
      throw Exception('아이디 체크 실패');
    }
  } catch (e) {
    print(e);
    throw Exception('서버 연결 오류');
  }
}

Future<Map<String, dynamic>?> uploadFile() async {
  // file picker를 통해 파일 선택
  // FilePickerResult? result = await FilePicker.platform.pickFiles();
  // if(!isLoggedIn()) throw Exception('로그인이 필요합니다.');
  // if(UserProvider.getUserAuth()) throw Exception('로그인이 필요합니다.');

  try {
    PickedFile? result =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (result != null) {
      // final filePath = result.files.single.path;
      final filePath = result.path;

      // 파일 경로를 통해 formData 생성
      var formData =
          FormData.fromMap({'image': await MultipartFile.fromFile(filePath!)});

      // 업로드 요청
      final res = await dio.post('/files/upload', data: formData);

      if (res.data.containsKey('isSuccess') == true) {
        return res.data;
      } else {
        throw Exception('파일 업로드 실패');
      }
    } else {
      // 아무런 파일도 선택되지 않음.
    }
  } catch (e) {
    print(e);
    // throw Exception('파일 업로드 실패');
    // throw e;
    rethrow;
  }
}

Future<Map<String, dynamic>> getUserInfo() async {
  if (userId == "") throw new Exception();
  try {
    dio.options.headers["X-ACCESS-TOKEN"] = userId;
    final res = await dio.get('/users/user');

    if (res.data.containsKey('isSuccess') == true) {
      return res.data;
    } else {
      throw Exception('정보 조회 실패');
    }
  } catch (e) {
    print(e);
    throw Exception('서버 연결 오류');
  }
}

Future<Map<String, dynamic>> modifyUserInfo(
    String name, String profileImg, String email, String phoneNum) async {
  try {
    dio.options.headers["X-ACCESS-TOKEN"] = userId;
    final res = await dio.patch('/users/user', data: {
      'name': name != '' ? name : null,
      'profileImg': profileImg != '' ? profileImg : null,
      'phoneNum': phoneNum != '' ? phoneNum : null,
      'email': email != '' ? email : null,
    });

    if (res.data.containsKey('isSuccess') == true) {
      print(res.data);
      return res.data;
    } else {
      throw Exception('정보 수정 실패');
    }
  } catch (e) {
    // print(e);
    throw Exception('서버 연결 오류');
  }
}

bool isLoggedIn() {
  // throw Exception('로그인이 필요합니다.');
  print(_userLoggedIn);
  return _userLoggedIn;
}

//이미지 업로드 하는 함수

// Future uploadImage() async {
//
//   var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload')); // 업로드할 URL
//   request.files.add(await http.MultipartFile.fromPath('image', _image.path)); // 이미지 파일 첨부
//
//   var response = await request.send();
//   if (response.statusCode == 200) {
//     print('이미지 업로드 성공');
//     // 업로드 성공 후 필요한 로직 처리
//   } else {
//     print('이미지 업로드 실패');
//   }
// }

//
