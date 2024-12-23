import 'package:flutter/material.dart';

const kheight10 = SizedBox(height: 10);
const kheight20 = SizedBox(height: 20);
const kheight30 = SizedBox(height: 30);
const kheight45 = SizedBox(height: 45);

const kwidth10 = SizedBox(width: 10);
const kwidth20 = SizedBox(width: 20);

final border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20),
);
const focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide(color: Colors.blue),
);
