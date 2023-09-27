import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/controller/addstudent_controller.dart';
import 'package:student_management/core/colors.dart';
import 'package:student_management/view/list_of_student_screen/student_details.dart';

class ListOfStudentScreen extends StatelessWidget {
  const ListOfStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentListController = Provider.of<AddStudentController>(context);
    studentListController
        .getAllStudentsFromDb(context); // Fetch students on screen load

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueAccentColor,
        title: const Text(
          'Student Lists',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<AddStudentController>(
          builder: (context, controller, child) {
            final students = controller.students;
            // print(students.length);
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      student.name,
                      style: const TextStyle(
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
                      _showDialog(context, student.key);
                    },
                    child: const Icon(
                      Icons.delete_forever,
                      color: redColor,
                      size: 30,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (StudentDetails(
                              student: student,
                              imagepath: student.image,
                              index: index,
                            ))));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context, int id) async {
    final addController =
        Provider.of<AddStudentController>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            onPressed: () {
              addController.deleteStudent(id, context);
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
