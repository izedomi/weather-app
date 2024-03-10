import 'dart:convert';

List<CityModel> cityModelFromJson(String str) =>
    List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  String city;
  String lat;
  String lon;
  bool isSelected;

  CityModel({
    required this.city,
    required this.lat,
    required this.lon,
    required this.isSelected,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        city: json["city"],
        lat: json["lat"],
        lon: json["lon"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "lat": lat,
        "lon": lon,
        "isSelected": isSelected,
      };
}
