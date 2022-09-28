import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ConfigHelper {
  static void configLoadingBar() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..indicatorColor = Colors.green
      ..userInteractions = false
      ..dismissOnTap = false
      ..textColor = Colors.black
      ..toastPosition = EasyLoadingToastPosition.bottom;
  }
}

extension GetSize on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}

class ImageHelper {
  ImageHelper._();

  static final ins = ImageHelper._();
  final _imgPicker = ImagePicker();

  Future<String?> pickAvatar() async {
    final XFile? selected =
        await _imgPicker.pickImage(source: ImageSource.gallery);

    if (selected != null) {
      return await cropImage(selected.path);
    }
    return null;
  }

  Future<List<String>?> pickMultiImage() async {
    final List<XFile>? selected = await _imgPicker.pickMultiImage();

    if (selected != null) {
      return selected.map((e) => e.path).toList();
    }
    return null;
  }

  Future<String?> pickSingleImage() async {
    final XFile? selected =
        await _imgPicker.pickImage(source: ImageSource.gallery);

    if (selected != null) {
      return selected.path;
    }
    return null;
  }

  Future<String?> takePictureFromCamera() async {
    final XFile? selected =
        await _imgPicker.pickImage(source: ImageSource.camera);

    if (selected != null) {
      return selected.path;
    }
    return null;
  }

  Future<String?> cropImage(String path) async {
    CroppedFile? cropped = await ImageCropper()
        .cropImage(sourcePath: path, cropStyle: CropStyle.circle);

    if (cropped != null) {
      return cropped.path;
    }
    return null;
  }
}

class FormatHelper {
  String dateFormat(DateTime date) {
    String formatTime = "${date.day}-${date.month}-${date.year}";
    return formatTime;
  }
}
