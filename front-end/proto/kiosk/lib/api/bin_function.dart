
import 'package:dio/dio.dart';
import 'package:kiosk/constants/variable.dart';


var options = BaseOptions(
  baseUrl: serverUrl,
  connectTimeout: 5000,
  receiveTimeout: 5000,
);

Dio dio = Dio(options);


// 테스트 완.
Future<Map<String, dynamic>> getAllAddress() async {
  final res = await dio.get('/bins/address');

  if (res.statusCode == 200) {
    // API에서 반환된 JSON 데이터를 디코딩합니다.
    return res.data;
  } else {
    throw Exception('Failed to load API data');
  }
}
// res.contains['isSuccess']

Future<List<dynamic>> getAllClothesInfo(int clothingBinId) async {
  final res = await dio.get('/cloth', queryParameters: {'clothingBinId': '${clothingBinId}'});

  if (res.data['isSuccess'] == true) {
    // API에서 반환된 JSON 데이터를 디코딩합니다.
    return res.data['result'];
  } else {
    throw Exception('Failed to load API data');
  }
}

Future<Map<String, dynamic>> getClothInfo(int clothId) async {
  final res = await dio.get('/cloth/get', queryParameters: {'clothId': '${clothId}'});

  if (res.data.containsKey('isSuccess') == true) {
    // API에서 반환된 JSON 데이터를 디코딩합니다.
    return res.data['result'];
  } else {
    throw Exception('Failed to load API data');
  }
}

// 테스트 NO
Future<Map<String, dynamic>> inputCloth(
    clothName, category, price, description, imgLink, insertDate, clothingBinId, lockerNum, userId) async { // locker Num을 가져오기 위한 api가 있어야 겠네

  final res = await dio.post('/cloth', data: {

    "clothName": clothName,
    "category" : category,
    "price" : price,
    "description" : description,
    "imgLink" : imgLink,
    "insertDate": insertDate,
    "clothingBinId" : clothingBinId,
    "lockerNum" : lockerNum,
    "userId" : userId
  });

  if (res.data.containsKey('isSuccess') == true) {
    // API에서 반환된 JSON 데이터를 디코딩합니다.
    return res.data;
  } else {
    throw Exception('Failed to load API data');
  }
}

//========================================================================================
// 테스트 NO

Future<int> getLockerNum () async { // lockerNum을 가져오기 위한 api
  return 1;
}
