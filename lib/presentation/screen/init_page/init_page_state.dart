import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_sdk_platform_interface/src/types/autocomplete_predictions.dart';
import 'package:weather/weather.dart';

abstract class InitPageState extends Equatable {
  const InitPageState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnInitPageState extends InitPageState {
  const UnInitPageState();

  @override
  String toString() => 'UnInitPageState';
}

/// Initialized
class InInitPageState extends InitPageState {
  final Weather? data;
  const InInitPageState({this.data});

  @override
  String toString() => 'InInitPageState $data';

  @override
  List<Object> get props => [];
}

class ErrorInitPageState extends InitPageState {
  const ErrorInitPageState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorInitPageState';

  @override
  List<Object> get props => [errorMessage];
}
