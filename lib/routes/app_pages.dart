import 'package:favoritefungsi/features/favorite/favorite_binding.dart';
import 'package:favoritefungsi/features/favorite/favorite_view.dart';
import 'package:favoritefungsi/features/home/home_binding.dart';

import 'package:favoritefungsi/features/navigation_menu/navigation_menu.dart';
import 'package:favoritefungsi/features/navigation_menu/navigation_menu_binding.dart';
import 'package:get/get.dart';

import '../features/home/Home_View2.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NAVIGATION_MENU;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      //page: () => const HomeView(),
      page: () => const HomeView2(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_MENU,
      page: () => const NavigationMenu(),
      binding: NavigationMenuBinding(),
    ),
  ];
}
