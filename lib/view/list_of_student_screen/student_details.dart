import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management/core/colors.dart';
import 'package:student_management/model/model.dart';
import 'package:student_management/view/edit_page/edit_page.dart';

class StudentDetails extends StatelessWidget {
  StudentDetails(
      {super.key, required this.student, required this.index, this.imagepath});

  StudentModel student;
  int index;
  String? imagepath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
        title: const Text(
          'Student Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        backgroundColor: blueAccentColor,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              // print(student);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (EditPage(
                        student: student,
                        index: index,
                      ))));
            },
            child: const Icon(
              Icons.edit,
              color: whiteColor,
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: FileImage(File(student.image)),
                radius: 49,
              ),
              Text(
                "Name:${student.name}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Age:${student.age}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Domain:${student.domain}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Conatct:${student.number}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
