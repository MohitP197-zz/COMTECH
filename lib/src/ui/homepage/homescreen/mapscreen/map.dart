// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  // Completer<GoogleMapController> controller = Completer();
  GoogleMapController mapController;


  static const LatLng _latlan = const LatLng(40.7128, -74.0060);

  String searchAddr;

  // void _onMapCreated(GoogleMapController controller) {
  //   controller.complete(controller);
  // }

  final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps', style: app,),
        centerTitle: true,
      ),

      // body: GoogleMap(
      //   onMapCreated: _onMapCreated,
      //   initialCameraPosition: CameraPosition(
      //     target: _center,
      //     zoom: 11.0
      //   ),
      // ),

      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller){
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _latlan,
              zoom: 10.0
            ),
          ),

          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), 
                color: Colors.white
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter location',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: searchandNavigate,
                    iconSize: 30.0,
                  ),
                ),

                onChanged: (val){
                  setState(() {
                   searchAddr = val; 
                  });
                },
              ),
            ),
          )
        ],
      ),
      
    );
  }

  searchandNavigate() {
    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 8.0)));
    });
  }

  // void onMapCreated(controller) {
  //   setState(() {
  //     controller = controller;
  //   });
  // }
}