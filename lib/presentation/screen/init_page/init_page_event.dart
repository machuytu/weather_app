import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk_platform_interface/src/types/autocomplete_predictions.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/presentation/screen/init_page/index.dart';

@immutable
abstract class InitPageEvent {
  Stream<InitPageState> applyAsync(
      {InitPageState currentState, InitPageBloc bloc});
}

class UnInitPageEvent extends InitPageEvent {
  @override
  Stream<InitPageState> applyAsync(
      {InitPageState? currentState, InitPageBloc? bloc}) async* {
    yield const UnInitPageState();
  }
}

class InitInitPageEvent extends InitPageEvent {
  @override
  Stream<InitPageState> applyAsync(
      {InitPageState? currentState, InitPageBloc? bloc}) async* {
    yield const InInitPageState();
  }
}

class LoadInitPageEvent extends InitPageEvent {
  final Weather data;
  LoadInitPageEvent(this.data);
  @override
  Stream<InitPageState> applyAsync(
      {InitPageState? currentState, InitPageBloc? bloc}) async* {
    try {
      yield const UnInitPageState();
      yield InInitPageState(data: data);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadInitPageEvent', error: _, stackTrace: stackTrace);
      yield ErrorInitPageState(_.toString());
    }
  }
}
