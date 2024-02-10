import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiosk/api/bin_function.dart';

class ClothInfo extends StatefulWidget {
  final Map<String, dynamic> clothInfo;

  const ClothInfo({Key? key, required this.clothInfo}) : super(key: key);

  @override
  _ClothInfoState createState() => _ClothInfoState();
}

class _ClothInfoState extends State<ClothInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의류 상세 정보'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Flexible(
            child: Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(widget.clothInfo['imgLink']),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.clothInfo['clothName'] ?? '',
                    style: TextStyle(fontSize: 45, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '가격: ' + widget.clothInfo['price'] + '원' ?? '',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '색상: ${widget.clothInfo['color'] ?? ''}',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '크기: ${widget.clothInfo['size'] ?? ''}',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '카테고리: ${widget.clothInfo['category'] ?? ''}',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}