import 'package:flutter/material.dart';
import 'package:weather_app/presentation/screen/init_page/index.dart';

class InitPagePage extends StatefulWidget {
  const InitPagePage({super.key});

  @override
  State<InitPagePage> createState() => _InitPagePageState();
}

class _InitPagePageState extends State<InitPagePage> {
  final _initPageBloc = InitPageBloc(const UnInitPageState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InitPageScreen(initPageBloc: _initPageBloc),
    );
  }
}
