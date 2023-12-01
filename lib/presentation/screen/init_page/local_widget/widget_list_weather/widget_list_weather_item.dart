import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import '../../../../res/text_data.dart';
import '../widget_weather_icon.dart';

class WidgetListWeatherItem extends StatelessWidget {
  final Weather weather;
  final bool isCelsius;
  const WidgetListWeatherItem({
    super.key,
    required this.weather,
    required this.isCelsius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    DateFormat('EE').format(weather.date!),
                    style: TextData.mainListWeather,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        DateFormat('dd/MM').format(weather.date!),
                        style: TextData.bodyText,
                      ),
                      Text(
                        DateFormat('HH:mm').format(weather.date!),
                        style: TextData.bodyText,
                      ),
                    ],
                  ),
                  WidgetWeatherIcon(
                    weatherIconCode: weather.weatherIcon ?? "",
                    height: 60,
                    width: 60,
                  ),
                ],
              ),
            ),
            Text(
              "${isCelsius ? "${weather.temperature!.celsius!.toInt()}\u2103" : "${weather.temperature!.fahrenheit!.toInt()}\u2109"} ",
              style: TextData.mainListWeather,
            ),
          ],
        ),
      ),
    );
  }
}
