import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile/screens/Product/pay.dart';
import 'package:mobile/services/bin_function.dart';

import '../../chat/chat_info.dart';
import '../../constants/variable.dart';
import '../home/home_screen.dart';

class ClothInfo extends StatefulWidget {
  final Map<String, dynamic> clothInfo;

  const ClothInfo({Key? key, required this.clothInfo}) : super(key: key);

  @override
  _ClothInfoState createState() => _ClothInfoState();
}

class _ClothInfoState extends State<ClothInfo> {
  List _clothesInfoList = [];

  @override
  void initState() {
    super.initState();
    _getAllClothesInfo();
  }

  Future<void> _getAllClothesInfo() async {
    final clothesInfoList = await getAllClothesInfo(clothingBinId);
    setState(() {
      _clothesInfoList = clothesInfoList;
    });
  }

  void _deleteCloth(String clothId) async {
    try {
      await deleteCloth(int.parse(clothId));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('의류가 삭제되었습니다.')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류가 발생하였습니다.')),
      );
    }
  }

  void _viewClothInfo(String clothId) {
    // 의류 정보 화면으로 이동하는 코드를 작성하세요
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의류 상세 정보'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
              // 알림 버튼이 눌렸을 때 실행될 코드 작성
              // 예를 들어, 알림 페이지로 이동하는 코드를 작성
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.clothInfo['imgLink']),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.clothInfo['clothName'] ?? '',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '가격: ' + widget.clothInfo['price'] + '원' ?? '',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '보관함 번호: ${widget.clothInfo['lockerNum'] ?? ''}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '카테고리: ${widget.clothInfo['category'] ?? ''}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '설명: ${widget.clothInfo['description'] ?? ''}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatInfo()));
              },
              child: Text('채팅'),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>PayScreen())
              );
            }, child: Text('결제')),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '더보기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _clothesInfoList.length,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>ClothInfo(clothInfo: _clothesInfoList[index]))
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: 120,
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      _clothesInfoList[index]['imgLink']),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _clothesInfoList[index]['clothName'] ?? '',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
