import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:weather_app/views/pages/weather_page.dart';

class ErrorWeather extends StatefulWidget {
  const ErrorWeather({super.key});

  @override
  State<ErrorWeather> createState() => _ErrorWeatherState();
}

double paddingToken = 160;

class _ErrorWeatherState extends State<ErrorWeather> {
  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        if (visible) {
          paddingToken = 5;
        } else {
          paddingToken = 160;
        }
      });
    });
  }

  String error = "Error: To use you need internet connection";
  String warning = "*For advanced users only";
  Route route = MaterialPageRoute(
      builder: (BuildContext context) => const WeatherListPage());

  @override
  Widget build(BuildContext context) {
    TextEditingController tokenController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 220),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // retry widget
              Column(
                children: [
                  const CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 45, 8, 0),
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context, route, (route) => false);
                        },
                        child: const Text("Retry"),
                      ),
                    ),
                  ),
                  Text(error),
                ],
              ),

              // api token widget
              Padding(
                padding: EdgeInsets.only(top: paddingToken),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        height: 1.7,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextField(
                      controller: tokenController,
                      textAlign: TextAlign.center,
                      toolbarOptions: const ToolbarOptions(
                          paste: true, selectAll: true, cut: true),
                      decoration: InputDecoration(
                        hintText: "Write your token, if you have(optional)",
                        border: InputBorder.none,
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 3)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(137, 0, 0, 0), width: 2)),
                        prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: IconTheme(
                              data: const IconThemeData(color: Colors.white),
                              child: Icon(
                                Icons.key_outlined,
                                size: 25,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          GetStorage box = GetStorage();

                          String tokenInput = tokenController.text;

                          box.write("token", tokenInput);
                          Navigator.pushAndRemoveUntil(
                              context, route, (route) => false);
                        },
                        child: const Text("Ok"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            warning,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () {
                                GetStorage box = GetStorage();
                                box.write(
                                    "token", "f156f72186d543ffb34135421230403");
                                Navigator.pushAndRemoveUntil(
                                    context, route, (route) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                              ),
                              child: const Text("Reset token")),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 1.7,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
