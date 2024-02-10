import 'package:flutter/material.dart';
import 'package:kiosk/constants/variable.dart';
import '../api/bin_function.dart';
import 'detail_screen.dart';

class Product extends StatefulWidget {
  final List clothesList;

  const Product({Key? key, required this.clothesList}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('의류 조회'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: _clothesInfoList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _clothesInfoList.length,
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
                    builder: (context) => ClothInfo(clothInfo: _clothesInfoList[index]),
                  ),
                );
              },
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(
                            _clothesInfoList[index]['imgLink'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            _clothesInfoList[index]['clothName'] ?? '',
                            style: TextStyle(fontSize: 40, color: Colors.black),
                          ),
                          Text(
                            _clothesInfoList[index]['price'] + '원' ?? '',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


