// ignore_for_file: library_private_types_in_public_api

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/views/pages/weather_page.dart';

class SelectCountryPage extends StatefulWidget {
  const SelectCountryPage({super.key});

  @override
  _SelectCountryPageState createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<SelectCountryPage> {
  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select your location"),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CSCPicker(
                  countryDropdownLabel: "*Necessarily City",
                  stateDropdownLabel: "*Necessarily State",
                  showCities: false,
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
                (stateValue == "State" || stateValue == null)
                    ? ElevatedButton(
                        onPressed: () {},
                        child: const Text("State not selected"),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          GetStorage box = GetStorage();
                          box.write("countryMain", stateValue);
                          Get.to(() => const WeatherListPage());
                        },
                        child: const Text("OK")),
              ],
            )),
      ),
    );
  }
}
