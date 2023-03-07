import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/models/check_token_model.dart';
import 'package:weather_app/models/weather_items_model.dart';

class WeatherItemsRepository {
  Future<WeatherItem> getWeatherItem() async {
    GetStorage box = GetStorage();
    var getApiCalls = box.read("getApiCalls") ?? 0;
    var countryMain = box.read("countryMain") ?? "Belarus";

    String token = Token().checkTokenCalls();

    final response = await Dio().get(
      "http://api.weatherapi.com/v1/current.json?key=$token&q=bulk",
      queryParameters: {
        'lang': 'ru',
        'q': countryMain,
      },
    );
    final weatherItem = weatherItemFromJson(response.toString());

    getApiCalls++;
    box.write("getApiCalls", getApiCalls);
    debugPrint("api calls counter =  ${getApiCalls.toString()}");

    return weatherItem;
  }
}
