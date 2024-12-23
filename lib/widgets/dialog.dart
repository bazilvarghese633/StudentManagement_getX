import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx_try1/core/colors.dart';
import 'package:student_getx_try1/core/constants.dart';
import 'package:student_getx_try1/model/model.dart';
import 'package:student_getx_try1/presentation/Details/details.dart';
import 'package:student_getx_try1/widgets/delete_dialog.dart';

class StudentDialogue {
  static void showStudentDialog(BuildContext context, StudentModel student) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(UpdateScreen(student: student));
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 26,
                    color: greyColor,
                  ),
                )
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: student.image.isNotEmpty &&
                            File(student.image).existsSync()
                        ? FileImage(File(student.image))
                        : const AssetImage('assets/default_avatar.png')
                            as ImageProvider,
                  ),
                ),
                kheight20,
                dialogText('Name:', student.name),
                kheight10,
                dialogText('Age:', student.age),
                kheight10,
                dialogText('Course:', student.course),
                kheight10,
                dialogText('Place:', student.place),
                kheight10,
                dialogText('Phone:', student.phone.toString()),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      DeleteDialog.deletedialog(context, student);
                    },
                    icon: const Icon(Icons.delete, color: whiteColor),
                    label: const Text(
                      'Delete',
                      style: TextStyle(color: whiteColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greyColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(color: greyColor),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  static Widget dialogText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: greyColor,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
                fontSize: 16, color: blackColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
