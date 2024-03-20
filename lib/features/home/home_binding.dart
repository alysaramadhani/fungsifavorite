import 'package:favoritefungsi/features/home/home_controller2.dart';
import 'package:get/get.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController2>(
      () => HomeController2(),
    );
  }
}