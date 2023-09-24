import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/controller/addstudent_controller.dart';
import 'package:student_management/core/colors.dart';
import 'package:student_management/core/const.dart';
import 'package:student_management/model/model.dart';
import 'package:student_management/view/list_of_student_screen/list_of_student_screen.dart';
import 'package:student_management/view/screen_home/add_student_Screen/add_Student_screen.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key, required this.student, required this.index});
  StudentModel student;
  int index;
  @override
  Widget build(BuildContext context) {
    addController.setInitileValues(student);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Screen',
            style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
          ),
          backgroundColor: blueAccentColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              kHeight40,
              GestureDetector(
                onTap: () {
                  addController.getImage(ImageSource.gallery);
                },
                child: GetBuilder<AddStudentController>(
                  init: AddStudentController(),
                  builder: (controller) {
                    return CircleAvatar(
                      radius: 49,
                      backgroundColor: Colors.grey,
                      backgroundImage: (controller.imagePicked != null)
                          ? FileImage(controller.imagePicked!)
                          : null,
                    );
                  },
                ),
              ),
              kHeight10,
              Visibility(
                  visible: addController.isVisible,
                  child: Text(
                    'please add image',
                    style: TextStyle(color: redColor),
                  )),
              kHeight20,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: addController.nameEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill Your Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: 'Name'),
                ),
              ),
              kHeight10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: addController.ageEditingController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill Your Age';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Age',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: addController.domainEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill Your Domain';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: 'Domain'),
                ),
              ),
              kHeight10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: addController.numberEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your number';
                    } else if (value.length != 10) {
                      return 'Number must be 10';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: 'Number'),
                ),
              ),
              kHeight20,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueAccentColor,
                ),
                onPressed: () async {
                 
                    await addController
                        .updateStudent(student.key)
                        .then((value) {
                      clearFields();
                    });
                },
                child: Text('Add Student'),
              )
            ],
          ),
        ));
  }

  void clearFields() {
    addController.nameEditingController.clear();
    addController.ageEditingController.clear();
    addController.domainEditingController.clear();
    addController.numberEditingController.clear();
    addController.imagePicked = null;
  }
}
