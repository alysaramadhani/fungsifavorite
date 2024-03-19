import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../core/models/favorite_restaurants_model.dart';
import '../../core/models/restaurants_model.dart';
import '../../core/services/restaurants_servis.dart';

class HomeController2 extends GetxController {
  RestaurantService _restaurantService = RestaurantService(http.Client());
  final RxList<RestaurantsModel> restaurants = <RestaurantsModel>[].obs;

  RxList<FavoriteRestaurant> favoriteRestaurants = <FavoriteRestaurant>[].obs;
  final RxBool isLoadingSearch = false.obs;

  var isLoading = true.obs;

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

  void _saveFavoriteRestaurants(
      String id, name, description, pictureid, city, ratring) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS favorites (id TEXT PRIMARY KEY, name TEXT, description TEXT, pictureId TEXT, city TEXT, rating REAL)');
    });

    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO favorites(id, name, description, pictureId, city, rating) VALUES(?, ?, ?, ?, ?, ?)',
          [id, name, description, pictureid, city, ratring]);
    });

    List<Map> result =
        await database.rawQuery('SELECT * FROM favorites WHERE id = ?', [id]);
    if (result.length > 0) {
      print('Data berhasil disimpan');
    } else {
      print('Data gagal disimpan');
    }

    await database.close();
  }

  void _loadFavoriteRestaurants() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS favorites (id TEXT PRIMARY KEY, name TEXT, description TEXT, pictureId TEXT, city TEXT, rating REAL)');
    });

    List<Map> result = await database.rawQuery('SELECT * FROM favorites');
    if (result.length > 0) {
      favoriteRestaurants.value = result
          .map((item) => FavoriteRestaurant(
                id: item['id'],
                name: item['name'],
                description: item['description'],
                pictureId: item['pictureId'],
                city: item['city'],
                rating: item['rating'],
              ))
          .toList();
    }

    await database.close();
  }

  bool _isRestaurantSaved(RestaurantsModel restaurant) {
    return favoriteRestaurants
        .any((favRestaurant) => favRestaurant.id == restaurant.id);
  }

  void toggleFavorite(RestaurantsModel restaurant) {
    final isSaved = _isRestaurantSaved(restaurant);

    if (isSaved) {
      favoriteRestaurants.refresh();

      removeFromFavorites(restaurant);
    } else {
      favoriteRestaurants.refresh();
      _addToFavorites(restaurant);
      //_saveFavoriteRestaurants();
    }

    favoriteRestaurants.refresh();
    // print('idnya adalah ${restaurant.id}');
    //_saveFavoriteRestaurants();
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
    print('idnyafav adalah ${restaurant.id}');

    _saveFavoriteRestaurants(
        restaurant.id,
        restaurant.name,
        restaurant.description,
        restaurant.pictureId,
        restaurant.city,
        restaurant.rating.toString());

    //_saveFavoriteRestaurants();
  }

  void removeFromFavorites(RestaurantsModel restaurant) async {
    favoriteRestaurants
        .removeWhere((favRestaurant) => favRestaurant.id == restaurant.id);

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS favorites (id TEXT PRIMARY KEY, name TEXT, description TEXT, pictureId TEXT, city TEXT, rating REAL)');
    });

    await database
        .delete('favorites', where: 'id = ?', whereArgs: [restaurant.id]);

    favoriteRestaurants
        .removeWhere((favRestaurant) => favRestaurant.id == restaurant.id);

    await database.close();
  }
}
