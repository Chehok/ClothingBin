import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../constants/variable.dart';
import '../../services/bin_function.dart';
import 'detail.dart';

class Inquire extends StatefulWidget {
  final List clothesInfoList;
  // final int clothingBinId;

  const Inquire({Key? key, required this.clothesInfoList}) : super(key: key);

  @override
  _InquireState createState() => _InquireState();
}

class _InquireState extends State<Inquire> {
  // List clothesInfoList = [];

  @override
  void initState() {
    super.initState();
    // _getAllClothesInfo();
  }//

  // Future<void> _getAllClothesInfo() async {
  //   final clothesInfoList = await getAllClothesInfo(widget.clothingBinId);
  //   setState(() {
  //     _clothesInfoList = clothesInfoList;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의류 조회'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: widget.clothesInfoList.isEmpty ? Center(
        child: Text("옷이 없습니다."),
      ) : ListView.builder(
        itemCount: widget.clothesInfoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClothInfo(
                      clothInfo: widget.clothesInfoList[index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8.0), // Add desired spacing here
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.clothesInfoList[index]['imgLink'],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.clothesInfoList[index]['clothName'] ?? '',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8.0), // Add vertical spacing
                            Text(
                              '${widget.clothesInfoList[index]['category']} ' ??
                                  '',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${widget.clothesInfoList[index]['price']}원' ??
                                  '',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
