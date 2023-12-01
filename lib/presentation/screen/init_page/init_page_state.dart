import 'package:equatable/equatable.dart';
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
  // Current weather
  final Weather? data;
  // List of weather 5 days/3 hrs
  final List<Weather>? list;
  const InInitPageState({this.data, this.list});

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
