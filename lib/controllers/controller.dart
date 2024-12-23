import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_getx_try1/functions/db_functions.dart';
import 'package:student_getx_try1/model/model.dart';

class StudentController extends GetxController {
  var students = <StudentModel>[].obs;
  var filteredStudents = <StudentModel>[].obs;

  final nameEditingController = TextEditingController();
  final ageEditingController = TextEditingController();
  final placeEditingController = TextEditingController();
  final courseEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAllStudents();
  }

  Future<void> fetchAllStudents() async {
    try {
      final fetchedStudents = await getAllStudents();
      students.assignAll(fetchedStudents);
      filteredStudents.assignAll(fetchedStudents);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching students $e');
      }
    }
  }

  Future<void> insertStudent(StudentModel student) async {
    try {
      await addStudent(student);
      fetchAllStudents();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding student $e');
      }
    }
  }

  Future<void> updateStudentData(StudentModel student) async {
    try {
      await updateStudent(student);
      fetchAllStudents();
    } catch (e) {
      if (kDebugMode) {
        print('Error updating student $e');
      }
    }
  }

  Future<void> deleteStudent(StudentModel student) async {
    try {
      await deleteStudent(student);
      fetchAllStudents();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting student $e');
      }
    }
  }

  void search(String query) {
    final lowercaseQuery = query.toLowerCase();
    if (lowercaseQuery.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(
        students.where((student) {
          return student.name.toLowerCase().contains(lowercaseQuery);
        }).toList(),
      );
    }
  }

  Future<String?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        return pickedFile.path;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Image picking error $e');
      }
      return null;
    }
  }
}
