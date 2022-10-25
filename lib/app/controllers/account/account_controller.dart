import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/localization_service.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../../data/models/user.dart';
import '../../core/utils/utils.dart';
import '../../core/values/theme.dart';

class AccountController extends GetxController {
  var isDarkMode = false.obs;
  var isVietnamese = false.obs;
  var currentUser = Rxn<User>();

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
    Get.offAllNamed(mainAuthScreenRoute);
  }

  void changeThemeMode(bool val) {
    isDarkMode.value = val;
    if (val) {
      Get.changeTheme(AppColors.darkTheme);
    } else {
      Get.changeTheme(AppColors.lightTheme);
    }
  }

  void changeLanguage(bool val) {
    isVietnamese.value = val;
    if (val) {
      LocalizationService.changeLocale("vi");
    } else {
      LocalizationService.changeLocale("en");
    }
  }
}
