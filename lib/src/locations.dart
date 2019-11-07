import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:geolocator/geolocator.dart';

//part 'locations.g.dart';

Future getNYCPublicBathroom() async {
  const nycPublicBathroom =
      'https://data.cityofnewyork.us/resource/hjae-yuav.json';

  final response = await http.get(nycPublicBathroom);
  if (response.statusCode == 200) {
    final test = json.decode(response.body);
    for (final bathroom in test) {
      String location = bathroom['location'];
    }

    return test;
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(nycPublicBathroom));
  }
}

Future getNearestBathroom(String count) async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final lat = position.latitude.toString();
  final lng = position.longitude.toString();
  print('lat $lat lng $lng');
  String nearestBathroom =
      'https://www.refugerestrooms.org/api/v1/restrooms/by_location?page=1&per_page=$count&offset=0&lat=$lat&lng=$lng';

  final response = await http.get(nearestBathroom);

  if (response.statusCode == 200) {
    final nearestBathrooms = json.decode(response.body);
    for (final bathroom in nearestBathrooms) {
      final endLat = bathroom['latitude'];
      final endLng = bathroom['longitude'];
      double distanceInMeters = await Geolocator().distanceBetween(
          double.parse(lat), double.parse(lng), endLat, endLng);
      bathroom['distance'] = distanceInMeters.round();
    }
    return nearestBathrooms;
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(nearestBathroom));
  }
}
