import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_ui/food-shop/components/drawer_list_card.dart';
import 'package:login_ui/food-shop/data/drawer_list.dart';
import 'package:login_ui/food-shop/drawer/drawer-header/drawer_header.dart';

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
        title: Text("Map"),
      ),
        drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              drawerHeader(),
              ...drawerList.map((e) {
                if (e.isLoggedIn != null) {
                  return DrawerList(
                    icon: e.icon,
                    title: e.title,
                    page: e.page,
                    isLoggedOut: true,
                  );
                }
                return DrawerList(
                  icon: e.icon,
                  title: e.title,
                  page: e.page,
                );
              })
            ],
          ),
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
