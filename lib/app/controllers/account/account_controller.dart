import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../core/utils/utils.dart';
import '../../core/values/theme.dart';

class AccountController extends GetxController {
  var isDarkMode = false.obs;

  void pickAvatar() async {
    String? picked = await ImageHelper.ins.pickAvatar();
  }

  void toMyWalletScreen() {
    Get.toNamed(myWalletRoute);
  }

  void toSettingScreen() {
    Get.toNamed(settingRoute);
  }

  void toLoginScreen() {
    Get.offAllNamed(loginScreenRoute);
  }

  void changeThemeMode(bool val) {
    isDarkMode.value = val;
    if (val) {
      Get.changeTheme(AppColors.darkTheme);
    } else {
      Get.changeTheme(AppColors.lightTheme);
    }
  }
}
