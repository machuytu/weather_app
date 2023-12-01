import 'package:weather/weather.dart';

import '../../presentation/res/constant.dart';

class GetListFiveDaysWeather {
  /// Use package Weather
  /// Fetch current weather based on geographical coordinates
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/forecast5
  Future<List<Weather>> call(double lat, double lng) async {
    ///* Package of openweathermap
    /// Init weather package
    WeatherFactory wf = WeatherFactory(Constants.keyWeather);
    return await wf.fiveDayForecastByLocation(lat, lng);
  }
}
