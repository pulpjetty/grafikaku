import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/canvas_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(name: Routes.home, page: () => const HomeView()),
    GetPage(name: Routes.canvas, page: () => CanvasView()),
  ];
}
