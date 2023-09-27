import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_management/model/model.dart';

class StudentProvider extends ChangeNotifier {
  // Initialize Hive box
  late Box<StudentModel> _studentBox;
  List<StudentModel> _studentList = [];
  StudentProvider() {
    initializeHiveBox();
  }

  // Initialize the Hive box for students
  Future<void> initializeHiveBox() async {
    _studentBox = await Hive.openBox<StudentModel>('students');
    _studentList = _studentBox.values.toList();
    notifyListeners();
  }

  List<StudentModel> get students => _studentList;
  // Add a new student to the Hive box
  Future<void> addStudent(StudentModel value) async {
    await _studentBox.add(value);
    _studentList.add(value);
    notifyListeners();
  }

  // Get a list of all students from the Hive box
  Future<List<StudentModel>> getStudent() async {
    final box = await Hive.openBox<StudentModel>('students');
    _studentList.clear();
    _studentList.addAll(box.values);
    return _studentList;
  }

  // Delete a student by ID from the Hive box
  Future<void> delete(int id) async {
    final box = await Hive.openBox<StudentModel>('students');
    await box.delete(id);
    getStudent();
  }

  // Update a student by ID in the Hive box
  Future<void> update(int key, StudentModel value) async {
    final box = await Hive.openBox<StudentModel>('students');
    await box.put(key, value);
  }
}
