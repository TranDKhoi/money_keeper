import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Utils {
  static void configLoadingBar() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..indicatorColor = Colors.green
      ..userInteractions = false
      ..dismissOnTap = false
      ..textColor = Colors.black
      ..toastPosition = EasyLoadingToastPosition.bottom;
  }
}

extension GetSize on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}
