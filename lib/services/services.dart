import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/model/model.dart';

//hiveAllFunctions
class Services {
  Future<void> addStudent(StudentModel student) async {
    final box = await Hive.openBox<StudentModel>('students');
    await box.add(student);
  }

  Future<List<StudentModel>> getStudent() async {
    final box = await Hive.openBox<StudentModel>('students');
    List<StudentModel> studentList = box.values.toList();
    return studentList;
  }

  Future<void> delete(int id) async {
    final box = await Hive.openBox<StudentModel>('students');
    await box.delete(id);
    getStudent();
  }

  Future<void> update(StudentModel student, int key) async {
    final box = await Hive.openBox<StudentModel>('students');
    box.put(key, student);
  }
}
