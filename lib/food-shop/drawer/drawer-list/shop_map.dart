import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopMap extends StatefulWidget {
  @override
  _ShopMapState createState() => _ShopMapState();
}

class _ShopMapState extends State<ShopMap> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 70,
                width: double.infinity,
              ),
              Text(
                'Food Made To Order Shop',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              Container(
                height: 400,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(13.6470792, 100.6772441),
                    zoom: 15.85,
                  ),
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId('Shop\' location'),
                      position: LatLng(13.6467163, 100.6780772),
                      infoWindow: InfoWindow(
                          title: 'mega bangna', snippet: 'Shop\' location'),
                    )
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
