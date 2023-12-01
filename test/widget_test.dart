// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/domain/usecase/get_current_weather.dart';
import 'package:weather_app/domain/usecase/get_list_five_days_weather.dart';
import 'package:weather_app/presentation/res/constant.dart';

void main() {
  group('test-unit', () {
    late GetCurrentWeather getCurrentWeather;
    late GetListFiveDaysWeather getListFiveDaysWeather;

    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      getCurrentWeather = GetCurrentWeather();
      getListFiveDaysWeather = GetListFiveDaysWeather();

      Constants.keyGooglePlaces;
      Constants.keyWeather;
    });

    test('Get current weather in Viet Nam', () async {
      // Check current weather on lat and lng at Viet Nam
      final result = await getCurrentWeather.call(14.058324, 108.277199);

      bool checkValue = false;
      if (result.country == "VN") {
        checkValue = true;
      } else {
        checkValue = false;
      }
      expect(checkValue, true);
    });
    test('Get current weather diffent Viet Nam', () async {
      // Check current weather on lat and lng not at Viet Nam
      final result = await getCurrentWeather.call(30.058324, 108.277199);

      bool checkValue = false;
      if (result.country == "VN") {
        checkValue = true;
      } else {
        checkValue = false;
      }
      expect(checkValue, false);
    });

    test('Get list predictions in Viet Nam', () async {
      // Check have list of weather 5 days/3 hrs at Viet Nam
      final result = await getListFiveDaysWeather.call(14.058324, 108.277199);
      bool checkValue = false;
      if (result[0].country == "VN") {
        checkValue = true;
      } else {
        checkValue = false;
      }
      expect(checkValue, true);
    });

    test('Get list predictions diffent Viet Nam', () async {
      // Check have list of weather 5 days/3 hrs not at Viet Nam
      final result = await getListFiveDaysWeather.call(30.058324, 108.277199);

      bool checkValue = false;
      if (result[0].country == "VN") {
        checkValue = true;
      } else {
        checkValue = false;
      }
      expect(checkValue, false);
    });
  });
}
