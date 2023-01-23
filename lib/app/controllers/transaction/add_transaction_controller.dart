import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/data/models/transaction.dart';

import '../../../data/models/category.dart';
import '../../../data/models/wallet.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/transaction_service.dart';
import '../../core/utils/utils.dart';
import '../../core/values/r.dart';

class AddTransactionController extends GetxController {
  var pickedImage = Rxn<String>();
  var pickedDate = DateTime.now().obs;
  var selectedCategory = Rxn<Category>();
  var selectedWallet = Rxn<Wallet>();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  void pickedImageGallery() async {
    String? picked = await ImageHelper.ins.pickSingleImage();
    if (picked != null) {
      pickedImage.value = picked;
    }
  }

  void pickedImageCamera() async {
    String? picked = await ImageHelper.ins.takePictureFromCamera();
    if (picked != null) {
      pickedImage.value = picked;
    }
  }

  void deleteImage() {
    pickedImage.value = null;
  }

  createNewTransaction() async {
    if (!isValidData()) {
      EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
      return;
    }

    String? imageLink;
    if (pickedImage.value != null) {
      imageLink = await StorageService.ins
          .uploadImageToStorage(File(pickedImage.value!));
    }

    final newTran = Transaction();
    newTran.amount = int.parse(amountController.text.trim());
    newTran.walletId = selectedWallet.value!.id!;
    newTran.categoryId = selectedCategory.value!.id!;
    newTran.createdAt = pickedDate.value;
    if (noteController.text.trim().isNotEmpty) {
      newTran.note = noteController.text.trim();
    }
    if (imageLink != null) {
      newTran.image = imageLink;
    }

    EasyLoading.show();
    var res = await TransactionService.ins.createNewTransaction(newTran);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.back();
      EasyLoading.showToast(R.Transactioncreatedsuccessfully.tr);
    } else {
      EasyLoading.showToast(res.message);
    }
  }

  bool isValidData() {
    return amountController.text.isNotEmpty &&
        selectedWallet.value != null &&
        selectedCategory.value != null &&
        noteController.text.trim().isNotEmpty;
  }
}
