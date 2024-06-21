import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shoper/constants/flutter_toast.dart'; // Assuming this is for error messages

Future<List<File>> pickImages() async {
  List<File> selectedImages = [];

  try {
    final List<XFile> images = await ImagePicker().pickMultiImage();
    selectedImages = images.map((image) => File(image.path)).toList();
    } on Exception catch (e) {
    errorsMessage(e.toString()); // Assuming this displays an error message
  }

  return selectedImages; // Return the list of selected image files
}
