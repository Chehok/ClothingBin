import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

String getSignature(
      String serviceId, String timeStamp, String accessKey, String secretKey) {
    
    serviceId = 'ncp:sms:kr:305557381485:smart_clothingbin';
    timeStamp = (DateTime.now().millisecondsSinceEpoch).toString();
    accessKey = 'xew13KI8UCXqlmYIc7FU';
    secretKey = 'rFnLK4uaIySURuYNgONqgFJEvUujlWpc7jkmRKBu'; 
    
    var space = " "; // one space
    var newLine = "\n"; // new line
    var method = "POST"; // method
    var url = "/sms/v2/services/ncp:sms:kr:305557381485:smart_clothingbin/messages";
    print(url);

    var buffer = new StringBuffer();
    buffer.write(method);
    buffer.write(space);
    buffer.write(url);
    buffer.write(newLine);
    buffer.write(timeStamp);
    buffer.write(newLine);
    buffer.write(accessKey);
    // print(buffer.toString());

    /// signing key
    var key = utf8.encode(secretKey);
    var signingKey = new Hmac(sha256, key);

    var bytes = utf8.encode(buffer.toString());
    var digest = signingKey.convert(bytes);
    String signatureKey = base64.encode(digest.bytes);
    return signatureKey;
  }

// Naver SMS API 설정
final String naverSmsApiURL = 'https://sens.apigw.ntruss.com/sms/v2/services/ncp:sms:kr:305557381485:smart_clothingbin/messages'; // Naver SMS API URL
final String naverSmsAccessKey = 'xew13KI8UCXqlmYIc7FU'; // Naver SMS API 액세스 키
final String naverSmsSecretKey = 'rFnLK4uaIySURuYNgONqgFJEvUujlWpc7jkmRKBu'; // Naver SMS API 시크릿 키
final String naverSmsServiceId = 'ncp:sms:kr:305557381485:smart_clothingbin'; // Naver SMS API 서비스 아이디

// SMS 보내기 함수
Future<void> sendSMS(String phoneNumber, String message) async {
  try {
    var now = (DateTime.now().millisecondsSinceEpoch).toString();

    // 인증 헤더 생성
    String credentials = base64Encode(utf8.encode('$naverSmsAccessKey:$naverSmsSecretKey'));
    // print(now);

    // SMS 발송 요청
    final response = await http.post(
      Uri.parse(naverSmsApiURL),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        // 'Authorization': 'Basic $credentials',
        'x-ncp-apigw-timestamp': '$now',
        'x-ncp-iam-access-key': '$naverSmsAccessKey',
        // 'x-ncp-apigw-signature-v2': '$naverSmsSecretKey',
        'x-ncp-apigw-signature-v2': getSignature(Uri.encodeComponent('$naverSmsServiceId'), '$now',
             '$naverSmsAccessKey', '$naverSmsSecretKey'),
      },
      body: jsonEncode({
        'type': 'SMS',
        'contentType': 'COMM',
        'countryCode': '82',
        'from': '010-9385-8858',
        'content': message,
        // 'serviceId': naverSmsServiceId, // 서비스 아이디 추가
        'messages': [
          {
            'to': phoneNumber,
            'content': message,
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      print('SMS sent successfully');
    } else {
      print('Failed to send SMS. Status code: ${response.statusCode}');
      print(response.body);
      print(getSignature(Uri.encodeComponent('$naverSmsServiceId'), '$now',
             '$naverSmsAccessKey', '$naverSmsSecretKey'));
    }
  } catch (e) {
    print('Exception occurred while sending SMS: $e');
  }
}

// void main() async {
//   // SMS 보내기 테스트
  
// }
