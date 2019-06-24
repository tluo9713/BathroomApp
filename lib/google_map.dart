import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
//import 'src/nyc_public_parks.dart' as nocations;
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'sign_in.dart';
import 'sign_up.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMapWidget> {
  final Map<String, Marker> _markers = {};
  GoogleMapController myController;
  final bathroomCountController = TextEditingController();
  Future<void> _fetchNearestBathroom(GoogleMapController controller) async {
    final nearestBathrooms =
        await locations.getNearestBathroom(bathroomCountController.text);
    print('hey ${bathroomCountController.text}');
    setState(() {
      _markers.clear();
      for (final bathroom in nearestBathrooms) {
        final marker = Marker(
          markerId: MarkerId(bathroom['id'].toString()),
          position: LatLng(bathroom['latitude'], bathroom['longitude']),
          infoWindow: InfoWindow(
              title: bathroom['name'],
              snippet: bathroom['street'] +
                  '\n' +
                  'Current distance away: ' +
                  bathroom['distance'].toString() +
                  'meters'),
        );
        _markers[bathroom['name']] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Bathrooms'),
              backgroundColor: Colors.purple[700],
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(''),
                    accountEmail: Text(''),
                    currentAccountPicture: GestureDetector(
                      onTap: () => print('This is the current user'),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn.shopify.com/s/files/1/1061/1924/products/Poop_Emoji_7b204f05-eec6-4496-91b1-351acc03d2c7_large.png?v=1480481059'),
                      ),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://cdn2.iconfinder.com/data/icons/hawcons-travel-essentials/32/18_Toilet-512.png'))),
                  ),
                  ListTile(
                    title: Text('Welcome Guest'),
                  ),
                  ListTile(
                    title: Text('Sign In'),
                    trailing: Icon(Icons.person),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage())),
                  ),
                  ListTile(
                    title: Text('Sign Up'),
                    trailing: Icon(Icons.person),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage())),
                  ),
                  ListTile(
                    title: Text('Refresh'),
                    trailing: Icon(Icons.person),
                    onTap: () => {_fetchNearestBathroom},
                  ),
                  ListTile(
                    title: Text('Back To Opening Page'),
                    trailing: Icon(Icons.arrow_back),
                    onTap: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  height: 700,
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      myController = controller;
                      _fetchNearestBathroom(myController);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(40.7051, -74.0092),
                      zoom: 15,
                      // target: const LatLng(40.7051, -74.0092),
                      // zoom: 15,
                      //full stack location
                    ),
                    markers: _markers.values.toSet(),
                  ),
                ),
                FlatButton(
                  child: Text('Update Nearest Bathroom'),
                  onPressed: () => _fetchNearestBathroom(myController),
                ),
                TextField(
                    controller: bathroomCountController,
                    decoration: InputDecoration(
                      hintText: 'Number of Bathrooms',
                      border: InputBorder.none,
                    ))
              ],
            )),
        theme: ThemeData(canvasColor: Colors.blueAccent),
      );
}
