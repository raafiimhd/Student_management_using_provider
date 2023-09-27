import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management/controller/addstudent_controller.dart';
import 'package:student_management/core/colors.dart';
import 'package:student_management/model/model.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key, required this.student, required this.index});

  final StudentModel student;
  final int index;

  @override
  Widget build(BuildContext context) {
    final addController = Provider.of<AddStudentController>(context,listen: false);
    addController.setInitialValues(student);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Screen',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        backgroundColor: blueAccentColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            GestureDetector(
              onTap: () {
                addController.getImage(ImageSource.gallery);
              },
              child: Consumer<AddStudentController>(
                builder: (context, controller, _) {
                  return CircleAvatar(
                    radius: 49,
                    backgroundColor:greyColor ,
                    backgroundImage: (controller.imagePicked != null)
                        ? FileImage(controller.imagePicked!)
                        : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Visibility(
              visible: addController.isVisible,
              child: const Text(
                'Please add an image',
                style: TextStyle(color: redColor),
              ),
            ),
            const SizedBox(height: 20.0),
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
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Name',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
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
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Domain',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
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
                    return 'Number must be 10 digits';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Number',
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: ()  async{
                await addController.updateStudent(student.key,context);
              },
              child: const Text('Update Student'),
            )
          ],
        ),
      ),
    );
  }
}
