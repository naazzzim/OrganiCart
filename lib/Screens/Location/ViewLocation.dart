import 'package:farmerApp/Screens/Loading.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class ViewLocation extends StatefulWidget {
  static String id = 'ViewLocation';
  @override
  _ViewLocationState createState() => _ViewLocationState();
}

class _ViewLocationState extends State<ViewLocation> {
  Location location = new Location();
  List<Marker> myMarker = [];
  GoogleMapController mapController;
  int i = 0;
  Geoflutterfire geo = Geoflutterfire();
  double radius = 10;
  bool loading = true;
  LocationData pos;

  @override
  void initState() {
    location.getLocation().then((value) {
      setState(() {
        pos = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myMarker.add(ModalRoute.of(context).settings.arguments);
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('View Location'),
        ),
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
            )
          ],
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
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
    mapController.dispose();
    super.dispose();
  }
}
