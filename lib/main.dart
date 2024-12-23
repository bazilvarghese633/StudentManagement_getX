import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:student_getx_try1/controllers/controller.dart';
import 'package:student_getx_try1/core/colors.dart';
import 'package:student_getx_try1/functions/db_functions.dart';
import 'package:student_getx_try1/presentation/Home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudentController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
          inputDecorationTheme: InputDecorationTheme(iconColor: greyColor)),
      title: 'Student Management',
      home: ScreenHome(),
    );
  }
}
