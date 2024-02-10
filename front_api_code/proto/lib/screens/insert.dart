import 'package:flutter/material.dart';
import 'dart:async';

import 'home.dart';

class Insert extends StatefulWidget {
  const Insert({Key? key}) : super(key: key);

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  static const TenSeconds = 10;
  int totalSeconds = TenSeconds;
  bool isRunning = false;
  bool isOpen = false;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isOpen = false;
        isRunning = false;
        totalSeconds = TenSeconds;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text('시간 초과'),
            ),
            content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Center(child: Text('다시 인증해주세요.')),
                  ],
                ),
              ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
                child: Center(child: Text('확인')),
              ),
            ],
          );
        },
      );
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      //주기마다 실행하게해줌 periodic
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
      isOpen = true;
    });
  }

  void onPausedPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      isOpen = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('안내문'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text('인증을 다시 해주세요.')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
              child: Center(child: Text('확인')),
            ),
          ],
        );
      },
    );
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의류 투입하기'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ), //시간표시
          Flexible(
            flex: 3,
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        onPressed: isRunning ? onPausedPressed : onStartPressed,
                        icon: Icon(isRunning ? Icons.lock_open : Icons.lock)),
                  ],
                ),
              ),
            ),
          ), //동작 버튼
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '수거함 상태',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color),
                        ),
                        Text(
                          isOpen ? "open" : "closed",
                          style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ), //하단 포모도로 횟수 표시
        ],
      ),
    );
  }
}
