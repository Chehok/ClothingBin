//추후 수정예정
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Around extends StatefulWidget {
  const Around({Key? key}) : super(key: key);

  @override
  State<Around> createState() => _AroundState();
}

class _AroundState extends State<Around> {
  final Completer<GoogleMapController>_controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track order",
          style: TextStyle(color: Colors.black,fontSize: 16),
        ),
      ),
      body: const Center(
        child: GoogleMap(initialCameraPosition: CameraPosition(target: sourceLocation))
      ),
    );
  }
}
