import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management/controller/home_screen_controller.dart';
import 'package:student_management/core/colors.dart';

class BottomScreen extends StatelessWidget {
 const BottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
  //  HomeScreenController controller = Get.put(HomeScreenController());
    return GetBuilder<HomeScreenController>(

      init: HomeScreenController(),
     builder: (controller) => BottomNavigationBar(
          currentIndex: controller.index,
          backgroundColor: const Color.fromARGB(255, 225, 223, 223),
          selectedItemColor: blueAccentColor,
          showSelectedLabels: true,
          onTap: (value) {
            controller.changeIndex(value);
          },
          items: const [
            BottomNavigationBarItem(label: 'Home',
                icon: Icon(
              Icons.home,
              size: 16,
            )),
            BottomNavigationBarItem(label: 'Search',
                icon: Icon(
              Icons.search,
              size: 16,
            )),
            BottomNavigationBarItem(label: 'List',
                icon: Icon(
              Icons.list,
              size: 16,
            ))
          ]),
    );
  }
}
