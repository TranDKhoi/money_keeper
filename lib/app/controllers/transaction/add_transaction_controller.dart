import 'dart:async';

import 'package:get/get.dart';

import '../../../data/models/category.dart';
import '../../../data/models/wallet.dart';
import '../../core/utils/utils.dart';
import '../../core/values/r.dart';

class AddTransactionController extends GetxController {
  var pickedImage = Rxn<String>();
  var pickedDate = DateTime.now().obs;
  var selectedType = Rxn<String>();
  var selectedCategory = Rxn<Category>();
  var selectedWallet = Rxn<Wallet>();

  var listType = [R.Income.tr, R.Expense.tr];

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

  void changeType(String val) {
    selectedType.value = val;
  }
}
