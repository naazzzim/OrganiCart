import 'dart:async';

import 'package:farmerApp/Screens/Classes.dart';
import 'package:farmerApp/Screens/Loading.dart';
import 'package:farmerApp/Screens/Theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetLocation extends StatefulWidget {
  static String id = 'SetLocation';
  GeoLocation geoLocation;
  SetLocation({this.geoLocation});
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  Location location = new Location();
  List<Marker> myMarker = [];
  LatLng latLng;
  String geohash;
  GoogleMapController mapController;
  CameraPosition _currentPosition;
  int i = 0;
  Geoflutterfire geo = Geoflutterfire();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription subscription;
  double radius = 10;
  bool loading = true;
  LocationData pos;

  @override
  void initState() {
    location.getLocation().then((value) {
      setState(() {
        if(widget.geoLocation != null){
          myMarker = [Marker(
              position: LatLng(widget.geoLocation.geopoint.latitude,widget.geoLocation.geopoint.longitude),
              icon: BitmapDescriptor.defaultMarker,
              markerId: MarkerId(widget.geoLocation.geohash),
              infoWindow: InfoWindow(title: " New Market",))];
        }
        pos = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Choose Market Location'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onTap: _addMarker,
              initialCameraPosition: CameraPosition(
                  target: LatLng(pos.latitude, pos.longitude), zoom: 14),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              mapType: MapType.hybrid,
              compassEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              cameraTargetBounds: CameraTargetBounds.unbounded,
              buildingsEnabled: true,
              onCameraMove: (CameraPosition position) {
                _setCurrentPosition(position);
              },
              markers: Set.from(myMarker),
            ),
            Positioned(
              child: Slider(
                min: 10.0,
                max: 50.0,
                divisions: 4,
                value: radius,
                label: 'Radius $radius km',
                activeColor: Colors.green,
                onChanged: _updateQuery,
              ),
              bottom: 80,
              left: 10,
            ),
            Positioned(
              bottom: 150,
              left: width/4,
              child: FlatButton(
                  onPressed: () async{
                    if(myMarker.length > 0)
                    Navigator.pop(context,GeoLocation(geopoint: GeoPoint(latLng.latitude,latLng.longitude),geohash: geohash));
                },
                  color: LightTheme.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 10.0,),
                        Text('Use Marked Location',
                          style: TextStyle(
                              color: LightTheme.darkGray,
                              fontWeight: FontWeight.w300,
                              fontSize: 14) ,),
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      );
    }
  }

  _addMarker(LatLng position) {
    setState(() {
      latLng = position;
      GeoFirePoint point = geo.point(latitude: position.latitude, longitude: position.longitude);
      geohash = point.data['geohash'];
      myMarker = [ Marker(
          position: LatLng(point.latitude, point.longitude),
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId(point.data['geohash']),
          infoWindow: InfoWindow(title: " New Market",))];
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _setCurrentPosition(CameraPosition position) {
    _currentPosition = position;
  }

  _updateQuery(value) {
    final zoomMap = {
      10.0: 14.0,
      20.0: 13.0,
      30.0: 12.0,
      40.0: 11.6,
      50.0: 11.3
    };
    mapController.animateCamera(CameraUpdate.zoomTo(zoomMap[value]));
    setState(() {
      radius = value;
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}
