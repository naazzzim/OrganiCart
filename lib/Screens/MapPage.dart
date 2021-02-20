import 'dart:async';

import 'package:farmerApp/Screens/Loading.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireMap extends StatefulWidget {
  static String id = 'FireMap';
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  Location location = new Location();
  List<Marker> myMarker = [];
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
        pos = value;
        _startQuery();
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
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
              child: FlatButton(
                color: Colors.amber,
                child: Icon(Icons.pin_drop),
                onPressed: () => _addMarker(
                    _currentPosition.target, "Market $i", "Snippet $i"),
              ),
              bottom: 50,
              right: 80,
            ),
            Positioned(
                child: FlatButton(
                  child: Icon(Icons.home_filled),
                  color: Colors.blueAccent,
                  onPressed: _animateToUser,
                ),
                bottom: 50,
                left: 20),
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
            )
          ],
        ),
      );
    }
  }

  _addMarker(LatLng point, String name, String snippet) {
    _addGeopoint(point, name, snippet);
    i = i + 1;
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _setCurrentPosition(CameraPosition position) {
    _currentPosition = position;
  }

  void _animateToUser() async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(pos.latitude, pos.latitude), zoom: 14)));
  }

  Future<DocumentReference> _addGeopoint(
      LatLng position, String name, String snippet) async {
    GeoFirePoint point =
        geo.point(latitude: position.latitude, longitude: position.longitude);
    return firestore
        .collection('locations')
        .add({'position': point.data, 'name': name, 'snippet': snippet});
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    myMarker = [];
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint position = document.data()['position']['geopoint'];
      String geohash = document.data()['position']['geohash'];
      debugPrint(geohash);
      String name = document.data()['name'];
      String snippet = document.data()['snippet'];
      debugPrint(name);
      Marker marker = Marker(
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId(geohash),
          infoWindow: InfoWindow(title: name, snippet: snippet));
      setState(() {
        myMarker.add(marker.clone());
      });
    });
  }

  _startQuery() async {
    double lat = pos.latitude;
    double lng = pos.longitude;
    CollectionReference ref = firestore.collection('locations');
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
    subscription = geo
        .collection(collectionRef: ref)
        .within(
            radius: radius,
            field: 'position',
            strictMode: false,
            center: center)
        .listen(_updateMarkers);
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
