import 'dart:async';

import 'package:get/get.dart';

import '../../core/utils/utils.dart';

class AddTransactionController extends GetxController {
  String pickedImage = "";
  var pickedDate = DateTime.now().obs;

  final StreamController<String> _imageStreamController =
      StreamController<String>();

  Stream<String> get imageStream => _imageStreamController.stream;

  void pickedImageGallery() async {
    String? picked = await ImageHelper.ins.pickSingleImage();
    if (picked != null) pickedImage = picked;
    _imageStreamController.sink.add(pickedImage);
  }

  void pickedImageCamera() async {
    String? picked = await ImageHelper.ins.takePictureFromCamera();
    if (picked != null) pickedImage = picked;
    _imageStreamController.sink.add(pickedImage);
  }

  void deleteImage() {
    pickedImage = "";
    _imageStreamController.sink.add("");
    notifyChildrens();
  }
}
