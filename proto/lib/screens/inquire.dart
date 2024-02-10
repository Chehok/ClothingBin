import 'package:flutter/material.dart';
import 'package:proto/constants/variable.dart';
import '../api/bin_function.dart';
import 'cloth_info.dart';

class Inquire extends StatefulWidget {
  final List clothesList;

  const Inquire({Key? key, required this.clothesList}) : super(key: key);

  @override
  _InquireState createState() => _InquireState();
}

class _InquireState extends State<Inquire> {
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


// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:proto/api/bin_function.dart';
// import 'package:proto/screens/cloth_info.dart';
//
// class Inquire extends StatefulWidget {
//   final List clothesList;
//
//   const Inquire({Key? key, required this.clothesList}) : super(key: key);
//
//   @override
//   _InquireState createState() => _InquireState();
// }
//
// class _InquireState extends State<Inquire> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('의류 조회'),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),
//       body: FutureBuilder(
//         future: getAllClothesInfo(1),
//         builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
//           if (snapshot.hasData) {
//             final List clothesInfoList = snapshot.data ?? [];
//             return ListView.builder(
//               itemCount: clothesInfoList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   height: MediaQuery.of(context).size.height * 0.2,
//                   child: ElevatedButton(
//                     style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),
//                     ),
//                     onPressed: () async{
//                       getClothInfo(clothesInfoList[index]['clothId']);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => (ClothInfo(clothesList: [],)),
//                         ),
//                       );
//                     },
//                     child: Row(
//                       children: [
//                         Flexible(
//                           flex: 1,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 fit: BoxFit.fitWidth,
//                                 image: NetworkImage(
//                                     clothesInfoList[index]['imgLink']),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Flexible(
//                           flex: 2,
//                           child: Container(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   clothesInfoList[index]['clothName'] ?? '',
//                                   style: TextStyle(fontSize: 40,color: Colors.black),
//                                 ),
//                                 Text(
//                                   clothesInfoList[index]['price'] + '원' ?? '',
//                                   style: TextStyle(fontSize: 25, color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
