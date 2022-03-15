import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const MapSample(),
    );
  }
}
class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}
class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target:LatLng(37.42796133580664, -122.085749655962),
    zoom:14.4746,
  );
  static const CameraPosition _klake = CameraPosition(
    bearing:192.8334901395799,
     target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(
        mapType:MapType.hybrid,
        initialCameraPosition:_kGooglePlex,
        onMapCreated:(GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
         label: const Text('To The Lake!'),
         icon: const Icon(Icons.directions_boat),
        ),
    );
  }
  Future<void>_goToTheLake()async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_klake));
  }
}
