import 'package:get/get.dart';

import '../favorite/favorite_view.dart';
import '../home/home_view.dart';

class NavigationMenuController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screen = [
    const HomeView(),
     FavoriteView(),
  ];
}