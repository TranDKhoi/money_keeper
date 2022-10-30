import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import 'app/app.dart';
import 'app/core/utils/get_storage_service.dart';
import 'app/core/utils/localization_service.dart';
import 'app/core/values/theme.dart';
import 'data/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigHelper.configLoadingBar();
  await GetStorage.init();
  _getUserToken();
  _getAppTheme();
  runApp(const App());
}

void _getUserToken() {
  final ac = Get.put(AccountController());
  var token = GetStorageService.ins.getUserToken();
  if (token != null) {
    //get user by id
    ac.currentUser.value = User(id: token);
  }
}

void _getAppTheme() {
  final ac = Get.find<AccountController>();
  var isDark = GetStorageService.ins.getAppTheme();
  ac.isDarkMode.value = isDark;

  if (isDark) {
    Get.changeTheme(AppColors.darkTheme);
  } else {
    Get.changeTheme(AppColors.lightTheme);
  }

  //Get language here
  var isVN = GetStorageService.ins.getAppLanguage();
  ac.isVietnamese.value = isVN;

  if (isVN) {
    LocalizationService.currentLocale = const Locale("vi", "VN");
  } else {
    LocalizationService.currentLocale = const Locale("en", "US");
  }
}
