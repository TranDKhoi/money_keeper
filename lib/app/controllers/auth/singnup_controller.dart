import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/get_storage_service.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:money_keeper/data/services/auth_service.dart';

import '../../../data/models/user.dart';

class SignupController extends GetxController {
  var isSecureText = true.obs;

  //----------------------------------------------------
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  String? secureCode;

  void changeSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  toVerifyScreen() async {
    if (isValidData()) {
      var u = User(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim());
      EasyLoading.show();
      var res = await AuthService.ins.signUp(user: u);
      EasyLoading.dismiss();

      if (res.isOk) {
        Get.toNamed(verifySignupRoute);
      } else {
        EasyLoading.showToast(res.message);
      }
    } else {
      EasyLoading.showToast("Pleaseenteralltheinformation".tr);
    }
  }

  void verifyCodeFunc() async {
    if (secureCode != null) {
      EasyLoading.show();
      var res = await AuthService.ins
          .verifyAccount(email: emailTextController.text, code: secureCode!);
      EasyLoading.dismiss();

      if (res.isOk) {
        Get.toNamed(bottomBarRoute);
        GetStorageService.ins.setUserToken(res.data["token"]);
      } else {
        EasyLoading.showToast("Incorectcode".tr);
      }
    }
  }

  bool isValidData() {
    return emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty;
  }
}
