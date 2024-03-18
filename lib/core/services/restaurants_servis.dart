import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/constants/api_constants.dart';
import '../models/restaurants_model.dart';

class RestaurantService {
  final http.Client client;

  RestaurantService(this.client);

  Future<List<RestaurantsModel>> getRestaurantsService() async {
    final response = await client.get(Uri.parse(Constants.listRestaurant));

    if (response.statusCode == 200) {
      print('CEK');
      final jsonData = jsonDecode(response.body);
      final List<dynamic> restaurant = jsonData['restaurants'];

      return restaurant.map((e) => RestaurantsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}