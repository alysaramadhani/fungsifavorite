import 'package:favoritefungsi/features/home/Home_View2.dart';
import 'package:get/get.dart';

import '../favorite/favorite_view.dart';


class NavigationMenuController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screen = [
    //const HomeView(),
    const HomeView2(),
    FavoriteView(),
  ];
}
