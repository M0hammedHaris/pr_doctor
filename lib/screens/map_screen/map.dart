import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pr_doctor/screens/main_screen/home_screen.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreen createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  double zoomVal = 5.0;
  var color = Colors.cyan;
  Position _currentPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
           _backButton(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _backButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.arrow_back, color: color),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 5.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(11.020191, 76.921027, "Emerald Medicinal Herbs"),
            ),
            SizedBox(width: 5.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(11.002581, 76.956187, "Janani Herbal"),
            ),
            SizedBox(width: 5.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(11.044541, 76.923119, "Ramya Nursery"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(double lat, double long, String storeName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        width: 300,
        height: 100,
        child: Material(
          color: Colors.white,
          elevation: 5.0,
          borderRadius: BorderRadius.circular(24.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: myDetailsContainer1(storeName),
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String storeName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            storeName,
            style: TextStyle(
                color: color,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "Contact",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold),
            )),
            Container(
                child: Text(
              "0422 244 6014",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Working Mon - Fri 8:00 - 20:00",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 13.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(_currentPosition.latitude, _currentPosition.longitude), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {marker1, marker2, marker3, marker4},
      ),
    );
  }
  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print(position);
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker marker1 = Marker(
  markerId: MarkerId('Emerald Medicinal Herbs'),
  position: LatLng(11.020191, 76.921027),
  infoWindow: InfoWindow(title: 'Emerald Medicinal Herbs'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

Marker marker2 = Marker(
  markerId: MarkerId('Janani Herbal'),
  position: LatLng(11.002581, 76.956187),
  infoWindow: InfoWindow(title: 'Janani Herbal'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
Marker marker3 = Marker(
  markerId: MarkerId('Ramya Nursery'),
  position: LatLng(11.044541, 76.923119),
  infoWindow: InfoWindow(title: 'Ramya Nursery'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
Marker marker4 = Marker(
  markerId: MarkerId('The Universal Good Life Centre'),
  position: LatLng(10.995961, 76.957904),
  infoWindow: InfoWindow(title: 'The Universal Good Life Centre'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
