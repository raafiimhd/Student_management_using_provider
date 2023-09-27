import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management/model/model.dart';
import 'package:student_management/services/services.dart';
import 'package:student_management/view/list_of_student_screen/list_of_student_screen.dart';

class AddStudentController extends ChangeNotifier {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController ageEditingController = TextEditingController();
  final TextEditingController domainEditingController = TextEditingController();
  final TextEditingController numberEditingController = TextEditingController();
  bool isVisible = false;
  File? imagePicked;
  List<StudentModel> students = [];

  void visibleErrorMsg() {
    if (imagePicked == null) {
      isVisible = true;
    } else {
      isVisible = false;
    }
    notifyListeners();
  }

  Future<void> getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) {
      return;
    } else {
      imagePicked = File(image.path);
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Adding Data...'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    final student = StudentModel(
      name: nameEditingController.text,
      age: ageEditingController.text,
      domain: domainEditingController.text,
      number: numberEditingController.text,
      image: imagePicked!.path,
    );

    await Provider.of<StudentProvider>(context, listen: false)
        .addStudent(student);
    await Provider.of<StudentProvider>(context, listen: false).getStudent();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ListOfStudentScreen(),
    ));
  }

  Future<void> getAllStudentsFromDb(BuildContext context) async {
    students =
        await Provider.of<StudentProvider>(context, listen: false).getStudent();
    notifyListeners();
  }

  Future<void> deleteStudent(int id, BuildContext context) async {
    await StudentProvider().delete(id);
    await getAllStudentsFromDb(context);
  }

  Future<void> updated(int key,StudentModel student,) async {
    await StudentProvider().update(key, student);
  }

  Future<void> updateStudent(int id, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saving...'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );

    final studentModel = StudentModel(
      name: nameEditingController.text,
      age: ageEditingController.text,
      domain: domainEditingController.text,
      number: numberEditingController.text,
      image: imagePicked!.path,
    );

    updated(id,studentModel);
    await getAllStudentsFromDb(context);
    Navigator.of(context).pop();
  }

  void setInitialValues(StudentModel student) {
    nameEditingController.text = student.name;
    ageEditingController.text = student.age;
    domainEditingController.text = student.domain;
    numberEditingController.text = student.number;
    imagePicked = File(student.image);
  }
}
