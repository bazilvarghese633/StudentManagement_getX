// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx_try1/controllers/controller.dart';
import 'package:student_getx_try1/core/colors.dart';
import 'package:student_getx_try1/core/constants.dart';
import 'package:student_getx_try1/presentation/AddStudent/addstudent.dart';
import 'package:student_getx_try1/presentation/Search/search.dart';
import 'package:student_getx_try1/widgets/dialog.dart';

final StudentController studentController = Get.put(StudentController());

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _HomepageState();
}

class _HomepageState extends State<ScreenHome> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    studentController.fetchAllStudents();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: greyColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Student List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: whiteColor,
              fontSize: 24,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {
                  Get.to(const SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
        body: Obx(
          () {
            if (studentController.students.isEmpty) {
              return const Center(
                child: Text(
                  'Please Add Student',
                  style: TextStyle(
                    fontSize: 18,
                    color: greyColor,
                  ),
                ),
              );
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => kheight10,
                itemCount: studentController.students.length,
                itemBuilder: (context, index) {
                  var student = studentController.students[index];

                  return InkWell(
                    onTap: () {
                      StudentDialogue.showStudentDialog(context, student);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: whiteColor,
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(student.image)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Course: ${student.course}',
                                  style: const TextStyle(
                                    color: whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Age: ${student.age}',
                                  style: const TextStyle(
                                    color: whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: greyColor,
          onPressed: () {
            Get.to(() => const AddstudentScreen())?.then((value) {
              studentController.fetchAllStudents();
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
