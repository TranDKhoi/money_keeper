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
      EasyLoading.showToast("Vui lòng điền đủ thông tin");
    }
  }

  void changeSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  void verifyCodeFunc() {
    if (secureCode != null && secureCode == 000000) {
      Get.offAllNamed(resetPassRoute);
    } else {
      EasyLoading.showToast("Mã không hợp lệ");
    }
  }

  void setNewPassFunc() {
    if (passTextController.text.isNotEmpty &&
        rePassTextController.text.isNotEmpty) {
      if (passTextController.text == rePassTextController.text) {
        Get.offAllNamed(loginScreenRoute);
      } else {
        EasyLoading.showToast("Mật khẩu không khớp");
      }
    } else {
      EasyLoading.showToast("Vui lòng điền đủ thông tin");
    }
  }
}
