import 'package:flutter/material.dart';
import 'package:eshnly/constants.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("E47nly"),
        backgroundColor: green1,
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              /*GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),*/
            ],
        ),
      ),

    );
  }
}

/*
class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(30.061598, 31.235787);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
*/
