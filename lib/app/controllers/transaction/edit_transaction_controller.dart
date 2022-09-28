import 'dart:async';

import 'package:get/get.dart';

import '../../core/utils/utils.dart';

class EditTransactionController extends GetxController {
  var pickedImage = Rxn<String>();
  var pickedDate = DateTime.now().obs;

  EditTransactionController() {
    print("createeee");
  }

  void pickedImageGallery() async {
    String? picked = await ImageHelper.ins.pickSingleImage();
    if (picked != null) pickedImage.value = picked;
  }

  void pickedImageCamera() async {
    String? picked = await ImageHelper.ins.takePictureFromCamera();
    if (picked != null) pickedImage.value = picked;
  }

  void deleteImage() {
    pickedImage.value = null;
  }
}
