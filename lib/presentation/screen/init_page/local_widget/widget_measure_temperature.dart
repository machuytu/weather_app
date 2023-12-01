import 'package:flutter/material.dart';

import '../../../res/text_data.dart';

class WidgetMeasureTemperature extends StatelessWidget {
  /// Check Celsius or Fahrenheit
  final bool isCelsius;

  /// Callback Celsius or Fahrenheit
  final void Function(bool)? onChanged;
  const WidgetMeasureTemperature(
      {super.key, required this.isCelsius, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "measure temperature",
          style: TextData.bodyText3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "\u2109",
              style: TextData.mainListWeather,
            ),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: isCelsius,
                activeColor: Colors.grey,
                onChanged: onChanged,
              ),
            ),
            const Text(
              "\u2103",
              style: TextData.mainListWeather,
            ),
          ],
        ),
      ],
    );
  }
}
