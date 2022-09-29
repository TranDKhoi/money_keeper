import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

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
     Get.toNamed(bottomBarRoute);
    } else {
      EasyLoading.showToast("Pleaseenteralltheinformation".tr);
    }
  }

  bool isValidData() {
    return emailTextController.text.isNotEmpty &&
        passTextController.text.isNotEmpty;
  }
}
