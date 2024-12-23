import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_getx_try1/controllers/controller.dart';
import 'package:student_getx_try1/core/colors.dart';
import 'package:student_getx_try1/core/constants.dart';
import 'package:student_getx_try1/functions/db_functions.dart';
import 'package:student_getx_try1/model/model.dart';
import 'package:student_getx_try1/widgets/textformfile.dart';

class AddstudentScreen extends StatefulWidget {
  const AddstudentScreen({super.key});

  @override
  State<AddstudentScreen> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddstudentScreen> {
  RxBool photoerror = false.obs;

  final formKey = GlobalKey<FormState>();
  RxString pickImage = RxString('');
  final StudentController studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyColor,
        centerTitle: true,
        title: const Text(
          'Add Student',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Obx(
                      () => InkWell(
                          onTap: () async {
                            final imagepath = await studentController
                                .pickImage(ImageSource.gallery);
                            pickImage.value = imagepath ?? '';
                            photoerror.value = pickImage.value.isEmpty;
                          },
                          child: CircleAvatar(
                            backgroundColor: greyColor,
                            radius: 70,
                            backgroundImage: pickImage.value.isNotEmpty
                                ? FileImage(File(pickImage.value))
                                : null,
                            child: pickImage.value.isEmpty
                                ? ClipOval(
                                    child: Image.network(
                                      'https://lh3.googleusercontent.com/V8vdLyruROpGL211Ucrzly_9ZagiG2lttAikhgnhPhy9cTs9THvPokb8O-Dv3tE4TUnDryphrnwA1ZwI_lB0MzYYSA=s1280-w1280-h800',
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.person,
                                          size: 50,
                                          color: whiteColor,
                                        );
                                      },
                                    ),
                                  )
                                : null,
                          )),
                    ),
                  ),
                  Obx(() {
                    if (photoerror.value) {
                      return const Text(
                        'Photo is required',
                        style: TextStyle(color: redColor),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  kheight20,
                  CustomTextFormfield(
                      controller: studentController.nameEditingController,
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        if (RegExp(r'\d').hasMatch(value)) {
                          return 'Numbers are not allowed';
                        }
                        if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                          return 'Special characters are not allowed';
                        }
                        return null;
                      }),
                  kheight10,
                  CustomTextFormfield(
                      controller: studentController.ageEditingController,
                      labelText: 'Age',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Age is required';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Only numbers are allowed';
                        }
                        if (value.length >= 3 || value.length <= 1) {
                          return 'Enter valid age';
                        }
                        return null;
                      }),
                  kheight10,
                  CustomTextFormfield(
                    controller: studentController.courseEditingController,
                    labelText: 'Course',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Course required';
                      }
                      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Special characters are not allowed';
                      }
                      return null;
                    },
                  ),
                  kheight10,
                  CustomTextFormfield(
                    controller: studentController.phoneEditingController,
                    labelText: 'Phone',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'phone required';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Only numbers are allowed';
                      }
                      if (value.length < 10 || value.length > 10) {
                        return 'Enter valid phone number';
                      }

                      return null;
                    },
                  ),
                  kheight10,
                  CustomTextFormfield(
                      controller: studentController.placeEditingController,
                      labelText: 'Place',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Place is required';
                        }
                        if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                          return 'Special characters are not allowed';
                        }
                        return null;
                      }),
                  kheight10,
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (pickImage.value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: redColor,
                                content: Text(
                                  'Please select an image',
                                  style: TextStyle(color: whiteColor),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          } else {
                            addStudentButtonClicked();
                            Get.back();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greyColor,
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: whiteColor, fontSize: 18),
                      ))
                ],
              ),
            )),
      ),
    );
  }

  Future<void> addStudentButtonClicked() async {
    try {
      final name = studentController.nameEditingController.text.trim();
      final age = studentController.ageEditingController.text.trim();
      final place = studentController.placeEditingController.text.trim();
      final course = studentController.courseEditingController.text.trim();
      final phone = studentController.phoneEditingController.text.trim();

      if (name.isEmpty ||
          age.isEmpty ||
          place.isEmpty ||
          course.isEmpty ||
          phone.isEmpty) {
        return;
      }

      final student = StudentModel(
          name: name,
          age: age,
          place: place,
          course: course,
          image: pickImage.value,
          phone: int.parse(phone));

      await addStudent(student);

      studentController.nameEditingController.clear();
      studentController.ageEditingController.clear();
      studentController.placeEditingController.clear();
      studentController.courseEditingController.clear();
      studentController.phoneEditingController.clear();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding student $e');
      }
    }
  }
}
