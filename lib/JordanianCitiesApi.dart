import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<City>> getCityInfo() async {
  final getInfoFromJsonFile =
      await rootBundle.loadString('files/jordaniancites.json');
  return cityFromJson(getInfoFromJsonFile);
}

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    required this.id,
    required this.name,
    required this.state,
    required this.country,
    required this.coord,
  });

  int id;
  String name;
  String state;
  Country? country;
  Coord coord;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        state: json["state"],
        country: countryValues.map[json["country"]],
        coord: Coord.fromJson(json["coord"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state,
        "country": countryValues.reverse[country],
        "coord": coord.toJson(),
      };
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

enum Country { JO }

final countryValues = EnumValues({"JO": Country.JO});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = new Map<T, String> ();

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
