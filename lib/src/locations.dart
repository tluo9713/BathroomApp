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
      //print(bathroom['location']);
      String location = bathroom['location'];

      // try {
      //   List<Placemark> placemark =
      //       await Geolocator().placemarkFromAddress(location);

      //   for (final element in placemark) {
      //     bathroom['position'] = element.position;
      //   }
      // } catch (e) {
      //   bathroom['position'] = null;
      // }

//      print('check here');
//      print(bathroom);
    }

    return test;
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(nycPublicBathroom));
  }
}
