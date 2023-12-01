import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'presentation/list_routes.dart';
import 'presentation/res/route_name.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Show splash app
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
          fontFamily: "SF-Pro",
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

/// Get global state
class StateManager {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
