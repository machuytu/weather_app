import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import '../../../res/text_data.dart';
import '../../../widget/opacity_container.dart';
import 'widget_weather_icon.dart';

class WidgetCurrentWeather extends StatelessWidget {
  const WidgetCurrentWeather({
    super.key,
    required this.isCelsius,
    this.weather,
  });

  /// Check Celsius or Fahrenheit
  final bool isCelsius;

  /// Weather data
  final Weather? weather;

  @override
  Widget build(BuildContext context) {
    return OpacityContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Weather icon
              WidgetWeatherIcon(weatherIconCode: weather!.weatherIcon ?? ""),
              // Temperature, main weather, description weather,
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${isCelsius ? "${weather!.temperature!.celsius!.toInt()}\u2103" : "${weather!.temperature!.fahrenheit!.toInt()}\u2109"} ",
                      style: TextData.mainTemperature,
                    ),
                    Text(
                      weather!.weatherMain!.capitalize!,
                      style: TextData.mainWeather,
                    ),
                    Text(
                      weather!.weatherDescription!.capitalize!,
                      style: TextData.descriptionText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Datime current weather
          Text(
            DateFormat('EE').format(weather!.date!),
            style: TextData.headerText,
          ),
          Text(
            DateFormat('dd MMMM yy').format(weather!.date!),
            style: TextData.headerText,
          ),
        ],
      ),
    );
  }
}
