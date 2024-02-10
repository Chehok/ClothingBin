import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final bool hasNotifications = false; // 알림이 있는지 여부

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
        child: hasNotifications
            ? ListView(
          children: [
            ListTile(
              title: Text('알림 1'),
              subtitle: Text('알림 내용 1'),
            ),
            ListTile(
              title: Text('알림 2'),
              subtitle: Text('알림 내용 2'),
            ),
            ListTile(
              title: Text('알림 3'),
              subtitle: Text('알림 내용 3'),
            ),
          ],
        )
            : Text('알림이 없습니다.'),
      ),
    );
  }
}
