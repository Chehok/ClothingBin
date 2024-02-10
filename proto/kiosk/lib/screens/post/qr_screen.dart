import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text('QR코드 스캔')),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                data: "https://www.google.com/",
                backgroundColor: Colors.white,
                size: 400,
              )
            ],
          ),
        ),

      )
      ,
    );
  }
}
