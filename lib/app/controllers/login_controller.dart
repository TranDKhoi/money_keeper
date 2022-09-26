import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class LoginController extends GetxController {
  var isSecureText = true.obs;

  //----------------------------------------------------
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();
  int? secureCode;

  void changeSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  void loginFunc() {
    if (isValidData()) {
      //login api
    } else {
      EasyLoading.showToast("Vui lòng điền đủ thông tin");
    }
  }

  void toVerifyScreen() {
    if (emailTextController.text.isNotEmpty) {
      Get.toNamed(verifyForgotRoute);
    } else {
      EasyLoading.showToast("Vui lòng điền đủ thông tin");
    }
  }

  void verifyCodeFunc() {
    if (secureCode != null && secureCode == 000000) {
      EasyLoading.showToast("ok roi nha");
    }
  }

  bool isValidData() {
    return emailTextController.text.isNotEmpty &&
        passTextController.text.isNotEmpty;
  }
}
