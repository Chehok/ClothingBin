
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:proto/main.dart';
import 'package:proto/api/bin_function.dart';
// import 'package:proto/api/member_function.dart';
import '../../proto/lib/constants/variable.dart';

import 'package:proto/api/naver_sms.dart';

void main() {
  test('Counter increments smoke test', () async {

    await sendSMS('010-8749-3678', 'This is a test message from Flutter app');

    print(await getAllAddress());
  });
}
