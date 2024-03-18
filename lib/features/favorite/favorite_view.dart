import 'package:favoritefungsi/features/favorite/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/models/restaurants_model.dart';
import '../../utils/constants/api_constants.dart';
import '../home/home_controller.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 212, 64, 79),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Favorite",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 199, 41, 62),
              ),
            )
          : controller.favoriteRestaurants.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.favoriteRestaurants.length,
                  itemBuilder: (context, index) {
                    final favRestaurants =
                        controller.favoriteRestaurants[index];
                    return ListTile(
                        onTap: () {},
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        leading: Image.network(
                          Constants.imageUrl + favRestaurants.pictureId,
                          width: 100,
                          height: 100,
                          errorBuilder: (ctx, error, _) => const Center(
                            child: Icon(
                              Icons.error,
                            ),
                          ),
                        ),
                        title: Text(
                          favRestaurants.name,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  favRestaurants.city,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  favRestaurants.rating.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            RestaurantsModel fav = RestaurantsModel(
                              id: favRestaurants.id,
                              name: favRestaurants.name,
                              city: favRestaurants.city,
                              description: favRestaurants.description,
                              pictureId: favRestaurants.pictureId,
                              rating: favRestaurants.rating,
                            );
                            controller.removeFromFavorites(fav);
                          },
                          icon: Icon(
                            controller.favoriteRestaurants.any(
                                    (favRestaurant) =>
                                        favRestaurant.id == favRestaurants.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.favoriteRestaurants.any(
                                    (favRestaurant) =>
                                        favRestaurant.id == favRestaurants.id)
                                ? Colors.red
                                : null,
                          ),
                        ),);
                  },
                )
              : Center(
                  child: Text(
                    "You don't have favorite restaurant",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                )),
    );
  }
}