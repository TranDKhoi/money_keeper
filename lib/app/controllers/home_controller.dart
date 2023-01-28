import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../data/models/transaction.dart';
import '../../data/services/transaction_service.dart';

class HomeController extends GetxController {
  var selectedReport = 1.obs;
  var transactions = <Transaction>[].obs;

  void changeSelectedReport() {
    selectedReport.value = selectedReport.value == 0 ? 1 : 0;
    getSummaryData();
  }

  void toAllWalletScreen() {
    Get.toNamed(myWalletRoute);
  }

  void toEditTransactionScreen() {
    // Get.to(()=> EditTransactionScreen(selectedTrans: Transaction(),));
  }

  getSummaryData() {
    if (selectedReport.value == 0) {}
  }

  getRecentTransaction() async {
    var res = await TransactionService.ins.getRecentlyTrans();
    if (res.isOk) {
      transactions.value = [];
      for (int i = 0; i < res.data.length; i++) {
        transactions.add(Transaction.fromJson(res.data[i]));
      }
    }
  }
}
