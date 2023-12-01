import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather_app/presentation/res/images_data.dart';
import 'package:weather_app/presentation/screen/init_page/index.dart';
import 'package:weather_app/presentation/widget/loading_widget.dart';
import 'package:weather_app/presentation/screen/init_page/local_widget/widget_search_bar.dart';

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

  bool isCelsius = true;
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
          if (currentState is UnInitPageState) {
            return const LoadingWidget();
          }
          if (currentState is ErrorInitPageState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
              ],
            ));
          }
          if (currentState is InInitPageState) {
            return _buildWeatherData(size, currentState);
          }
          return const LoadingWidget();
        });
  }

  Widget _buildWeatherData(Size size, InInitPageState currentState) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            ImagesData.background,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
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
      ],
    );
  }

  Widget _body(InInitPageState currentState) {
    // empty data
    if (currentState.data == null) {
      return Container();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          // Change measure temperature between Celsius and Fahrenheit
          WidgetMeasureTemperature(
            isCelsius: isCelsius,
            onChanged: (value) {
              setState(() {
                isCelsius = !isCelsius;
              });
            },
          ),
          const SizedBox(height: 10),

          // Current weather
          WidgetCurrentWeather(
              isCelsius: isCelsius, weather: currentState.data),
          const SizedBox(height: 20),

          // Current weather
          WidgetListWeather(
              isCelsius: isCelsius, listWeather: currentState.list),
        ],
      ),
    );
  }

  void _load() {
    widget._initPageBloc.add(InitInitPageEvent());
  }
}
