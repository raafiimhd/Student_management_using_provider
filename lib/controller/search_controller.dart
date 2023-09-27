import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/controller/addstudent_controller.dart';
import 'package:student_management/model/model.dart';

class SearchControllerGet extends ChangeNotifier {
  List<StudentModel> searchedstudent = [];
  List<StudentModel> all = [];
  final searchcontroller1 = TextEditingController();
 searchStudent(String query)  {
    searchedstudent =all
        .where((element) => element.name.contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
  
  // void updateSearchQuery(String query) {
  //   _searchQuery = query;
  //   searchStudent();
  // }
  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('students');
    // ignore: invalid_use_of_protected_member
    all.clear();
    // ignore: invalid_use_of_protected_member
    all.addAll(studentDB.values);
    // update();
  }

  // void updateQueryChange(String query) {
  //   searchedQuery = query;
  //   notifyListeners();
  // }
}

