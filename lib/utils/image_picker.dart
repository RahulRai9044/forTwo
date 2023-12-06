import 'dart:io';

import 'package:flutter/material.dart';
import 'package:for_two/utils/app_theme.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:

class MediaPicker {
  MediaPicker._();

  static const supportedImageFormates = [".jpeg", ".png"];
  static const supportedVedioFormates = [".mp4"];
  static final picker = ImagePicker();

  // Single image / video selection
  static Future<File?> pickMedia({
    required ImageSource source,
    bool isVideo = false,
    bool isEditing = false,
  }) async {
    try {
      final pickMedia = !isVideo
          ? await picker.pickImage(source: source)
          : await picker.pickVideo(source: source);

      if (pickMedia != null) {
        return isEditing
            ? await editImage(file: File(pickMedia.path))
            : File(pickMedia.path);
      } else {
        return null;
      }
    } catch (ex) {
      print("Pick Media error: $ex");
      return null;
    }
  }

  static Future<File> editImage({required File file}) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: buttonFirstColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return file;
    }
  }
}