import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/controller/home_screen_controller.dart';
import 'package:student_management/view/list_of_student_screen/list_of_student_screen.dart';
import 'package:student_management/view/screen_home/add_student_Screen/add_Student_screen.dart';
import 'package:student_management/view/search/search.dart';

class ScreenHome extends StatelessWidget {
   ScreenHome({Key? key}) : super(key: key);

  final List<Widget> pages = [
    AddStudentScreen(),
    const SearchScreen(),
    const ListOfStudentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      body: pages[homeScreenProvider.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeScreenProvider.index,
        onTap: (index) {
          homeScreenProvider.index = index;
        },
        items:const [
          BottomNavigationBarItem(
            label: 'Add Student',
            icon: Icon(Icons.add),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'List',
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}
