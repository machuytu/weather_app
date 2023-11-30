import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/screen/init_page/index.dart';

class InitPageBloc extends Bloc<InitPageEvent, InitPageState> {
  InitPageBloc(InitPageState initialState) : super(initialState) {
    on<InitPageEvent>((event, emit) {
      return emit.forEach<InitPageState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error',
              name: 'InitPageBloc', error: error, stackTrace: stackTrace);
          return ErrorInitPageState(error.toString());
        },
      );
    });
  }
}
