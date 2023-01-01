import 'dart:async';

import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../core/values/r.dart';

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
    int yearStep = 1;
    while (yearStep <= 2) {
      if (yearStep == 1) {
        for (int i = 1; i <= 12; i++) {
          String time = "$i/${DateTime.now().year - 1}";
          listTimeline.add(time);
        }
      } else if (yearStep == 2) {
        for (int i = 1; i <= DateTime.now().month+1; i++) {
          String time = "$i/${DateTime.now().year}";
          if (i == DateTime.now().month - 1) time = R.Lastmonth.tr;
          if (i == DateTime.now().month) time = R.Thismonth.tr;
          if (i == DateTime.now().month + 1) time = R.Nextmonth.tr;
          listTimeline.add(time);
        }
      }
      yearStep++;
    }
    for (int i = 0; i < listTimeline.length; i++) {
      if (listTimeline[i] == R.Thismonth.tr) {
        listTimeline[i - 1] = R.Lastmonth.tr;
      }
    }
  }
}
