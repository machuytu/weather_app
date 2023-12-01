import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/presentation/res/images_data.dart';

/// Get icon from openweathermap https://openweathermap.org/weather-conditions
///* Map [weatherIconCode] with icon [ImagesData]
///
/// {Return icon from
/// https://www.figma.com/community/file/1126777451931792118/weather-glassmorphism-icon and
/// https://www.figma.com/community/file/1194413192427153067/glassmorphism-weather-icon}
///
class WidgetWeatherIcon extends StatelessWidget {
  /// code of openweathermap
  final String weatherIconCode;

  /// height icon
  final double width;

  /// width icon
  final double height;
  const WidgetWeatherIcon(
      {super.key,
      required this.weatherIconCode,
      this.width = 150,
      this.height = 150});

  @override
  Widget build(BuildContext context) {
    return iconWeather(weatherIconCode);
  }

  Widget iconWeather(String weatherIconCode) => SizedBox(
        width: height,
        height: width,
        child: SvgPicture.asset(
          checkWeather(weatherIconCode),
          fit: BoxFit.contain,
        ),
      );

  String checkWeather(String weatherIconCode) {
    if (weatherIconCode == "01d") {
      return ImagesData.dClear;
    }
    // Night clear
    else if (weatherIconCode == "01n") {
      return ImagesData.nClear;
    }
    // Day few clouds
    else if (weatherIconCode == "02d") {
      return ImagesData.dFewClouds;
    }
    // Night few clouds
    else if (weatherIconCode == "02n") {
      return ImagesData.nFewClouds;
    }
    // Day scattered clouds
    else if (weatherIconCode == "03d") {
      return ImagesData.dScatteredClouds;
    }
    // Night scattered clouds
    else if (weatherIconCode == "03n") {
      return ImagesData.nScatteredClouds;
    }
    // Broken clouds
    else if (weatherIconCode == "04d" || weatherIconCode == "04n") {
      return ImagesData.brokenClouds;
    }
    // Shower rain
    else if (weatherIconCode == "09d" || weatherIconCode == "09n") {
      return ImagesData.showerRain;
    }
    // Day rain
    else if (weatherIconCode == "10d") {
      return ImagesData.dRain;
    }
    // Night rain
    else if (weatherIconCode == "10n") {
      return ImagesData.nRain;
    }
    // Thunderstorm
    else if (weatherIconCode == "11d" || weatherIconCode == "11n") {
      return ImagesData.thunderstorm;
    }
    // Snow
    else if (weatherIconCode == "13d" || weatherIconCode == "13n") {
      return ImagesData.snow;
    }
    // Mist
    else if (weatherIconCode == "50d" || weatherIconCode == "50n") {
      return ImagesData.mist;
    }
    return "";
  }
}
