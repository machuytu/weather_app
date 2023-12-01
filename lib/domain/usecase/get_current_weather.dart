import 'package:weather/weather.dart';

import '../../presentation/res/constant.dart';

class GetCurrentWeather {
  /// Use package Weather
  /// Fetch current weather based on geographical coordinates
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/current
  Future<Weather> call(double lat, double lng) async {
    ///* Package of openweathermap
    /// Init weather package
    WeatherFactory wf = WeatherFactory(Constants.keyWeather);
    return await wf.currentWeatherByLocation(lat, lng);
  }
}
