import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/controller/addstudent_controller.dart';
import 'package:student_management/core/colors.dart';
import 'package:student_management/core/const.dart';

AddStudentController addController = Get.put(AddStudentController());

class AddStudentScreen extends StatelessWidget {
  AddStudentScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'AddStuentScreen',
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
          ),
          backgroundColor: blueAccentColor,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        addController.imagePicked != null) {
                      addController.submit().then((value) {
                        clearFields();
                      });
                    } else {
                      Visibility(
                          child: Text(
                        'Please Upload Image',
                        style: TextStyle(color: redColor),
                      ));
                      addController.VisibleErrorMsg();
                    }
                  },
                  child: Text('Add Student'),
                )
              ],
            ),
          ),
        )));
  }

  void clearFields() {
    addController.nameEditingController.clear();
    addController.ageEditingController.clear();
    addController.domainEditingController.clear();
    addController.numberEditingController.clear();
    addController.imagePicked = null;
  }
}
