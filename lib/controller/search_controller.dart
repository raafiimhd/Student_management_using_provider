import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/model/model.dart';
import 'package:student_management/services/services.dart';
import 'package:student_management/view/screen_home/add_student_Screen/add_Student_screen.dart';

class SearchControllerGet extends GetxController {
  List<StudentModel> searchedstudent = [];
  final searchcontroller1 = TextEditingController();
   String _searchQuery = '';

  searchStudent() {
    searchedstudent = addController.students
        .where((element) => element.name.contains(_searchQuery.toLowerCase()))
        .toList();
    update();
  }
  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('students');
    // ignore: invalid_use_of_protected_member
    searchedstudent.clear();
    // ignore: invalid_use_of_protected_member
    searchedstudent.addAll(studentDB.values);
    // update();
  }
}
