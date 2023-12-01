import 'package:weather_app/presentation/res/constant.dart';

class API {
  // Domain
  static const String domain = 'https://api.openweathermap.org';

  // Endpoint
  // Not working because use free plan
  static dailyWeather(String lat, String lon, String cnt) =>
      '/data/2.5/forecast/daily?lat=$lat&lon=$lon&cnt=$cnt&appid=${Constants.keyWeather}&lang=en';
}
