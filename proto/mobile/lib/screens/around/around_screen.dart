import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/constants/variable.dart';
import 'package:mobile/screens/Product/product.dart';
import 'package:mobile/services/bin_function.dart';

class Around extends StatefulWidget {
  const Around({Key? key}) : super(key: key);

  @override
  _AroundState createState() => _AroundState();
}

class _AroundState extends State<Around> {
  late GoogleMapController mapController;
  // latitude, longitude
  final LatLng _koreaSeongseoUniversity = const LatLng(37.649279918895, 127.064085591);
  // final LatLng _milalHall = const LatLng(37.649209, 127.064402);
  // final LatLng _illeopHall = const LatLng(37.649105, 127.064497);
  // final LatLng _moriahHall = const LatLng(37.649033, 127.064301);

  final Set<Marker> _markers = new Set();

  @override
  void initState() {
    super.initState();
    _getAllAddress();
  }

  Future<void> _getAllAddress() async {
    final addressList = await getAllAddress();
    print('addressList $addressList ${addressList.length}');
    setState(() {
      for (var i = 0; i < addressList.length; i++) {
        _markers.add(Marker( //add first marker
          markerId: MarkerId(addressList[i]['binName']),
          position: LatLng(addressList[i]['latitude'],addressList[i]['longitude']), //position of marker
          infoWindow: InfoWindow( //popup info
            title: '${addressList[i]['binName']}',
          ),
          onTap: () async {
            var clothesList = await getAllClothesInfo(addressList[i]['clothingBinId']);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Inquire(clothesInfoList: clothesList,)),
            );
            _showMarkerInfo('${addressList[i]['binName']} 거래함\n위치: ${addressList[i]['location']}\n보관함 상태: ${clothesList.length}/10');
          },
          // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _onMapCreated();
  // }

  void _showMarkerInfo(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('거래소 정보'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주변 거래소 조회'),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _koreaSeongseoUniversity,
          zoom: 15.0,
        ),
        markers: _markers,
        // {
        //   Marker(
        //     markerId: MarkerId('korea_seongseo_university'),
        //     position: _koreaSeongseoUniversity,
        //     infoWindow: InfoWindow(title: '성서대학교'),
        //     onTap: () async {
        //       var clothesList = await getAllClothesInfo(clothingBinId);
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => Inquire(clothesList: clothesList)),
        //       );
        //       _showMarkerInfo('갈멜관 거래함\n위치: 갈멜관 1층\n보관함 상태: ${clothesList.length}/10');
        //     },
        //   ),
        //   Marker(
        //     markerId: MarkerId('milal_hall'),
        //     position: _milalHall,
        //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        //     infoWindow: InfoWindow(title: '성서대학교 밀알관'),
        //     onTap: () async {
        //       var clothesList = await getAllClothesInfo(clothingBinId);
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => Inquire(clothesList: clothesList)),
        //       );
        //       _showMarkerInfo('밀알관 거래함\n위치: 밀알관 1층\n보관함 상태: ${clothesList.length}/10');
        //     },
        //   ),
        //   Marker(
        //     markerId: MarkerId('illeop_hall'),
        //     position: _illeopHall,
        //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        //     infoWindow: InfoWindow(title: '성서대학교 일립관'),
        //     onTap: () async {
        //       var clothesList = await getAllClothesInfo(clothingBinId);
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => Inquire(clothesList: clothesList)),
        //       );
        //       _showMarkerInfo('일립관 거래함\n위치: 일립관 1층\n보관함 상태: ${clothesList.length}/10');
        //     },
        //   ),
        //   Marker(
        //     markerId: MarkerId('moriah_hall'),
        //     position: _moriahHall,
        //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        //     infoWindow: InfoWindow(title: '성서대학교 모리아관'),
        //     onTap: () async {
        //       var clothesList = await getAllClothesInfo(clothingBinId);
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => Inquire(clothesList: clothesList)),
        //       );
        //       _showMarkerInfo('모리아관 거래함\n위치: 모리아관 1층\n보관함 상태: ${clothesList.length}/10');
        //     },
        //   ),
        // },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final GoogleMapController controller = await mapController;
          controller.animateCamera(
            CameraUpdate.newLatLng(_koreaSeongseoUniversity),
          );
        },
        label: const Text('현재 위치'),
        icon: const Icon(Icons.location_on),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
