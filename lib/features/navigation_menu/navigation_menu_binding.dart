import 'package:get/get.dart';

import '../home/home_controller.dart';
import 'navigation_menu_controller.dart';

class NavigationMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationMenuController>(
      () => NavigationMenuController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}