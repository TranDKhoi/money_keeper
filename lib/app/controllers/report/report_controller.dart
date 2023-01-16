import 'package:get/get.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../../data/models/wallet.dart';
import '../../core/values/r.dart';
import '../wallet/my_wallet_controller.dart';

class ReportController extends GetxController {
  var selectedWallet = Wallet().obs;
  var listWallet = <Wallet>[].obs;
  var listTimeline = [].obs;
  var selectedTimeLine = Rxn<String>();

  ReportController() {
    var walletController = Get.find<MyWalletController>();
    listWallet.value = [...walletController.listWallet];
    var totalWallet =
        Wallet(name: R.Totalwallet.tr, balance: _calculateTotalBalance());
    listWallet.value = [totalWallet, ...walletController.listWallet];
    selectedWallet.value = listWallet[0];

    generateTimeLine();
  }

  void changeWallet(Wallet value) {
    selectedWallet.value = value;
  }

  void changeTimeLine(int index) {
    selectedTimeLine.value = listTimeline[index];
  }

  void toIncomeDetailsScreen() {
    Get.toNamed(incomeDetailRoute);
  }

  void toExpenseDetailsScreen() {
    Get.toNamed(expenseDetailRoute);
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
        for (int i = 1; i <= DateTime.now().month + 1; i++) {
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

  _calculateTotalBalance() {
    int total = 0;
    for (int i = 0; i < listWallet.length; i++) {
      total += listWallet[i].balance!;
    }
    return total;
  }
}
