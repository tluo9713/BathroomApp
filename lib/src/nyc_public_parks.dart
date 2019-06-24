import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

// @JsonSerializable()
// class LatLng {
//   LatLng({
//     this.lat,
//     this.lng,
//   });

//   factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
//   Map<String, dynamic> toJson() => _$LatLngToJson(this);

//   final double lat;
//   final double lng;
// }

@JsonSerializable()
class Bathroom {
  Bathroom({this.name, this.location, this.open_year_round, this.borough});

  factory Bathroom.fromJson(Map<String, dynamic> json) =>
      _$BathroomFromJson(json);
  Map<String, dynamic> toJson() => _$BathroomToJson(this);

  final String name;
  final String location;
  final String open_year_round;
  //final double lat;
  //final double lng;
  final String borough;
}

Future<Bathrooms> getNYCPublicBathroom() async {
  const nycPublicBathroom =
      'https://data.cityofnewyork.us/resource/hjae-yuav.json';
  //print(nycPublicBathroom[0]);
  // Retrieve the locations of Google offices
  final response = await http.get(nycPublicBathroom);
  if (response.statusCode == 200) {
    return Bathrooms.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(nycPublicBathroom));
  }
}
