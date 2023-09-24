import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management/controller/home_screen_controller.dart';
import 'package:student_management/view/list_of_student_screen/list_of_student_screen.dart';
import 'package:student_management/view/screen_home/add_student_Screen/add_Student_screen.dart';
import 'package:student_management/view/screen_home/widgets/bottotm_screen.dart';
import 'package:student_management/view/search/search.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({
    super.key,
  });

  final pages = [
     AddStudentScreen(),
     SearchScreen(),
    ListOfSudentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // HomeScreenController controller=Get.put(HomeScreenController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<HomeScreenController>(
          init: HomeScreenController(),
          builder: (controller) => pages[controller.index]),
      bottomNavigationBar: const BottomScreen(),
    );
  }
}
