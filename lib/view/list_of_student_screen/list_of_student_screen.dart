import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management/controller/addstudent_controller.dart';
import 'package:student_management/core/colors.dart';
import 'package:student_management/core/const.dart';
import 'package:student_management/services/services.dart';
import 'package:student_management/model/model.dart';
import 'package:student_management/view/edit_page/edit_page.dart';
import 'package:student_management/view/list_of_student_screen/student_details.dart';
import 'package:student_management/view/screen_home/add_student_Screen/add_Student_screen.dart';

class ListOfSudentScreen extends StatelessWidget {
  const ListOfSudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddStudentController()).getAllStudentsFromDb();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blueAccentColor,
          title: const Text(
            'Student Lists',
            style: TextStyle(fontWeight: FontWeight.bold,
            color: whiteColor),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: GetBuilder<AddStudentController>(
          init: AddStudentController(),
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.students.length,
              itemBuilder: (context, index) {
                final student = controller.students[index];
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      student.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(student.image)),
                    radius: 49,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _showDialog(context, index, student.key);
                    },
                    child: Icon(
                      Icons.delete_forever,
                      color: redColor,
                      size: 30,
                    ),
                  ),
                  onTap: () {
                    Get.to(StudentDetails(
                      student: student,
                      imagepath: student.image,
                      index: index,
                    ));
                  },
                );
              },
            );
          },
        )));
  }

  Future<void> _showDialog(BuildContext context, int index, int id) async {
    Get.dialog(AlertDialog(
      title: const Text('Are you sure you want to delete this student?'),
      actions: [
        TextButton(
          onPressed: () async {
            addController.deleteStudent(id);
            Get.back();
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
      ],
    ));
  }
}
