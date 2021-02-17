import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FireMap(),
    );
  }
}

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  Location location = new Location();
  List<Marker> myMarker = [];
  GoogleMapController mapController;
  CameraPosition _currentposition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(24.142, -110.321), zoom: 15),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          mapType: MapType.hybrid,
          compassEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          buildingsEnabled: true,
          onCameraMove: (CameraPosition position) {
            _setcurrentposition(position);
          },
          markers: Set.from(myMarker),
        ),
        Positioned(
          child: FlatButton(
            color: Colors.amber,
            child: Icon(Icons.pin_drop),
            onPressed: () => _addMarker(_currentposition.target),
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
            left: 20)
      ],
    );
  }

  _addMarker(LatLng point) {
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "Store 1", snippet: "🥕🥔🥒🍆🍅"),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    _animateToUser();
  }

  void _setcurrentposition(CameraPosition position) {
    _currentposition = position;
  }

  void _animateToUser() async {
    var pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(pos.latitude, pos.latitude), zoom: 16)));
  }
}
