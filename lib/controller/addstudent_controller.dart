import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/services/services.dart';
import 'package:student_management/model/model.dart';
import 'package:student_management/view/list_of_student_screen/list_of_student_screen.dart';
import 'package:student_management/view/screen_home/add_student_Screen/add_Student_screen.dart';
import 'package:student_management/view/screen_home/screen_home.dart';
 List<StudentModel> student = [];
class AddStudentController extends GetxController {
  final nameEditingController = TextEditingController();
  final ageEditingController = TextEditingController();
  final domainEditingController = TextEditingController();
  final numberEditingController = TextEditingController();
  bool isVisible = false;
  File? imagePicked;
  List<StudentModel> students = [];

  //imageUploadingVisible
  VisibleErrorMsg() {
    if (imagePicked == null) {
      isVisible = true;
      update();
    } else {
      isVisible = false;
      update();
    }
  }
  //imageUploadingFunction
  void getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) {
      return;
    } else {
      imagePicked = File(image.path);

      update();
    }
  }
  
  //studentAddFunction
  Future<void> submit() async {
    print('${imagePicked?.path}');
    Get.snackbar(
      'Adding Data...',
      '',
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    final student = StudentModel(
        name: nameEditingController.text,
        age: ageEditingController.text,
        domain: domainEditingController.text,
        number: numberEditingController.text,
        image: imagePicked!.path);
    await Services().addStudent(student);

    await getAllStudentsFromDb();
    Get.offAll(ScreenHome());
  }
  //readingStudentData
  Future<void> getAllStudentsFromDb() async {
    students = await Services().getStudent();
    update();
  }
  //deletingStudentData
  Future<void> deleteStudent(int id) async {
    await Services().delete(id);
    await getAllStudentsFromDb();
  }
  //editingStudentFunction
  Future<void> updated(StudentModel student, int key) async {
    await Services().update(student, key);
  }
  //updatingStudent
  Future<void> updateStudent(int key) async {
    Get.snackbar(
      'Saving...',
      '',
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
    );

    final studentModel = StudentModel(
      name: addController.nameEditingController.text,
      age: addController.ageEditingController.text,
      domain: addController.domainEditingController.text,
      number: addController.numberEditingController.text,
      image: imagePicked!.path,
    );

    updated(studentModel, key);
    await getAllStudentsFromDb();
    Get.back();
  }
  //forEditingCurrentDatas
  void setInitileValues(StudentModel student) {
    nameEditingController.text = student.name;
    ageEditingController.text = student.age;
    domainEditingController.text = student.domain;
    numberEditingController.text = student.number;
    imagePicked = File(student.image);
  }
}
