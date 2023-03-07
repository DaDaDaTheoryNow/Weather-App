// To parse this JSON data, do
//
//     final weatherItem = weatherItemFromJson(jsonString);

import 'dart:convert';

WeatherItem weatherItemFromJson(String str) =>
    WeatherItem.fromJson(json.decode(str));

class WeatherItem {
  WeatherItem({
    required this.location,
    required this.current,
  });

  Location location;
  Current current;

  factory WeatherItem.fromJson(Map<String, dynamic> json) => WeatherItem(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );
}

class Current {
  Current({
    required this.lastUpdated,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.uv,
  });

  String lastUpdated;
  double tempC;
  int isDay;
  Condition condition;
  double windKph;
  int humidity;
  double uv;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"],
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windKph: json["wind_kph"]?.toDouble(),
        humidity: json["humidity"],
        uv: json["uv"],
      );
}

class Condition {
  Condition({
    required this.text,
    required this.icon,
  });

  String text;
  String icon;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
      );
}

class Location {
  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  int localtimeEpoch;
  String localtime;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        tzId: json["tz_id"],
        localtimeEpoch: json["localtime_epoch"],
        localtime: json["localtime"],
      );
}
