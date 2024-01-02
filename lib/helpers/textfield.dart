import 'package:flutter/material.dart';

TextFormField textFields(
    {required TextEditingController controller, required String text}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: text),
  );
}
