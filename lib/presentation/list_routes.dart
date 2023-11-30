import 'package:get/get.dart';
import 'package:weather_app/presentation/screen/init_page/init_page_page.dart';

import 'res/route_name.dart';

class ListRoutes {
  List<GetPage<dynamic>> listRoutes = [
    GetPage(name: RouteData.init, page: () => const InitPagePage()),
  ];
}
