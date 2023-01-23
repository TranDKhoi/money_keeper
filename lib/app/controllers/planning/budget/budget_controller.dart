import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:money_keeper/app/core/utils/utils.dart';

import '../../../../data/models/category.dart';
import '../../../../data/models/wallet.dart';
import '../../../../data/services/category_service.dart';
import '../../../core/values/r.dart';
import '../../wallet/my_wallet_controller.dart';

class BudgetController extends GetxController {
  var listTimeline = [].obs;
  var selectedTimeLine = Rxn<String>();
  var listWallet = <Wallet>[].obs;
  var selectedWallet = Wallet().obs;
  var listCateBudget = <Category>[].obs;

  BudgetController() {
    listWallet.value = List.from(Get.find<MyWalletController>().listWallet);
    if (listWallet.isEmpty) {
      EasyLoading.showToast(R.Walleterror);
      return;
    }
    selectedWallet.value = listWallet[0];
    _getListCategoryOfWallet(selectedWallet.value.id!);
    generateTimeLine();
    _calculatePositionByMonth();
  }

  void changeWallet(Wallet value) {
    selectedWallet.value = value;
    _getListCategoryOfWallet(selectedWallet.value.id!);
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
        for (int i = 1; i <= DateTime.now().month; i++) {
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

  //this logic is for the indicator and cursor position
  double _cursorPosition = 1; // only from 0 to 290
  double get cursorPosition => _cursorPosition <= 0 ? 5 : _cursorPosition * 295;

  void _calculatePositionByMonth() {
    int dayInMonth = DTU.getDaysInMonth(2022, 12);
    int today = DateTime.now().day;
    if (today == 1) today = 0;

    double diffPercentage = today / dayInMonth;

    _cursorPosition *= diffPercentage;
  }

  Future<void> _getListCategoryOfWallet(int id) async {
    EasyLoading.show();
    var res = await CategoryService.ins.getCategoryByWalletId(id);
    EasyLoading.dismiss();

    if (res.isOk) {
      listCateBudget.value = [];
      for (int i = 0; i < res.data.length; i++) {
        if (Category.fromJson(res.data[i]).type == "Expense") {
          listCateBudget.add(Category.fromJson(res.data[i]));
        }
      }
    } else {
      EasyLoading.showToast("Server Error");
    }
  }
}
