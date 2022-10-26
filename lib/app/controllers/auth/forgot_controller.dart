import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/data/services/auth_service.dart';

import '../../routes/routes.dart';

class ForgotPassController extends GetxController {
  var isSecureText = true.obs;

  //----------------------------------------------------
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();
  final rePassTextController = TextEditingController();
  String? secureCode;

  void toVerifyScreen() async {
    if (emailTextController.text.isNotEmpty) {
      EasyLoading.show();
      var res =
          await AuthService.ins.forgotPassword(email: emailTextController.text);
      EasyLoading.dismiss();

      if (res.isOk) {
        Get.toNamed(verifyForgotRoute);
      } else {
        EasyLoading.showToast("Error");
      }
    } else {
      EasyLoading.showToast("Pleaseenteralltheinformation".tr);
    }
  }

  void changeSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  void verifyCodeFunc() async {
    if (secureCode != null) {
      EasyLoading.show();
      var res = await AuthService.ins.verifyResetPassword(
          email: emailTextController.text, otp: secureCode!);
      EasyLoading.dismiss();

      if (res.isOk) {
        Get.offAllNamed(resetPassRoute);
      } else {
        EasyLoading.showToast("Error");
      }
    } else {
      EasyLoading.showToast("Incorectcode".tr);
    }
  }

  void setNewPassFunc() async {
    if (passTextController.text.isNotEmpty &&
        rePassTextController.text.isNotEmpty) {
      if (passTextController.text == rePassTextController.text) {
        EasyLoading.show();
        var res = await AuthService.ins.resetPassword(
            email: emailTextController.text,
            password: rePassTextController.text);
        EasyLoading.dismiss();

        if (res.isOk) {
          Get.offAllNamed(loginScreenRoute);
        } else {
          EasyLoading.showToast(res.message);
        }
      } else {
        EasyLoading.showToast("Incorectpassword".tr);
      }
    } else {
      EasyLoading.showToast("Pleaseenteralltheinformation".tr);
    }
  }
}
