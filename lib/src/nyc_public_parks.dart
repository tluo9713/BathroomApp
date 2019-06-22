import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
//import 'package:json_annotation/json_annotation.dart';

Future<Locations> getPublicParkBathroom() async {
  const nycPublicParkBathroomURL =
      'https://data.cityofnewyork.us/resource/hjae-yuav.json';

  // Retrieve the locations of Google offices
  final response = await http.get(nycPublicParkBathroomURL);
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(nycPublicParkBathroomURL));
  }
}
