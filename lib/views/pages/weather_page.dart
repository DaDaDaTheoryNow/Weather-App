import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/views/pages/select_country_page.dart';
import 'package:weather_app/models/weather_items_model.dart';
import 'package:weather_app/repositories/weather_items_repository.dart';
import 'package:weather_app/views/widgets/error_weather.dart';
import 'package:weather_app/views/widgets/loading_weather.dart';

class WeatherListPage extends StatefulWidget {
  const WeatherListPage({super.key});

  @override
  State<WeatherListPage> createState() => _WeatherListPageState();
}

class _WeatherListPageState extends State<WeatherListPage> {
  Future<WeatherItem>? _future;

  @override
  void initState() {
    _future = WeatherItemsRepository().getWeatherItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1!;

    // get count of api calls
    GetStorage box = GetStorage();
    var getApiCalls = box.read("getApiCalls") ?? 0;
    getApiCalls++;

    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          // start basic screen
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            String day = (snapshot.data!.current.isDay == 1) ? "Day" : "Night";

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                  child: Image.network(
                    "https:${snapshot.data!.current.condition.icon}",
                  ),
                ),
                title: Text(
                  "${snapshot.data!.location.region} - ${snapshot.data!.location.country}",
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {
                        Get.to(() => const SelectCountryPage());
                      },
                      icon: const Icon(Icons.drive_file_rename_outline_rounded),
                      iconSize: 27,
                    ),
                  )
                ],
              ),
              body: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: mediaQuery * 0.1, bottom: mediaQuery * 0.1),
                      child: Text(
                        "Good $day",
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      width: mediaQuery,
                      height: 2,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: mediaQuery * 0.4, bottom: 4),
                          child: SizedBox(
                            width: mediaQuery,
                            child: Card(
                              child: Column(
                                children: [
                                  Text(
                                    "Temperature: ${snapshot.data!.current.tempC}",
                                    style: textStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Now is: $day",
                                    style: textStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Wind kph: ${snapshot.data!.current.windKph}",
                                    style: textStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Humidity: ${snapshot.data!.current.humidity}",
                                    style: textStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Weather: ${snapshot.data!.current.condition.text}",
                                    style: textStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Last Updated: ${snapshot.data!.current.lastUpdated}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        // api calls counter
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Api calls: $getApiCalls / 2000",
                              style: const TextStyle(
                                fontSize: 8,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _future = WeatherItemsRepository().getWeatherItem();
                  });
                },
                child: const Icon(Icons.restore),
              ),
            );
          }
          // end basic widget

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWeather();
          }

          // error
          else {
            if (snapshot.hasError || snapshot.hasData == false) {
              return const ErrorWeather();
            }

            return const Text("Weather app");
          }
        });
  }
}
