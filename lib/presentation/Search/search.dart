// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx_try1/controllers/controller.dart';
import 'package:student_getx_try1/core/colors.dart';
import 'package:student_getx_try1/core/constants.dart';
import 'package:student_getx_try1/widgets/dialog.dart';

final StudentController studentController = Get.put(StudentController());

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    studentController.fetchAllStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyColor,
        centerTitle: true,
        title: const Text(
          'Search Students',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                studentController.search(value);
              },
              decoration: InputDecoration(
                labelText: 'Search here..',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (studentController.filteredStudents.isEmpty) {
                return const Center(
                  child: Text('No students found'),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => kheight10,
                  itemCount: studentController.filteredStudents.length,
                  itemBuilder: (context, index) {
                    var student = studentController.filteredStudents[index];
                    return GestureDetector(
                      onTap: () {
                        StudentDialogue.showStudentDialog(
                          context,
                          student,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: greyColor,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (student.image != null &&
                                student.image.isNotEmpty &&
                                File(student.image).existsSync())
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(student.image)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            else
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 36),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student.name ?? 'name',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Course: ${student.course ?? 'course'}',
                                    style: const TextStyle(
                                      color: whiteColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Age: ${student.age ?? 'age'}',
                                    style: const TextStyle(
                                      color: whiteColor,
                                      fontSize: 18,
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
            }),
          ),
        ],
      ),
    );
  }
}
