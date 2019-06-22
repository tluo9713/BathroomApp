import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMapWidget> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Nearest Bathroom Locations'),
            backgroundColor: Colors.purple[700],
          ),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(0, 0),
              zoom: 2,
              // target: const LatLng(40.7051, -74.0092),
              // zoom: 15,
              //full stack location
            ),
            markers: _markers.values.toSet(),
          ),
        ),
      );
}
