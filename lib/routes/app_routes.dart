part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const FAVORITE = _Paths.FAVORITE;
  static const NAVIGATION_MENU = _Paths.NAVIGATION_MENU;
}

abstract class _Paths {
  static const HOME = '/home';
  static const FAVORITE = '/favorite';
  static const NAVIGATION_MENU = '/navigation_menu';
}