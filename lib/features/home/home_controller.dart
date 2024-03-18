import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../core/models/favorite_restaurants_model.dart';
import '../../core/models/restaurants_model.dart';
import '../../core/services/restaurants_servis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RestaurantService _restaurantService = RestaurantService(http.Client());
  final RxList<RestaurantsModel> restaurants = <RestaurantsModel>[].obs;

  RxList<FavoriteRestaurant> favoriteRestaurants = <FavoriteRestaurant>[].obs;
  final RxBool isLoadingSearch = false.obs;

  var isLoading = true.obs;
  static const String favoriteRestaurantsKey = 'favoriteRestaurants';

  set restaurantService(RestaurantService service) {
    _restaurantService = service;
  }

  @override
  void onInit() {
    super.onInit();
    _loadFavoriteRestaurants();
    fetchDataRestaurants();
  }

  Future<void> fetchDataRestaurants() async {
    isLoading(true);

    try {
      final List<RestaurantsModel> result =
          await _restaurantService.getRestaurantsService();
      restaurants.value = result;
      isLoading(false);
    } catch (e) {
      restaurants.clear();
      isLoading(false);
    }
  }

  void _saveFavoriteRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList =
        favoriteRestaurants.map((fav) => json.encode(fav.toJson())).toList();

    prefs.setStringList(favoriteRestaurantsKey, jsonStringList);
  }

  void _loadFavoriteRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFavorites = prefs.getStringList(favoriteRestaurantsKey);

    if (savedFavorites != null) {
      favoriteRestaurants.value = savedFavorites
          .map((jsonString) =>
              FavoriteRestaurant.fromJson(json.decode(jsonString)))
          .toList();
    }
  }

  bool _isRestaurantSaved(RestaurantsModel restaurant) {
    return favoriteRestaurants
        .any((favRestaurant) => favRestaurant.id == restaurant.id);
  }

  void toggleFavorite(RestaurantsModel restaurant) {
    final isSaved = _isRestaurantSaved(restaurant);

    if (isSaved) {
      removeFromFavorites(restaurant);
    } else {
      _addToFavorites(restaurant);
    }

    favoriteRestaurants.refresh();
    _saveFavoriteRestaurants();
  }

  void _addToFavorites(RestaurantsModel restaurant) {
    final favorite = FavoriteRestaurant(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
    );

    favoriteRestaurants.add(favorite);
  }

  void removeFromFavorites(RestaurantsModel restaurant) {
    favoriteRestaurants
        .removeWhere((favRestaurant) => favRestaurant.id == restaurant.id);
  }
}
