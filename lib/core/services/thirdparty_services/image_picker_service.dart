import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/exceptions/logger.dart';

class NetServeImagePicker {
  Future<void> pickImage({
    required ImageSource source,
    required ValueNotifier<List<File>> images,
  }) async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: source);
      images.value = [...images.value, File(image!.path)];
    } catch (e) {
      debugLog(e);
      return;
    }
  }

  Future<void> pickMultiImage({
    required ImageSource source,
    required ValueNotifier<List<File>> images,
  }) async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickMultiImage();
      var newImage = image.length > 7
          ? image.map((e) => File(e.path)).toList()
          : image.map((e) => File(e.path)).take(6).toList();
      images.value = [...images.value, ...newImage];
    } catch (e) {
      debugLog(e);
      return;
    }
  }
}

final imagePickerService = Provider((_) => NetServeImagePicker());
