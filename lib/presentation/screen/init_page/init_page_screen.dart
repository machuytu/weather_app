import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:weather_app/domain/usecase/get_current_weather.dart';
import 'package:weather_app/domain/usecase/get_list_five_days_weather.dart';
import 'package:weather_app/presentation/screen/init_page/index.dart';
import 'package:weather_app/data/local/shared_preferences.dart';
import 'package:weather_app/presentation/widget/another_flushbar.dart';
import 'package:weather_app/presentation/widget/loading_widget.dart';
import 'package:weather_app/presentation/screen/init_page/local_widget/widget_search_bar.dart';
import '../../../data/model/location_model.dart';
import '../../widget/widget_background.dart';
import 'local_widget/widget_current_weather.dart';
import 'local_widget/widget_list_weather/widget_list_weather.dart';
import 'local_widget/widget_measure_temperature.dart';

class InitPageScreen extends StatefulWidget {
  const InitPageScreen({
    required InitPageBloc initPageBloc,
    Key? key,
  })  : _initPageBloc = initPageBloc,
        super(key: key);

  final InitPageBloc _initPageBloc;

  @override
  InitPageScreenState createState() {
    return InitPageScreenState();
  }
}

class InitPageScreenState extends State<InitPageScreen> {
  InitPageScreenState();

  /// Local data
  SharedPref sharedPref = SharedPref();

  /// Check Celsius/Fahrenheit
  bool isCelsius = true;

  FlushBar flushBar = FlushBar();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    widget._initPageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<InitPageBloc, InitPageState>(
        bloc: widget._initPageBloc,
        builder: (
          BuildContext context,
          InitPageState currentState,
        ) {
          // Not have data
          if (currentState is UnInitPageState) {
            return const LoadingWidget();
          }
          // Error data
          if (currentState is ErrorInitPageState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
              ],
            ));
          }
          // Loaded data
          if (currentState is InInitPageState) {
            return _buildWeatherData(size, currentState);
          }
          return const LoadingWidget();
        });
  }

  Widget _buildWeatherData(Size size, InInitPageState currentState) {
    return WidgetBackground(
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 80.0, left: 8.0, right: 8.0),
                // UI current weather and list weather in 5 days
                child: _body(currentState),
              ),
              // Search bar location
              WidgetSearchBar(widget._initPageBloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(InInitPageState currentState) {
    // Empty data
    if (currentState.data == null) {
      return Container();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          // Change measure temperature between Celsius and Fahrenheit
          WidgetMeasureTemperature(
            onChanged: (value) {
              setState(() {
                isCelsius = !isCelsius;
                // Store Celsius/Fahrenheit
                sharedPref.save("isCelsius", isCelsius);
              });
            },
            isCelsius: isCelsius,
          ),
          const SizedBox(height: 10),

          // Current weather
          WidgetCurrentWeather(
              isCelsius: isCelsius, weather: currentState.data),
          const SizedBox(height: 20),

          // List weather 5 days/3 hrs
          WidgetListWeather(
              isCelsius: isCelsius, listWeather: currentState.list),
        ],
      ),
    );
  }

  /// Load init data and remove splash screen
  Future<void> _load() async {
    try {
      widget._initPageBloc.add(InitInitPageEvent());
      // Load Celsius/Fahrenheit
      isCelsius = await sharedPref.read("isCelsius") ?? true;
      await loadWeather();

      // Complete init load
      FlutterNativeSplash.remove();
    } catch (e) {
      flushBar.showFlushBar(
          title: "Not have weather on this location, try again");
    }
  }

  /// Load last location chose by the user
  Future<void> loadWeather() async {
    final data = await sharedPref.read("fetchPlaceResponse");
    if (data != null) {
      LocationModel? locationModel = LocationModel.fromJson(json.decode(data));

      // Get current weather
      GetCurrentWeather getCurrentWeather = GetCurrentWeather();
      final weather =
          await getCurrentWeather.call(locationModel.lat!, locationModel.lng!);

      // Get list of weather in 5 days
      GetListFiveDaysWeather getListFiveDaysWeather = GetListFiveDaysWeather();
      final listWeather = await getListFiveDaysWeather.call(
          locationModel.lat!, locationModel.lng!);
      widget._initPageBloc.add(LoadInitPageEvent(weather, listWeather));
    }
  }
}
