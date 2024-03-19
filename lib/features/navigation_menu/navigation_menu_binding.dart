import 'package:favoritefungsi/features/home/home_controller2.dart';
import 'package:get/get.dart';

import 'navigation_menu_controller.dart';

class NavigationMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationMenuController>(
      () => NavigationMenuController(),
    );
    Get.lazyPut<HomeController2>(
      //() => HomeController(),
      () => HomeController2(),
    );
  }
}
