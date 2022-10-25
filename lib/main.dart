import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigHelper.configLoadingBar();
  final controller = Get.put(AccountController());
  runApp(const App());
}
