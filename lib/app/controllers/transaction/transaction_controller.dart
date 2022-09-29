import 'dart:async';

import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

class TransactionController extends GetxController {
  var selectedWallet = "Ví tổng".obs;
  List<String> listWallet = ["Ví tổng", 'One', 'Two', 'Three', 'Four'];
  var listTimeline = [].obs;
  var selectedTimeLine = Rxn<String>();

  TransactionController() {
    generateTimeLine();
  }

  void toCreateTransactionScreen() {
    Get.toNamed(addTransactionRoute);
  }

  void toEditTransactionScreen() {
    Get.toNamed(editTransactionRoute);
  }

  void changeWallet(String value) {
    selectedWallet.value = value;
  }

  void changeTimeLine(int index) {
    selectedTimeLine.value = listTimeline[index];
  }

  void generateTimeLine() {
    for (int j = 1; j <= 2; j++) {
      for (int i = 1; i <= 12; i++) {
        if (i > DateTime.now().month + 1) continue;
        String time = "$i/202$j";
        if (time.contains("${DateTime.now().month - 1}/${DateTime.now().year}"))
          time = "Lastmonth".tr;
        if (time.contains("${DateTime.now().month}/${DateTime.now().year}"))
          time = "Thismonth".tr;
        if (time.contains("${DateTime.now().month + 1}/${DateTime.now().year}"))
          time = "Nextmonth".tr;
        listTimeline.add(time);
      }
    }
  }
}
