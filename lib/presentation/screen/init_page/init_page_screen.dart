import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/res/text_data.dart';
import 'package:weather_app/presentation/screen/init_page/index.dart';
import 'package:weather_app/presentation/widget/loading_widget.dart';
import 'package:weather_app/presentation/screen/init_page/local_widget/widget_search_bar.dart';

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
            return SafeArea(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 100.0, left: 8.0, right: 8.0),
                      // UI current weather
                      child: body(currentState),
                    ),
                    // Search bar location
                    WidgetSearchBar(widget._initPageBloc),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget body(InInitPageState currentState) {
    // empty data
    if (currentState.data == null) {
      return Container();
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              "https://openweathermap.org/img/wn/${currentState.data!.weatherIcon}@4x.png",
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${currentState.data!.temperature!.celsius!.toInt()} ${isCelsius ? "\u2103" : "\u2109"} ",
                    style: TextData.mainTemperature,
                  ),
                  Text(
                    currentState.data!.weatherMain!,
                    style: TextData.mainWeather,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          DateFormat('EE').format(currentState.data!.date!),
          style: TextData.headerText,
        ),
        Text(
          DateFormat('dd MMMM yy').format(currentState.data!.date!),
          style: TextData.headerText,
        )
      ],
    );
  }

  void _load() {
    widget._initPageBloc.add(InitInitPageEvent());
  }
}
