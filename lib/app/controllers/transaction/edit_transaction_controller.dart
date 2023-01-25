import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/transaction/transaction_controller.dart';
import 'package:money_keeper/data/models/transaction.dart';

import '../../../data/services/storage_service.dart';
import '../../../data/services/transaction_service.dart';
import '../../core/utils/utils.dart';
import '../../core/values/r.dart';

class EditTransactionController extends GetxController {
  var pickedImage = Rxn<String>();

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

  updateTransaction(Transaction editTrans) async {
    if (!isValidData(editTrans)) {
      EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
      return;
    }

    String? imageLink;
    if (pickedImage.value != null) {
      imageLink = await StorageService.ins
          .uploadImageToStorage(File(pickedImage.value!));
    }

    final newTran = Transaction();
    editTrans.walletId = editTrans.wallet!.id;
    editTrans.categoryId = editTrans.category!.id;
    if (editTrans.note?.trim().isEmpty ?? true) {
      newTran.note = null;
    }
    if (imageLink != null) {
      editTrans.image = imageLink;
    }

    EasyLoading.show();
    var res = await TransactionService.ins.updateTransaction(editTrans);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.back();
      Get.find<TransactionController>().getTransactionByWalletId();
      EasyLoading.showToast(R.Transactioneditedsuccessfully.tr);
    }
  }

  bool isValidData(Transaction editTrans) {
    return editTrans.amount.toString().trim().isNotEmpty &&
        (editTrans.note != null || editTrans.note!.trim().isNotEmpty);
  }

  deleteTransaction(Transaction tempTrans) async {
    EasyLoading.show();
    var res = await TransactionService.ins.deleteTransaction(tempTrans);
    EasyLoading.dismiss();
    if (res.isOk) {
      Get.back();
      Get.find<TransactionController>().getTransactionByWalletId();
    } else {
      EasyLoading.showToast(res.statusText!);
    }
  }
}
