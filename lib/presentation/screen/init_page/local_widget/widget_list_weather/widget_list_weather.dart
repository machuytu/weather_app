import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import '../../../../res/text_data.dart';
import '../../../../widget/opacity_container.dart';
import 'widget_list_weather_item.dart';

class WidgetListWeather extends StatelessWidget {
  const WidgetListWeather({
    super.key,
    required this.isCelsius,
    this.listWeather,
  });

  /// Check Celsius or Fahrenheit
  final bool isCelsius;

  /// Weather data
  final List<Weather>? listWeather;

  @override
  Widget build(BuildContext context) {
    return OpacityContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("3 hour forecast in 5 days", style: TextData.bodyText3),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = listWeather![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: WidgetListWeatherItem(
                      weather: item, isCelsius: isCelsius),
                );
              },
              itemCount: listWeather!.length,
            ),
          ),
        ],
      ),
    );
  }
}
