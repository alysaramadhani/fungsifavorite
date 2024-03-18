import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation_menu_controller.dart';

class NavigationMenu extends GetView<NavigationMenuController> {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: Colors.white,
          indicatorColor: Colors.black.withOpacity(0.1),
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: controller.selectedIndex.value == 0
                    ? Color.fromARGB(255, 214, 75, 94)
                    : Colors.grey,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.favorite_border,
                color: controller.selectedIndex.value == 1
                    ? Color.fromARGB(255, 214, 75, 94)
                    : Colors.grey,
              ),
              label: 'Favorite',
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.screen[controller.selectedIndex.value],
      ),
    );
  }
}