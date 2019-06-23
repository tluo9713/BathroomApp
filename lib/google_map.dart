import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
//import 'src/nyc_public_parks.dart' as nocations;
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMapWidget> {
  final Map<String, Marker> _markers = {};
  Position _position = Position();
  // double longitude;
  // double latitude;

  // Future<void> _fetchCurrentLocation() async {
  //   Position position = await Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  // }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    //final googleOffices = await locations.getGoogleOffices();
    final publicBathrooms = await locations.getNYCPublicBathroom();
    // Position position = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //print(position);
    //print(googleOffices);
    //print(publicBathrooms);
    //print('hoho');
    //print(publicBathrooms);

    setState(() {
      // _markers.clear();
      // for (final office in googleOffices.offices) {
      //   print(office);
      //   final marker = Marker(
      //     markerId: MarkerId(office.name),
      //     position: LatLng(office.lat, office.lng),
      //     infoWindow: InfoWindow(
      //       title: office.name,
      //       snippet: office.address,
      //     ),
      //   );
      //   _markers[office.name] = marker;
      // }

      //_position = position;
      //figure out how to center based on location later
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('_donkey'),
            backgroundColor: Colors.purple[700],
          ),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  _position.latitude != null ? _position.latitude : 40.7051,
                  _position.longitude != null ? _position.longitude : -74.0092),
              zoom: 15,
              // target: const LatLng(40.7051, -74.0092),
              // zoom: 15,
              //full stack location
            ),
            markers: _markers.values.toSet(),
          ),
        ),
      );
}
