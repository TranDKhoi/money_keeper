import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class ForgotPassController extends GetxController {
  var isSecureText = true.obs;

  //----------------------------------------------------
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();
  final rePassTextController = TextEditingController();
  int? secureCode;

  void toVerifyScreen() {
    if (emailTextController.text.isNotEmpty) {
      Get.toNamed(verifyForgotRoute);
    } else {
      EasyLoading.showToast("Pleaseenteralltheinformation".tr);
    }
  }

  void changeSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  void verifyCodeFunc() {
    if (secureCode != null && secureCode == 000000) {
      Get.offAllNamed(resetPassRoute);
    } else {
      EasyLoading.showToast("Incorectcode".tr);
    }
  }

  void setNewPassFunc() {
    if (passTextController.text.isNotEmpty &&
        rePassTextController.text.isNotEmpty) {
      if (passTextController.text == rePassTextController.text) {
        Get.offAllNamed(loginScreenRoute);
      } else {
        EasyLoading.showToast("Incorectpassword".tr);
      }
    } else {
      EasyLoading.showToast("Pleaseenteralltheinformation".tr);
    }
  }
}
