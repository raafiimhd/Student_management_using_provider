import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management/controller/search_controller.dart';
import 'package:student_management/core/colors.dart';
import 'package:student_management/view/list_of_student_screen/student_details.dart';
import 'package:student_management/view/screen_home/add_student_Screen/add_Student_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchControllerGet searchcontroller = Get.put(SearchControllerGet());
    searchcontroller.getAllStudents();
    return Scaffold(body: SafeArea(
      child: GetBuilder<SearchControllerGet>(
        builder: (controller) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    searchcontroller.searchStudent();
                  },
                  //    ...,other fields
                  controller: searchcontroller.searchcontroller1,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      label: const Text(
                        'search',
                        style: TextStyle(color: blackColor),
                      ),
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.separated(
                itemBuilder: (context, index) {
                  print(searchcontroller.searchedstudent.length);
                  final data1 = searchcontroller.searchedstudent[index];
                  return ListTile(
                    onTap: () {
                      Get.to(StudentDetails(student: data1, index: index));
                    },
                    leading: CircleAvatar(
                      radius: 49,
                      backgroundImage: FileImage(File(data1.image)),
                    ),
                    title: Text(data1.name),
                  );
                },
                itemCount: searchcontroller.searchedstudent.length,
                separatorBuilder: (context, index) => Divider(),
              ))
            ],
          );
        },
      ),
    ));
  }
}
