// TextButton(
//
// onPressed: () async {
// // dio 기초 설정. 잘 써~
// var dio = Dio();
// var options = BaseOptions(
//   baseUrl: UserProvider().baseUrl,
//   connectTimeout: 3000,
//   receiveTimeout: 1000,
// );
// dio = Dio(options);
//
// // 버튼이 눌리는 조건(_formKey.currentState)가 값이 null이 아니고,
// // validate()가 true (전화번호 값이 정상적) 이면 넘어간다.
// if (_formKey.currentState != null &&
// _formKey.currentState!.validate()) {
// setState(() {
// // 이건 뭐야?
// _verificationStatus = VerificationStatus.codeSent;
// });
// // response
// final res = await dio.post(
// 'bins/phoneNum', // 주소 uri
// queryParameters: {'phoneNum': phoneNumber}// 쿼리스트링: ?phoneNum={phoneNumber}
// );
//
// // Response인 jsonString을 dart의 객체 자료형으로 바꿈
// // key: String, value: dynamic(아무거나)
// Map<String, dynamic> object = jsonDecode(res.toString());
//
// // 객체 키 값을 통해 접근하는 방법.
// print(object.containsKey('isSuccess'));
// print(object['isSuccess']);
//
// // Map<String, dynamic> hello = {
// //   "clothingBinId": 1,
// //   "address":  "주소",
// // };
// // print(jsonEncode(hello));
// }
// },
// child: Text('인증문자 발송'),
// ),