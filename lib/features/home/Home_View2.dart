import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/api_constants.dart';
import 'home_controller2.dart';

class HomeView2 extends GetView<HomeController2> {
  const HomeView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 196, 72, 76),
        title: const Text(
          'ALYSA RESTAURANT',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.restaurants.length,
                itemBuilder: (_, index) {
                  final restaurants = controller.restaurants[index];
                  return ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8.0),
                    leading: Image.network(
                      Constants.imageUrl + restaurants.pictureId,
                      width: 100,
                      height: 100,
                      errorBuilder: (ctx, error, _) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                    title: Text(restaurants.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_city,
                              size: 20,
                              color: Color.fromARGB(255, 222, 83, 93),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              restaurants.city,
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
                              width: 4,
                            ),
                            Text(
                              restaurants.rating.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Obx(
                      () => IconButton(
                        onPressed: () {
                          controller.toggleFavorite(restaurants);
                        },
                        icon: Icon(
                          controller.favoriteRestaurants.any((favRestaurant) =>
                                  favRestaurant.id == restaurants.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.favoriteRestaurants.any(
                                  (favRestaurant) =>
                                      favRestaurant.id == restaurants.id)
                              ? Colors.red
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
