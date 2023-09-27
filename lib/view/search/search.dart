import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/controller/search_controller.dart';
import 'package:student_management/core/colors.dart';
import 'package:student_management/view/list_of_student_screen/student_details.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Provider.of<SearchControllerGet>(context,listen: false);
    // final filteredStudents = searchController.searchStudent();
    searchController.getAllStudents();
    // Use ChangeNotifierProvider to provide SearchController
    return Scaffold(body: SafeArea(child: Consumer<SearchControllerGet>(
      builder: (context, searchController, child) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  searchController.searchStudent(value);
                },
                controller: searchController.searchcontroller1,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  label: Text(
                    'search',
                    style: TextStyle(color: blackColor),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final data1 = searchController.searchedstudent[index];
                  // print(searchController.searchedstudent.length);
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            StudentDetails(student: data1, index: index),
                      ));
                    },
                    leading: CircleAvatar(
                      radius: 49,
                      backgroundImage: FileImage(File(data1.image)),
                    ),
                    title: Text(data1.name),
                  );
                },
                itemCount: searchController.searchedstudent.length,
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ],
        );
      },
    )));
  }
}
