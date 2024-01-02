import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeProviders extends ChangeNotifier {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  File? file;
  var selectedGroups = 'A+';
  ImagePicker image = ImagePicker();
  Future<void> getCam(ImageSource source) async {
    var img = await image.pickImage(source: source);
    file = File(img!.path);
    notifyListeners();
  }

  dropdownValuechange(newValue) {
    selectedGroups = newValue;
    notifyListeners();
  }
}
