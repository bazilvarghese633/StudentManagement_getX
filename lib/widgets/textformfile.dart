import 'package:flutter/material.dart';
import 'package:student_getx_try1/core/constants.dart';

class CustomTextFormfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  const CustomTextFormfield(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontFamily: 'poppins'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: focusedBorder,
      ),
    );
  }
}
