import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/list_routes.dart';
import 'presentation/res/colors_data.dart';
import 'presentation/res/route_name.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ListRoutes listRoutes = ListRoutes();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: StateManager.navigatorKey,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.black,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: RouteData.init,
        getPages: listRoutes.listRoutes);
  }
}

class StateManager {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
