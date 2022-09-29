import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

class SignupController extends GetxController{
  var isSecureText = true.obs;

  //----------------------------------------------------
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  int? secureCode;

  void changeSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  void toVerifyScreen() {
    if (isValidData()) {
      Get.toNamed(verifySignupRoute);
    } else {
      EasyLoading.showToast("Pleaseenteralltheinformation".tr);
    }
  }

  void verifyCodeFunc() {
    if (secureCode != null && secureCode == 000000) {
      EasyLoading.showToast("ok roi nha");
    }
  }

  bool isValidData() {
    return emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty;
  }
}
