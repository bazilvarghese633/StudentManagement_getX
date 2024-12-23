import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx_try1/core/colors.dart';
import 'package:student_getx_try1/functions/db_functions.dart';
import 'package:student_getx_try1/model/model.dart';
import 'package:student_getx_try1/presentation/Home/home.dart';

class DeleteDialog {
  static Future<dynamic> deletedialog(
      BuildContext context, StudentModel student) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              'Delete Student',
              style: TextStyle(
                  color: blackColor, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Are you sure you want to delete this student? This action cannot be undone.',
              style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  deleteStudent(student.id);
                  Get.back();
                  Get.to(const ScreenHome());
                },
                child: const Text(
                  'YES',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: greyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: greyColor),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'NO',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: blackColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}
